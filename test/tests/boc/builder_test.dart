import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/bit/bit_reader.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'dart:math' show Random;

final _random = Random.secure();

int _generateRandom() {
  final len = _random.nextInt(6) + 1;
  assert(len > 0 && len <= 6);
  final rand = QuickCrypto.generateRandom(len);
  return IntUtils.fromBytes(rand);
}

int _generateRandomSign() {
  final len = _random.nextInt(6) + 1;
  assert(len > 0 && len <= 6);
  final rand = QuickCrypto.generateRandom(len);
  final sign = _random.nextBool();
  final num = IntUtils.fromBytes(rand);
  if (sign) return -num;
  return num;
}

void main() {
  _test();
}

void _test() {
  test('should read uints from builder', () {
    for (int i = 0; i < 1000; i++) {
      final a = _generateRandom();
      final b = _generateRandom();
      final builder = beginCell();
      builder.storeUint(a, 48);
      builder.storeUint(b, 48);
      final bits = builder.endCell().bits;
      final reader = BitReader(bits);
      expect(reader.preloadUint(48.toInt()), a);
      expect(reader.loadUint(48.toInt()), a);
      expect(reader.preloadUint(48.toInt()), b);
      expect(reader.loadUint(48.toInt()), b);
    }
  });
  test('should read ints from builder', () {
    for (int i = 0; i < 1000; i++) {
      final a = _generateRandomSign();
      final b = _generateRandomSign();
      final builder = beginCell();
      builder.storeInt(a, 49);
      builder.storeInt(b, 49);
      final bits = builder.endCell().bits;
      final reader = BitReader(bits);
      expect(reader.preloadInt(49.toInt()), a);
      expect(reader.loadInt(49.toInt()), a);
      expect(reader.preloadInt(49.toInt()), b);
      expect(reader.loadInt(49.toInt()), b);
    }
  });
  test('should read var uints from builder', () {
    for (int i = 0; i < 1000; i++) {
      final sizeBits = _random.nextInt(4) + 4;
      final a = _generateRandom();
      final b = _generateRandom();
      final builder = beginCell();
      builder.storeVarUint(a, sizeBits);
      builder.storeVarUint(b, sizeBits);
      final bits = builder.endCell().bits;
      final reader = BitReader(bits);
      expect(reader.preloadVarUint(sizeBits.toInt()), a);
      expect(reader.loadVarUint(sizeBits.toInt()), a);
      expect(reader.preloadVarUint(sizeBits.toInt()), b);
      expect(reader.loadVarUint(sizeBits.toInt()), b);
    }
  });
  test('should read var ints from builder', () {
    for (int i = 0; i < 1000; i++) {
      final sizeBits = _random.nextInt(4) + 4;
      final a = _generateRandomSign();
      final b = _generateRandomSign();
      final builder = beginCell();
      builder.storeVarInt(a, sizeBits);
      builder.storeVarInt(b, sizeBits);
      final bits = builder.endCell().bits;
      final reader = BitReader(bits);
      expect(reader.preloadVarInt(sizeBits.toInt()), a);
      expect(reader.loadVarInt(sizeBits.toInt()), a);
      expect(reader.preloadVarInt(sizeBits.toInt()), b);
      expect(reader.loadVarInt(sizeBits.toInt()), b);
    }
  });
  test('should read coins from builder', () {
    for (int i = 0; i < 1000; i++) {
      final a = _generateRandom();
      final b = _generateRandom();
      final builder = beginCell();
      builder.storeCoins(a);
      builder.storeCoins(b);
      final bits = builder.endCell().bits;
      final reader = BitReader(bits);
      expect(reader.preloadCoins().toInt(), a);
      expect(reader.loadCoins().toInt(), a);
      expect(reader.preloadCoins().toInt(), b);
      expect(reader.loadCoins().toInt(), b);
    }
  });

  test('should read address from builder', () {
    for (int i = 0; i < 1000; i++) {
      final a = i.isEven
          ? null
          : TonAddress.fromBytes(-1, QuickCrypto.generateRandom());
      final b = TonAddress.fromBytes(0, QuickCrypto.generateRandom());
      final builder = beginCell();
      builder.storeAddress(a);
      builder.storeAddress(b);
      final bits = builder.endCell().bits;
      final reader = BitReader(bits);
      expect(reader.loadMaybeAddress()?.toString(), a?.toString());
      expect(reader.loadAddress().toString(), b.toString());
    }
  });

  test('should read string tails from builder', () {
    for (int i = 0; i < 1000; i++) {
      final a = BytesUtils.toHexString(
          QuickCrypto.generateRandom(_random.nextInt(1023)));
      final b = BytesUtils.toHexString(
          QuickCrypto.generateRandom(_random.nextInt(1023)));
      final builder = beginCell();
      builder.storeStringRefTail(a);
      builder.storeStringTail(b);
      final sc = builder.endCell().beginParse();
      expect(sc.loadStringRefTail(), a);
      expect(sc.loadStringTail(), b);
    }
  });
}
