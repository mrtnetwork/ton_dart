import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/bit/bit_reader.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/serialization/models/level_mask.dart';
import 'package:ton_dart/src/boc/serialization/serialization/serialization.dart';
import 'package:ton_dart/src/boc/serialization/utils/utils.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/utils/utils/math.dart';
import 'package:ton_dart/src/utils/utils/base64.dart';
import 'cell_type.dart';

/// The `Cell` class represents a cell in the data structure, including its type, bit data,
/// references to other cells, and various metadata such as hashes and depths.
///
/// Cells can be ordinary or exotic, with exotic cells having additional characteristics
/// that are resolved using utility methods.
class Cell {
  /// Represents an empty cell with default values.
  static final Cell empty = Cell();

  /// The type of the cell, indicating its kind or usage.
  final CellType type;

  /// The bit string data contained within the cell.
  final BitString bits;

  /// List of cells that this cell references.
  final List<Cell> refs;

  /// The mask that represents the cell's level in a hierarchy.
  final LevelMask mask;

  /// Internal list of hashes used for cell identification and verification.
  final List<List<int>> _hashes;

  /// Internal list of depths corresponding to each level of the cell.
  final List<int> _depths;

  /// Returns `true` if the cell is exotic (i.e., not ordinary).
  bool get isExotic => type != CellType.ordinary;

  /// Returns the level of the cell as defined by its mask.
  int get level => mask.level;

  /// Creates a list of `Cell` instances from a binary object code (BOC).
  ///
  /// [src] The source BOC data.
  static List<Cell> fromBoc(List<int> src) {
    return BocSerialization.deserialize(src);
  }

  /// Creates a `Cell` instance from a byte array.
  ///
  /// [src] The byte data representing the cell.
  factory Cell.fromBytes(List<int> src) {
    final parsed = Cell.fromBoc(src);
    if (parsed.length != 1) {
      throw BocException("Deserialized more than one cell.",
          details: {"cells": parsed});
    }
    return parsed[0];
  }

  /// Creates a `Cell` instance from a Base64 encoded string.
  ///
  /// [src] The Base64 encoded string representing the cell.
  factory Cell.fromBase64(String src) {
    return Cell.fromBytes(Base64Utils.decodeBase64(src));
  }

  /// Creates a `Cell` instance from a hexadecimal string.
  ///
  /// [src] The hexadecimal string representing the cell.
  factory Cell.fromHex(String src) {
    return Cell.fromBytes(BytesUtils.fromHexString(src));
  }

  /// Private constructor to create a `Cell` with specific attributes.
  ///
  /// [type] The type of the cell.
  /// [bits] The bit data of the cell.
  /// [refs] The references to other cells.
  /// [mask] The level mask of the cell.
  /// [hashes] The list of hashes associated with the cell.
  /// [depths] The list of depths corresponding to each level.
  Cell._(
      {required this.type,
      required this.bits,
      required List<Cell> refs,
      required this.mask,
      required List<List<int>> hashes,
      required List<int> depths})
      : _hashes = List<List<int>>.unmodifiable(
            hashes.map((e) => BytesUtils.toBytes(e, unmodifiable: true))),
        _depths = List<int>.unmodifiable(depths),
        refs = List<Cell>.unmodifiable(refs);

  /// Factory constructor to create a `Cell` instance with optional exotic properties.
  ///
  /// [exotic] Indicates if the cell is exotic.
  /// [bits] The bit data of the cell.
  /// [refs] The references to other cells.
  factory Cell(
      {bool exotic = false,
      BitString bits = BitString.empty,
      List<Cell> refs = const []}) {
    List<List<int>> hashes = [];
    List<int> depths = [];
    LevelMask mask;
    CellType type = CellType.ordinary;
    if (exotic) {
      final resolved = CellUtils.resolveExotic(bits, refs);
      type = resolved.type;
      final wonders = CellUtils.wonderCalculator(type, bits, refs);
      mask = wonders.mask;
      depths = wonders.depths;
      hashes = wonders.hashes;
    } else {
      // Check correctness
      if (refs.length > 4) {
        throw BocException("Invalid number of references");
      }
      if (bits.length > 1023) {
        throw BocException("Bits overflow",
            details: {"maximum_length": 1023, "length": bits.length});
      }

      final wonders = CellUtils.wonderCalculator(type, bits, refs);

      mask = wonders.mask;
      depths = wonders.depths;
      hashes = wonders.hashes;
    }
    return Cell._(
        type: type,
        bits: bits,
        refs: refs,
        mask: mask,
        hashes: hashes,
        depths: depths);
  }

  /// Begins parsing the cell and returns a `Slice` for reading its contents.
  ///
  /// [allowExotic] If `false`, parsing will fail for exotic cells.
  ///
  /// Returns a `Slice` object to read the cell's bit data and references.
  Slice beginParse({bool allowExotic = false}) {
    if (isExotic && !allowExotic) {
      throw BocException("Exotic cells cannot be parsed");
    }
    return Slice(BitReader(bits), refs);
  }

  /// Retrieves the hash for the cell at the specified [level].
  ///
  /// [level] The level for which the hash is requested (default is 3).
  ///
  /// Returns a list of integers representing the hash.
  List<int> hash({int level = 3}) {
    return _hashes[MathUtils.min(_hashes.length - 1, level)];
  }

  /// Retrieves the depth for the cell at the specified [level].
  ///
  /// [level] The level for which the depth is requested (default is 3).
  ///
  /// Returns the depth as an integer.
  int depth({int level = 3}) {
    return _depths[MathUtils.min(_depths.length - 1, level)];
  }

  /// Serializes the cell to a binary object code (BOC).
  ///
  /// [idx] If `true`, includes an index in the serialization.
  /// [crc32] If `true`, includes a CRC32 checksum in the serialization.
  ///
  /// Returns a list of integers representing the serialized BOC.
  List<int> toBoc({bool idx = false, bool crc32 = true}) {
    return BocSerialization.serialize(root: this, idx: idx, crc32: crc32);
  }

  /// Serializes the cell to a Base64 encoded string.
  ///
  /// [idx] If `true`, includes an index in the serialization.
  /// [crc32] If `true`, includes a CRC32 checksum in the serialization.
  /// [urlsafe] If `true`, uses URL-safe encoding.
  ///
  /// Returns a Base64 encoded string representing the serialized BOC.
  String toBase64({bool idx = false, bool crc32 = true, bool urlsafe = false}) {
    return Base64Utils.encodeBase64(toBoc(idx: idx, crc32: crc32),
        urlSafe: urlsafe);
  }

  /// Serializes the cell to a hexadecimal string.
  ///
  /// [idx] If `true`, includes an index in the serialization.
  /// [crc32] If `true`, includes a CRC32 checksum in the serialization.
  ///
  /// Returns a hexadecimal string representing the serialized BOC.
  String toHex({bool idx = false, bool crc32 = true}) {
    return BytesUtils.toHexString(toBoc(idx: idx, crc32: crc32));
  }

  /// Returns a string representation of the cell, including its type and bit data.
  ///
  /// [indent] A string used for indentation to format the output.
  ///
  /// Returns a formatted string representation of the cell and its references.
  @override
  String toString({String indent = ""}) {
    String id = indent;
    String t = "x";
    if (isExotic) {
      if (type == CellType.merkleProof) {
        t = "p";
      } else if (type == CellType.merkleUpdate) {
        t = "u";
      } else if (type == CellType.prunedBranch) {
        t = "p";
      }
    }
    String s = '$id$t{$bits}';
    for (Cell i in refs) {
      s += "\n" + i.toString(indent: "$id ");
    }
    return s;
  }

  /// Converts the cell to a `Slice` object for parsing.
  ///
  /// Returns a `Slice` object that starts parsing the cell's contents.
  Slice asSlice() {
    return beginParse();
  }

  Builder asBuilder() {
    return beginCell().storeSlice(asSlice());
  }

  @override
  operator ==(other) {
    if (other is! Cell) return false;
    if (other._hashes.length != _hashes.length) return false;
    for (int i = 0; i < _hashes.length; i++) {
      if (!BytesUtils.bytesEqual(other._hashes[i], _hashes[i])) {
        return false;
      }
    }
    return true;
  }

  @override
  int get hashCode => Object.hashAll(_hashes);
}
