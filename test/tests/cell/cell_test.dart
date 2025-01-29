import 'package:test/test.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/boc/serialization/serialization/serialization.dart';
import 'package:ton_dart/src/boc/serialization/utils/utils.dart';
import 'package:ton_dart/src/boc/cell/cell_type.dart';
import 'account_state_test_vector.dart';
import 'config_proof_test_vector.dart';
import 'test_vectors.dart';

import 'very_large_boc_test_vector.dart';
import 'dart:math' show Random;
import 'package:blockchain_utils/blockchain_utils.dart';

extension QuickBytesDecode on List<int> {
  String toB64({bool urlSafe = false}) {
    final encode = StringUtils.decode(this, type: StringEncoding.base64);

    if (urlSafe) {
      return encode.replaceAll('+', '-').replaceAll('/', '_');
    }
    return encode;
  }

  String toHex() => BytesUtils.toHexString(this);
}

extension QuickStringDecode on String {
  List<int> fromB64() => StringUtils.encode(this, type: StringEncoding.base64);
  List<int> fromHex() => BytesUtils.fromHexString(this);
}

final random = Random.secure();

int generateRandom() {
  final len = random.nextInt(6) + 1;
  assert(len > 0 && len <= 6);
  final rand = QuickCrypto.generateRandom(len);
  return IntUtils.fromBytes(rand);
}

int generateRandomSign() {
  final len = random.nextInt(6) + 1;
  assert(len > 0 && len <= 6);
  final rand = QuickCrypto.generateRandom(len);
  final sign = random.nextBool();
  final num = IntUtils.fromBytes(rand);
  if (sign) return -num;
  return num;
}

const List<String> _wallets = [
  'B5EE9C72410101010044000084FF0020DDA4F260810200D71820D70B1FED44D0D31FD3FFD15112BAF2A122F901541044F910F2A2F80001D31F3120D74A96D307D402FB00DED1A4C8CB1FCBFFC9ED5441FDF089',
  'B5EE9C724101010100530000A2FF0020DD2082014C97BA9730ED44D0D70B1FE0A4F260810200D71820D70B1FED44D0D31FD3FFD15112BAF2A122F901541044F910F2A2F80001D31F3120D74A96D307D402FB00DED1A4C8CB1FCBFFC9ED54D0E2786F',
  'B5EE9C7241010101005F0000BAFF0020DD2082014C97BA218201339CBAB19C71B0ED44D0D31FD70BFFE304E0A4F260810200D71820D70B1FED44D0D31FD3FFD15112BAF2A122F901541044F910F2A2F80001D31F3120D74A96D307D402FB00DED1A4C8CB1FCBFFC9ED54B5B86E42',
  'B5EE9C724101010100570000AAFF0020DD2082014C97BA9730ED44D0D70B1FE0A4F2608308D71820D31FD31F01F823BBF263ED44D0D31FD3FFD15131BAF2A103F901541042F910F2A2F800029320D74A96D307D402FB00E8D1A4C8CB1FCBFFC9ED54A1370BB6',
  'B5EE9C724101010100630000C2FF0020DD2082014C97BA218201339CBAB19C71B0ED44D0D31FD70BFFE304E0A4F2608308D71820D31FD31F01F823BBF263ED44D0D31FD3FFD15131BAF2A103F901541042F910F2A2F800029320D74A96D307D402FB00E8D1A4C8CB1FCBFFC9ED54044CD7A1',
  'B5EE9C724101010100620000C0FF0020DD2082014C97BA9730ED44D0D70B1FE0A4F2608308D71820D31FD31FD31FF82313BBF263ED44D0D31FD31FD3FFD15132BAF2A15144BAF2A204F901541055F910F2A3F8009320D74A96D307D402FB00E8D101A4C8CB1FCB1FCBFFC9ED543FBE6EE0',
  'B5EE9C724101010100710000DEFF0020DD2082014C97BA218201339CBAB19F71B0ED44D0D31FD31F31D70BFFE304E0A4F2608308D71820D31FD31FD31FF82313BBF263ED44D0D31FD31FD3FFD15132BAF2A15144BAF2A204F901541055F910F2A3F8009320D74A96D307D402FB00E8D101A4C8CB1FCB1FCBFFC9ED5410BD6DAD'
];

void main() async {
  group('Cell', () {
    _parseWalletCode();
    _largeBoc();
    _emptyBits();
    _byteAlignedBits();
    _notAlignedBits();
    _singleReference();
    _multipleReferences();
    _libraryCell();
    _bocWithIndex();
    _manyCells();
    _accountState();
    _configProof();
    _accountProof();
    _block();
    _hasTxWithMrkleBody();
    _veryLarge();
  });
}

void _largeBoc() {
  test('large boc', () {
    final c = BocSerialization.deserialize(largeBocTestVector.fromB64())[0];
    final ser = BocSerialization.serialize(root: c, idx: false, crc32: true);
    expect(ser.toHex(), largeBocSerializationHex);
  });
}

void _configProof() {
  test('should parse configProof.txt', () {
    final boc = configProofTestVector.fromB64();
    final c = BocSerialization.deserialize(boc)[0];
    final b = BocSerialization.serialize(root: c, idx: false, crc32: true);
    expect(b.toHex(), configProofSerializationHex);
    final c2 = BocSerialization.deserialize(b)[0];
    expect(c2, c);
  });
}

void _accountProof() {
  test('should parse accountProof', () {
    final boc = accountProofVecotr.fromB64();
    final c = BocSerialization.deserialize(boc)[0];
    final b = BocSerialization.serialize(root: c, idx: false, crc32: true);
    expect(b.toHex(), accountProofSerializationHex);
    final c2 = BocSerialization.deserialize(b)[0];
    expect(c2, c);
  });
}

void _parseWalletCode() {
  test('Parse wallet code', () {
    for (final w in _wallets) {
      final c = BocSerialization.deserialize(BytesUtils.fromHexString(w))[0];
      final b = BocSerialization.serialize(root: c, idx: false, crc32: true);
      final c2 = BocSerialization.deserialize(b)[0];
      expect(c2, c);
    }
  });
}

void _accountState() {
  test('should parse accountState', () {
    final boc = accountStateVector.fromB64();
    final c = BocSerialization.deserialize(boc)[0];
    final b = BocSerialization.serialize(root: c, idx: false, crc32: true);
    expect(b.toHex(), accountStateSerializationHdex);
    final c2 = BocSerialization.deserialize(b)[0];
    expect(c2, c);
  });
  test('accountState_2', () {
    final boc = accountState2TestVector.fromB64();
    final c = BocSerialization.deserialize(boc)[0];
    final b = BocSerialization.serialize(root: c, idx: false, crc32: true);
    expect(b.toHex(), accountState2SerialiaztionHex);
    final c2 = BocSerialization.deserialize(b)[0];
    expect(c2, c);
  });
  test('accountState Pruned', () {
    final boc = accountStatePrunedTestVector.fromB64();
    final c = BocSerialization.deserialize(boc)[0];
    final b = BocSerialization.serialize(root: c, idx: false, crc32: true);
    expect(b.toHex(), accountStatePrunedSerializationHex);
    final c2 = BocSerialization.deserialize(b)[0];
    expect(c2, c);
  });
  test('should match pruned state', () {
    final prunedBoc = accountStatePrunedTestVector.fromB64();
    final pruned = BocSerialization.deserialize(prunedBoc)[0];
    final fullBoc = accountState2TestVector.fromB64();
    final full = BocSerialization.deserialize(fullBoc)[0];
    expect(pruned.isExotic, true);
    expect(pruned.type, CellType.merkleProof);
    final prunedData = pruned.beginParse(allowExotic: true).loadRef();

    // Load refs
    final sc = full.beginParse();
    final fullA = sc.loadRef();
    final fullB = sc.loadRef();
    final sc2 = prunedData.beginParse();
    final prunedA = sc2.loadRef();
    final prunedB = sc2.loadRef();
    final ppA = CellUtils.exoticPruned(prunedA.bits, prunedA.refs);
    final ppB = CellUtils.exoticPruned(prunedB.bits, prunedB.refs);

    // Check hashes
    expect(ppA.pruned[0].hash, fullA.hash());
    expect(ppB.pruned[0].hash, fullB.hash());
  });
}

void _manyCells() {
  const cells =
      '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CQQAAQoBCgEKAQoEAAELAQsBCwELBAABDAEMAQwBDAQAAQ0BDQENAQ0EAAEOAQ4BDgEOBAABDwEPAQ8BDwQAARABEAEQARAEAAERAREBEQERBAABEgESARIBEgQAARMBEwETARMEAAEUARQBFAEUBAABFQEVARUBFQQAARYBFgEWARYEAAEXARcBFwEXBAABGAEYARgBGAQAARkBGQEZARkEAAEaARoBGgEaBAABGwEbARsBGwQAARwBHAEcARwEAAEdAR0BHQEdBAABHgEeAR4BHgQAAR8BHwEfAR8EAAEgASABIAEgBAABIQEhASEBIQQAASIBIgEiASIEAAEjASMBIwEjBAABJAEkASQBJAQAASUBJQElASUEAAEmASYBJgEmBAABJwEnAScBJwQAASgBKAEoASgEAAEpASkBKQEpBAABKgEqASoBKgQAASsBKwErASsEAAEsASwBLAEsBAABLQEtAS0BLQQAAS4BLgEuAS4EAAEvAS8BLwEvBAABMAEwATABMAQAATEBMQExATEEAAEyATIBMgEyBAABMwEzATMBMwQAATQBNAE0ATQEAAE1ATUBNQE1BAABNgE2ATYBNgQAATcBNwE3ATcEAAE4ATgBOAE4BAABOQE5ATkBOQQAAToBOgE6AToEAAE7ATsBOwE7BAABPAE8ATwBPAQAAT0BPQE9AT0EAAE+AT4BPgE+BAABPwE/AT8BPwQAAUABQAFAAUAEAAFBAUEBQQFBBAABQgFCAUIBQgQAAUMBQwFDAUMEAAFEAUQBRAFEBAABRQFFAUUBRQQAAUYBRgFGAUYEAAFHAUcBRwFHBAABSAFIAUgBSAQAAUkBSQFJAUkEAAFKAUoBSgFKBAABSwFLAUsBSwQAAUwBTAFMAUwEAAFNAU0BTQFNBAABTgFOAU4BTgQAAU8BTwFPAU8EAAFQAVABUAFQBAABUQFRAVEBUQQAAVIBUgFSAVIEAAFTAVMBUwFTBAABVAFUAVQBVAQAAVUBVQFVAVUEAAFWAVYBVgFWBAABVwFXAVcBVwQAAVgBWAFYAVgEAAFZAVkBWQFZBAABWgFaAVoBWgQAAVsBWwFbAVsEAAFcAVwBXAFcBAABXQFdAV0BXQQAAV4BXgFeAV4EAAFfAV8BXwFfBAABYAFgAWABYAQAAWEBYQFhAWEEAAFiAWIBYgFiBAABYwFjAWMBYwQAAWQBZAFkAWQEAAFlAWUBZQFlBAABZgFmAWYBZgQAAWcBZwFnAWcEAAFoAWgBaAFoBAABaQFpAWkBaQQAAWoBagFqAWoEAAFrAWsBawFrBAABbAFsAWwBbAQAAW0BbQFtAW0EAAFuAW4BbgFuBAABbwFvAW8BbwQAAXABcAFwAXAEAAFxAXEBcQFxBAABcgFyAXIBcgQAAXMBcwFzAXMEAAF0AXQBdAF0BAABdQF1AXUBdQQAAXYBdgF2AXYEAAF3AXcBdwF3BAABeAF4AXgBeAQAAXkBeQF5AXkEAAF6AXoBegF6BAABewF7AXsBewQAAXwBfAF8AXwEAAF9AX0BfQF9BAABfgF+AX4BfgQAAX8BfwF/AX8EAAGAAYABgAGABAABgQGBAYEBgQQAAYIBggGCAYIEAAGDAYMBgwGDBAABhAGEAYQBhAQAAYUBhQGFAYUEAAGGAYYBhgGGBAABhwGHAYcBhwQAAYgBiAGIAYgEAAGJAYkBiQGJBAABigGKAYoBigQAAYsBiwGLAYsEAAGMAYwBjAGMBAABjQGNAY0BjQQAAY4BjgGOAY4EAAGPAY8BjwGPBAABkAGQAZABkAQAAZEBkQGRAZEEAAGSAZIBkgGSBAABkwGTAZMBkwQAAZQBlAGUAZQEAAGVAZUBlQGVBAABlgGWAZYBlgQAAZcBlwGXAZcEAAGYAZgBmAGYBAABmQGZAZkBmQQAAZoBmgGaAZoEAAGbAZsBmwGbBAABnAGcAZwBnAQAAZ0BnQGdAZ0EAAGeAZ4BngGeBAABnwGfAZ8BnwQAAaABoAGgAaAEAAGhAaEBoQGhBAABogGiAaIBogQAAaMBowGjAaMEAAGkAaQBpAGkBAABpQGlAaUBpQQAAaYBpgGmAaYEAAGnAacBpwGnBAABqAGoAagBqAQAAakBqQGpAakEAAGqAaoBqgGqBAABqwGrAasBqwQAAawBrAGsAawEAAGtAa0BrQGtBAABrgGuAa4BrgQAAa8BrwGvAa8EAAGwAbABsAGwBAABsQGxAbEBsQQAAbIBsgGyAbIEAAGzAbMBswGzBAABtAG0AbQBtAQAAbUBtQG1AbUEAAG2AbYBtgG2BAABtwG3AbcBtwQAAbgBuAG4AbgEAAG5AbkBuQG5BAABugG6AboBugQAAbsBuwG7AbsEAAG8AbwBvAG8BAABvQG9Ab0BvQQAAb4BvgG+Ab4EAAG/Ab8BvwG/BAABwAHAAcABwAQAAcEBwQHBAcEEAAHCAcIBwgHCBAABwwHDAcMBwwQAAcQBxAHEAcQEAAHFAcUBxQHFBAABxgHGAcYBxgQAAccBxwHHAccEAAHIAcgByAHIBAAByQHJAckByQQAAcoBygHKAcoEAAHLAcsBywHLBAABzAHMAcwBzAQAAc0BzQHNAc0EAAHOAc4BzgHOBAABzwHPAc8BzwQAAdAB0AHQAdAEAAHRAdEB0QHRBAAB0gHSAdIB0gQAAdMB0wHTAdMEAAHUAdQB1AHUBAAB1QHVAdUB1QQAAdYB1gHWAdYEAAHXAdcB1wHXBAAB2AHYAdgB2AQAAdkB2QHZAdkEAAHaAdoB2gHaBAAB2wHbAdsB2wQAAdwB3AHcAdwEAAHdAd0B3QHdBAAB3gHeAd4B3gQAAd8B3wHfAd8EAAHgAeAB4AHgBAAB4QHhAeEB4QQAAeIB4gHiAeIEAAHjAeMB4wHjBAAB5AHkAeQB5AQAAeUB5QHlAeUEAAHmAeYB5gHmBAAB5wHnAecB5wQAAegB6AHoAegEAAHpAekB6QHpBAAB6gHqAeoB6gQAAesB6wHrAesEAAHsAewB7AHsBAAB7QHtAe0B7QQAAe4B7gHuAe4EAAHvAe8B7wHvBAAB8AHwAfAB8AQAAfEB8QHxAfEEAAHyAfIB8gHyBAAB8wHzAfMB8wQAAfQB9AH0AfQEAAH1AfUB9QH1BAAB9gH2AfYB9gQAAfcB9wH3AfcEAAH4AfgB+AH4BAAB+QH5AfkB+QQAAfoB+gH6AfoEAAH7AfsB+wH7BAAB/AH8AfwB/AQAAf0B/QH9Af0EAAH+Af4B/gH+BAAB/wH/Af8B/wQAAgACAAIAAgAAAHRW3Eg=';

  test('should parse', () {
    final boc = cells.fromB64();
    final c = BocSerialization.deserialize(boc)[0];
    final b = BocSerialization.serialize(root: c, idx: false, crc32: true);
    final c2 = BocSerialization.deserialize(b)[0];
    expect(c2, c);
  });
}

void _emptyBits() {
  test('empty bits', () {
    final cell = beginCell().endCell();
    expect(cell.toString(), 'x{}');
    expect(cell.hash().toB64(), 'lqKW0iTyhcZ77pPDD4owkVfw2qNdxbh+QQt4YwoJz8c=');

    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: false)
            .toB64(),
        'te6ccgEBAQEAAgAAAA==');
    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: true).toB64(),
        'te6cckEBAQEAAgAAAEysuc0=');

    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: false).toB64(),
        'te6ccoEBAQEAAgACAAA=');

    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: true).toB64(),
        'te6ccsEBAQEAAgACAAC4Afhr');
    expect(BocSerialization.deserialize('te6ccgEBAQEAAgAAAA=='.fromB64())[0],
        cell);

    expect(
        BocSerialization.deserialize('te6cckEBAQEAAgAAAEysuc0='.fromB64())[0],
        cell);
    expect(BocSerialization.deserialize('te6ccoEBAQEAAgACAAA='.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize('te6ccsEBAQEAAgACAAC4Afhr'.fromB64())[0],
        cell);
  });
}

void _byteAlignedBits() {
  test('byte-aligned bits', () {
    final cell = beginCell().storeUint(123456789, 32).endCell();
    expect(cell.toString(), 'x{075BCD15}');
    expect(cell.hash().toB64(), 'keNT38owvINaYYHwYjE1R8HYk0c1NSMH72u+/aMJ+1c=');
    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: false)
            .toB64(),
        'te6ccgEBAQEABgAACAdbzRU=');
    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: true).toB64(),
        'te6cckEBAQEABgAACAdbzRVRblCS');
    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: false).toB64(),
        'te6ccoEBAQEABgAGAAgHW80V');
    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: true).toB64(),
        'te6ccsEBAQEABgAGAAgHW80ViGH1dQ==');
    expect(
        BocSerialization.deserialize('te6ccgEBAQEABgAACAdbzRU='.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6cckEBAQEABgAACAdbzRVRblCS'.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize('te6ccoEBAQEABgAGAAgHW80V'.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6ccsEBAQEABgAGAAgHW80ViGH1dQ=='.fromB64())[0],
        cell);
  });
}

void _notAlignedBits() {
  test('should serialize single cell with a number of non-aligned bits', () {
    final cell = beginCell().storeUint(123456789, 34).endCell();
    expect(cell.toString(), 'x{01D6F3456_}');
    expect(cell.hash().toB64(), 'Rk+nt8kkAyN9S1v4H0zwFbGs2INwpMHvESvPQbrI6d0=');
    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: false)
            .toB64(),
        'te6ccgEBAQEABwAACQHW80Vg');
    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: true).toB64(),
        'te6cckEBAQEABwAACQHW80Vgb11ZoQ==');
    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: false).toB64(),
        'te6ccoEBAQEABwAHAAkB1vNFYA==');
    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: true).toB64(),
        'te6ccsEBAQEABwAHAAkB1vNFYM0Si3w=');
    expect(
        BocSerialization.deserialize('te6ccgEBAQEABwAACQHW80Vg'.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6cckEBAQEABwAACQHW80Vgb11ZoQ=='.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6ccoEBAQEABwAHAAkB1vNFYA=='.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6ccsEBAQEABwAHAAkB1vNFYM0Si3w='.fromB64())[0],
        cell);
  });
}

void _singleReference() {
  test('should serialize single cell with a single reference', () {
    final refCell = beginCell().storeUint(123456789, 32).endCell();
    final cell =
        beginCell().storeUint(987654321, 32).storeRef(refCell).endCell();
    expect(cell.toString(), 'x{3ADE68B1}\n x{075BCD15}');
    expect(cell.hash().toB64(), 'goaQYcsXO2c/gd3qvMo3ncEjzpbU7urNQ7hPDo0qC1c=');
    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: false)
            .toB64(),
        'te6ccgEBAgEADQABCDreaLEBAAgHW80V');
    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: true).toB64(),
        'te6cckEBAgEADQABCDreaLEBAAgHW80VSW/75w==');
    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: false).toB64(),
        'te6ccoEBAgEADQAHDQEIOt5osQEACAdbzRU=');
    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: true).toB64(),
        'te6ccsEBAgEADQAHDQEIOt5osQEACAdbzRUxP4cd');
    expect(
        BocSerialization.deserialize(
            'te6ccgEBAgEADQABCDreaLEBAAgHW80V'.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6cckEBAgEADQABCDreaLEBAAgHW80VSW/75w=='.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6ccoEBAgEADQAABwEIOt5osQEACAdbzRU='.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6ccsEBAgEADQAHDQEIOt5osQEACAdbzRUxP4cd'.fromB64())[0],
        cell);
  });
}

void _multipleReferences() {
  test('should serialize single cell with multiple references', () {
    final refCell = beginCell().storeUint(123456789, 32).endCell();
    final cell = beginCell()
        .storeUint(987654321, 32)
        .storeRef(refCell)
        .storeRef(refCell)
        .storeRef(refCell)
        .endCell();
    expect(cell.toString(),
        'x{3ADE68B1}\n x{075BCD15}\n x{075BCD15}\n x{075BCD15}');
    expect(cell.hash().toB64(), 'cks0wbfqFZE9/yb0sWMWQGoj0XBOLkUi+aX5xpJ6jjA=');
    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: false)
            .toB64(),
        'te6ccgEBAgEADwADCDreaLEBAQEACAdbzRU=');

    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: true).toB64(),
        'te6cckEBAgEADwADCDreaLEBAQEACAdbzRWpQD2p');
    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: false).toB64(),
        'te6ccoEBAgEADwAJDwMIOt5osQEBAQAIB1vNFQ==');
    expect(
        BocSerialization.serialize(root: cell, idx: true, crc32: true).toB64(),
        'te6ccsEBAgEADwAJDwMIOt5osQEBAQAIB1vNFZz9usI=');
    expect(
        BocSerialization.deserialize(
            'te6ccgEBAgEADwADCDreaLEBAQEACAdbzRU='.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6cckEBAgEADwADCDreaLEBAQEACAdbzRWpQD2p'.fromB64())[0],
        cell);

    expect(
        BocSerialization.deserialize(
            'te6ccoEBAgEADwAACQMIOt5osQEBAQAIB1vNFQ=='.fromB64())[0],
        cell);
    expect(
        BocSerialization.deserialize(
            'te6ccsEBAgEADwAJDwMIOt5osQEBAQAIB1vNFZz9usI='.fromB64())[0],
        cell);
  });
}

void _libraryCell() {
  test('should deserialize/serialize library cell', () {
    final cell = Cell.fromBase64(
        'te6ccgEBAgEALQABDv8AiNDtHtgBCEICGbgzd5nhZ9WhSM+4juFCvgMYJOtxthFdtTKIH6M/6SM=');
    expect(cell.toString(),
        'x{FF0088D0ED1ED8}\n x{0219B8337799E167D5A148CFB88EE142BE031824EB71B6115DB532881FA33FE923}');
    expect(
        BocSerialization.serialize(root: cell, idx: false, crc32: false)
            .toB64(),
        'te6ccgEBAgEALQABDv8AiNDtHtgBCEICGbgzd5nhZ9WhSM+4juFCvgMYJOtxthFdtTKIH6M/6SM=');
  });
}

void _bocWithIndex() {
  test('should serialize boc with index', () {
    final cell = beginCell()
        .storeUint(228, 32)
        .storeRef(beginCell().storeUint(1337, 32).endCell())
        .storeRef(beginCell().storeUint(1338, 32).endCell())
        .endCell();

    final serialized = cell.toBoc(idx: true, crc32: false).toHex();
    expect(cell.toString(), 'x{000000E4}\n x{00000539}\n x{0000053A}');
    expect(serialized,
        'b5ee9c7281010301001400080e140208000000e4010200080000053900080000053a');
  });
}

void _block() {
  test('block', () {
    final cell = Cell.fromBase64(blockTestVecotr);
    final des = BocSerialization.serialize(root: cell, idx: false, crc32: true);
    expect(des.toHex(), blockSerializationHex);
  });
  test('block2', () {
    final cell = Cell.fromBase64(block2TestVector);
    expect(cell.hash().toHex(),
        '25e19f8c4574804a8cabade6bab736a27a67f4f6696a8a0feb93b3dfbfab7fcf');
  });
}

void _hasTxWithMrkleBody() {
  test('should hash tx with merkle body', () {
    final cell = Cell.fromBoc(merkleBodyTestVecotr.fromHex());
    expect(cell[0].hash().toHex(),
        'ca676f0f30d21c8828d1094424797085b603e991d26943ee17ee5d77ac4b0896');
  });
}

void _veryLarge() {
  test('should parse veryLarge', () {
    final boc = veryLargeBocTestVector.fromHex();
    final c = BocSerialization.deserialize(boc)[0];
    final b = BocSerialization.serialize(root: c, idx: false, crc32: true);
    final c2 = BocSerialization.deserialize(b)[0];
    expect(c2, c);
  });
}
