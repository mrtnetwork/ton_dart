import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/bit/bit_reader.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/serialization/models/level_mask.dart';
import 'package:ton_dart/src/boc/serialization/serialization/serialization.dart';
import 'package:ton_dart/src/boc/serialization/utils/utils.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/utils/math.dart';
import 'package:ton_dart/src/utils/utils.dart';
import 'cell_type.dart';

class Cell {
  static final Cell empty = Cell();
  final CellType type;
  final BitString bits;
  final List<Cell> refs;
  final LevelMask mask;
  final List<List<int>> _hashes;
  final List<int> _depths;
  bool get isExotic => type != CellType.ordinary;
  int get level => mask.level;

  static List<Cell> fromBoc(List<int> src) {
    return BocSerialization.deserialize(src);
  }

  static Cell fromBase64(String src) {
    final decode = Base64Utils.decodeBase64(src);
    final parsed = Cell.fromBoc(decode);
    if (parsed.length != 1) {
      throw BocException("Deserialized more than one cell.",
          details: {"cells": parsed});
    }
    return parsed[0];
  }

  static Cell fromBytes(List<int> src) {
    final parsed = Cell.fromBoc(src);
    if (parsed.length != 1) {
      throw BocException("Deserialized more than one cell.",
          details: {"cells": parsed});
    }
    return parsed[0];
  }

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

  factory Cell(
      {bool exotic = false,
      BitString bits = BitString.empty,
      List<Cell> refs = const []}) {
    List<List<int>> hashes = [];
    List<int> depths = [];
    LevelMask mask;
    CellType type = CellType.ordinary;
    if (exotic) {
      // Resolve exotic cell
      final resolved = CellUtils.resolveExotic(bits, refs);
      type = resolved.type;
      // Perform wonders
      final wonders = CellUtils.wonderCalculator(type, bits, refs);
      // Copy results
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

  Slice beginParse({bool allowExotic = false}) {
    if (isExotic && !allowExotic) {
      throw BocException("Exotic cells cannot be parsed");
    }
    return Slice(BitReader(bits), refs);
  }

  List<int> hash({int level = 3}) {
    return _hashes[MathUtils.min(_hashes.length - 1, level)];
  }

  int depth({int level = 3}) {
    return _depths[MathUtils.min(_depths.length - 1, level)];
  }

  List<int> toBoc({bool idx = false, bool crc32 = true}) {
    return BocSerialization.serialize(root: this, idx: idx, crc32: crc32);
  }

  String toBase64({bool idx = false, bool crc32 = true, bool urlsafe = false}) {
    final encode =
        BocSerialization.serialize(root: this, idx: idx, crc32: crc32);
    return Base64Utils.encodeBase64(encode, urlSafe: urlsafe);
  }

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
