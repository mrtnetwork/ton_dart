import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/dict/utils/utils.dart';

void main() {
  group('dict keys', () => _test());
}

void _test() {
  test('should serialize numbers', () {
    final cs = [0, -1, 1, 123123123, -123123123];
    for (final c in cs) {
      expect(
          DictionaryUtils.deserializeInternalKey(
              DictionaryUtils.serializeInternalKey(c)),
          c);
    }
  });
  test('should serialize bignumbers', () {
    final cs = [
      BigInt.zero,
      BigInt.from(-1),
      BigInt.one,
      BigInt.from(123123123),
      BigInt.from(-123123123),
      BigInt.parse('1231231231231237812683128376123'),
      BigInt.parse('-1231273612873681263871263871263')
    ];
    for (final c in cs) {
      expect(
          DictionaryUtils.deserializeInternalKey(
              DictionaryUtils.serializeInternalKey(c)),
          c);
    }
  });
  test('should serialize addresses', () {
    final cs = [
      TonAddress.fromBytes(0, QuickCrypto.generateRandom()),
      TonAddress.fromBytes(-1, QuickCrypto.generateRandom()),
      TonAddress.fromBytes(0, QuickCrypto.generateRandom()),
      TonAddress.fromBytes(0, QuickCrypto.generateRandom())
    ];
    for (final c in cs) {
      expect(
          (DictionaryUtils.deserializeInternalKey(
              DictionaryUtils.serializeInternalKey(c))),
          c);
    }
  });
  test('should serialize buffers', () {
    final cs = [
      [0x00],
      [0xff],
      [0x0f],
      BytesUtils.fromHexString('0f000011002233456611')
    ];
    for (final c in cs) {
      expect(
          (DictionaryUtils.deserializeInternalKey(
              DictionaryUtils.serializeInternalKey(c))),
          c);
    }
  });
  test('should serialize bit strings', () {
    final cs = [
      [0x00],
      [0xff],
      [0x0f],
      BytesUtils.fromHexString('0f000011002233456611')
    ];
    for (final c in cs) {
      for (int i = 0; i < c.length * 8 - 1; i++) {
        final bs = BitString(c, 0, c.length * 8 - i);
        final res = DictionaryUtils.deserializeInternalKey(
            DictionaryUtils.serializeInternalKey(bs));
        expect(res, bs);
      }
    }
  });
}
