import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/bit/bit_builder.dart';
import 'package:ton_dart/src/boc/bit/bit_reader.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/boc/serialization/utils/utils.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'package:ton_dart/src/boc/utils/utils.dart';
import 'package:ton_dart/src/utils/utils/crypto.dart';

class _ParseBocResult {
  final int size;
  final int offBytes;
  final int cells;
  final int roots;
  final int absent;
  final int totalCellSize;
  final List<int>? index;
  final List<int> cellData;
  final List<int> root;
  final bool? hasIndex;
  final bool? hasCrc32;
  final int magicNumber;
  _ParseBocResult(
      {required this.size,
      required this.offBytes,
      required this.cells,
      required this.roots,
      required this.absent,
      required this.totalCellSize,
      required List<int>? index,
      required List<int> cellData,
      required List<int> root,
      required this.magicNumber,
      this.hasCrc32,
      this.hasIndex})
      : index = BytesUtils.tryToBytes(index, unmodifiable: true),
        cellData = BytesUtils.toBytes(cellData, unmodifiable: true),
        root = BytesUtils.toBytes(root, unmodifiable: true);
}

class _ReadCellResult {
  final BitString bits;
  final List<int> refsList;
  final bool exotic;
  Cell? result;
  _ReadCellResult._(
      {required this.bits,
      required List<int> refsList,
      required this.exotic,
      required this.result})
      : refsList = List<int>.unmodifiable(refsList);
  _ReadCellResult copyWith(
      {BitString? bits, List<int>? refsList, bool? exotic, Cell? result}) {
    return _ReadCellResult._(
        bits: bits ?? this.bits,
        refsList: refsList ?? this.refsList,
        exotic: exotic ?? this.exotic,
        result: result ?? this.result);
  }
}

class _BocSerializationUtils {
  static int _getHashesCount(int levelMask) {
    return getHashesCountFromMask(levelMask & 7);
  }

  static int getHashesCountFromMask(int mask) {
    var n = 0;
    for (var i = 0; i < 3; i++) {
      n += (mask & 1);
      mask = mask >> 1;
    }
    return n + 1; // 1 repr + up to 3 higher hashes
  }

  static const int bocMagicNumber = 0x68ff65f3;
  static const int customFormatMagic = 0xacc3a728;
  static const int anotherMagicNumber = 0xb5ee9c72;

  static _ParseBocResult parseBoc(List<int> src) {
    final BitReader reader = BitReader(BitString(src, 0, src.length * 8));
    final int magic = reader.loadUint(32);
    switch (magic) {
      case bocMagicNumber:
        final size = reader.loadUint(8);
        final offBytes = reader.loadUint(8);
        final cells = reader.loadUint(size * 8);
        final roots = reader.loadUint(size * 8); // Must be 1
        final absent = reader.loadUint(size * 8);
        final totalCellSize = reader.loadUint(offBytes * 8);
        final index = reader.loadBuffer(cells * offBytes);
        final cellData = reader.loadBuffer(totalCellSize);
        return _ParseBocResult(
            size: size,
            offBytes: offBytes,
            cells: cells,
            roots: roots,
            absent: absent,
            totalCellSize: totalCellSize,
            index: index,
            cellData: cellData,
            root: [0],
            magicNumber: magic);
      case customFormatMagic:
        final size = reader.loadUint(8);
        final offBytes = reader.loadUint(8);
        final cells = reader.loadUint(size * 8);
        final roots = reader.loadUint(size * 8); // Must be 1
        final absent = reader.loadUint(size * 8);
        final totalCellSize = reader.loadUint(offBytes * 8);
        final index = reader.loadBuffer(cells * offBytes);
        final cellData = reader.loadBuffer(totalCellSize);
        final crc32 = reader.loadBuffer(4);
        if (!BytesUtils.bytesEqual(
            CryptoUtils.crc32c(src.sublist(0, src.length - 4)), crc32)) {
          throw BocException('Invalid CRC32C', details: {
            'crc32': crc32,
            'expected': src.sublist(0, src.length - 4)
          });
        }
        return _ParseBocResult(
            size: size,
            offBytes: offBytes,
            cells: cells,
            roots: roots,
            absent: absent,
            totalCellSize: totalCellSize,
            index: index,
            cellData: cellData,
            root: [0],
            magicNumber: magic);
      case anotherMagicNumber:
        final hasIdx = reader.loadBit();
        final hasCrc32c = reader.loadBit();
        reader.loadUint(1);
        reader.loadUint(2); // Must be 0
        final size = reader.loadUint(3);
        final offBytes = reader.loadUint(8);
        final cells = reader.loadUint(size * 8);
        final roots = reader.loadUint(size * 8);
        final absent = reader.loadUint(size * 8);
        final totalCellSize = reader.loadUint(offBytes * 8);

        final List<int> root = [];
        for (int i = 0; i < roots; i++) {
          root.add(reader.loadUint(size * 8));
        }
        List<int>? index;
        if (hasIdx) {
          index = reader.loadBuffer(cells * offBytes);
        }
        final List<int> cellData = reader.loadBuffer(totalCellSize);
        if (hasCrc32c) {
          final List<int> crc32 = reader.loadBuffer(4);
          if (!BytesUtils.bytesEqual(
              CryptoUtils.crc32c(src.sublist(0, src.length - 4)), crc32)) {
            throw BocException('Invalid CRC32C', details: {
              'crc32': crc32,
              'expected': src.sublist(0, src.length - 4)
            });
          }
        }
        return _ParseBocResult(
            size: size,
            offBytes: offBytes,
            cells: cells,
            roots: roots,
            absent: absent,
            totalCellSize: totalCellSize,
            index: index,
            cellData: cellData,
            root: root,
            hasCrc32: hasCrc32c,
            hasIndex: hasIdx,
            magicNumber: magic);
      default:
        throw BocException('Invalid magic number.', details: {
          'magic': magic,
          'expected': [bocMagicNumber, customFormatMagic, anotherMagicNumber]
              .join('or ')
        });
    }
  }

  static int calcCellSize(Cell cell, int sizeBytes) {
    return 2 + ((cell.bits.length + 7) ~/ 8) + cell.refs.length * sizeBytes;
  }

  static void writeCellToBuilder(
      Cell cell, List<int> refs, int sizeBytes, BitBuilder to) {
    final int d1 =
        CellUtils.getRefsDescriptor(cell.refs, cell.mask.value, cell.type);
    final int d2 = CellUtils.getBitsDescriptor(cell.bits);
    to.writeUint(d1, 8);
    to.writeUint(d2, 8);
    to.writeBuffer(BocUtils.bitsToPaddedBuffer(cell.bits).buffer());
    for (final int r in refs) {
      to.writeUint(r, sizeBytes * 8);
    }
  }

  static _ReadCellResult readCell(BitReader reader, int sizeBytes) {
    // D1
    final d1 = reader.loadUint(8);
    final refsCount = d1 % 8;
    final exotic = (d1 & 8) != 0;

    // D2
    final d2 = reader.loadUint(8);
    final dataBytesize = (d2 / 2).ceil();
    final paddingAdded = (d2 % 2) != 0;

    final levelMask = d1 >> 5;
    final hasHashes = (d1 & 16) != 0;
    const hashBytes = 32;

    final hashesSize = hasHashes ? _getHashesCount(levelMask) * hashBytes : 0;
    final depthSize = hasHashes ? _getHashesCount(levelMask) * 2 : 0;

    reader.skip(hashesSize * 8);
    reader.skip(depthSize * 8);

    // Bits
    var bits = BitString.empty;
    if (dataBytesize > 0) {
      bits = paddingAdded
          ? reader.loadPaddedBits(dataBytesize * 8)
          : reader.loadBits(dataBytesize * 8);
    }

    // Refs
    final refsList = <int>[];
    for (var i = 0; i < refsCount; i++) {
      refsList.add(reader.loadUint(sizeBytes * 8));
    }
    return _ReadCellResult._(
        bits: bits, refsList: refsList, exotic: exotic, result: null);

    // Result
  }
}

class BocSerialization {
  static List<int> serialize(
      {required Cell root, required bool idx, required bool crc32}) {
    // Sort cells
    final allCells = CellUtils.topologicalSort(root);

    // Calculate parameters
    final cellsNum = allCells.length;

    final sizeBytes =
        (cellsNum.toRadixString(2).length / 8).ceil().clamp(1, 3).toInt();
    int totalCellSize = 0;
    final List<int> index = [];
    for (final c in allCells) {
      final sz = _BocSerializationUtils.calcCellSize(c.cell, sizeBytes);
      totalCellSize += sz;
      index.add(totalCellSize);
    }
    final int offsetBytes =
        (totalCellSize.toRadixString(2).length / 8).ceil().clamp(1, 3).toInt();
    final int totalSize = (4 + // magic
            1 + // flags and s_bytes
            1 + // offset_bytes
            3 * sizeBytes + // cells_num, roots, complete
            offsetBytes + // full_size
            1 * sizeBytes + // root_idx
            (idx ? cellsNum * offsetBytes : 0) +
            totalCellSize +
            (crc32 ? 4 : 0)) *
        8;

    // Serialize
    final BitBuilder builder = BitBuilder(size: totalSize);
    builder.writeUint(_BocSerializationUtils.anotherMagicNumber, 32); // Magic
    builder.writeBit(idx); // Has index
    builder.writeBit(crc32); // Has crc32c
    builder.writeBit(false); // Has cache bits
    builder.writeUint(0, 2); // Flags
    builder.writeUint(sizeBytes, 3); // Size bytes
    builder.writeUint(offsetBytes, 8); // Offset bytes
    builder.writeUint(cellsNum, sizeBytes * 8); // Cells num
    builder.writeUint(1, sizeBytes * 8); // Roots num
    builder.writeUint(0, sizeBytes * 8); // Absent num
    builder.writeUint(totalCellSize, offsetBytes * 8); // Total cell size
    builder.writeUint(0, sizeBytes * 8); // Root id == 0
    if (idx) {
      // Index
      for (int i = 0; i < cellsNum; i++) {
        builder.writeUint(index[i], offsetBytes * 8);
      }
    }
    for (int i = 0; i < cellsNum; i++) {
      // Cells
      _BocSerializationUtils.writeCellToBuilder(
          allCells[i].cell, allCells[i].refs, sizeBytes, builder);
    }
    if (crc32) {
      final List<int> crc32 = CryptoUtils.crc32c(builder
          .buffer()); // builder.buffer() is fast since it doesn't allocate new memory
      builder.writeBuffer(crc32);
    }

    // Sanity Check
    final List<int> res = builder.buffer();
    if (res.length != totalSize ~/ 8) {
      throw BocException('Serialization cannot verify length.',
          details: {'expected': totalSize ~/ 8, 'length': res.length});
    }
    return res;
  }

  static List<Cell> deserialize(List<int> src) {
    /// Parse BOC
    final _ParseBocResult boc = _BocSerializationUtils.parseBoc(src);
    final BitReader reader =
        BitReader(BitString(boc.cellData, 0, boc.cellData.length * 8));

    /// Load cells
    final List<_ReadCellResult> cells = List.generate(boc.cells,
        (index) => _BocSerializationUtils.readCell(reader, boc.size));

    /// Build cells
    for (int i = cells.length - 1; i >= 0; i--) {
      final List<Cell> refs = [];
      final cell = cells[i];
      for (final int r in cell.refsList) {
        final result = cells[r].result;
        if (result == null) {
          throw BocException('Invalid BOC file');
        }
        refs.add(result);
      }
      cell.result = Cell(bits: cell.bits, refs: refs, exotic: cell.exotic);
    }

    /// Load roots
    final List<Cell> roots = [];
    for (int i = 0; i < boc.root.length; i++) {
      roots.add(cells.elementAt(boc.root[i]).result!);
    }

    return roots;
  }
}
