import 'package:test/test.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/tuple/serialization/serialization.dart';
import 'package:ton_dart/src/tuple/tuple/tuple.dart';
import 'package:ton_dart/src/tuple/utils/utils.dart';

void main() {
  group('tuple', () => _test());
}

void _test() {
  test('should serialize tuple with numbers', () {
    final serialized = TupleSerialization.serialize([
      {'type': 'num', 'num': BigInt.parse('-1')},
      {'type': 'num', 'num': BigInt.parse('-1')},
      {'type': 'num', 'num': BigInt.parse('49800000000')},
      {'type': 'num', 'num': BigInt.parse('100000000')},
      {'type': 'num', 'num': BigInt.parse('100000000')},
      {'type': 'num', 'num': BigInt.parse('2500')},
      {'type': 'num', 'num': BigInt.parse('100000000')}
    ].map((e) => TupleItem.fromJson(e)).toList());
    expect(serialized.toBase64(idx: false, crc32: false),
        'te6ccgEBCAEAWQABGAAABwEAAAAABfXhAAEBEgEAAAAAAAAJxAIBEgEAAAAABfXhAAMBEgEAAAAABfXhAAQBEgEAAAALmE+yAAUBEgH//////////wYBEgH//////////wcAAA==');
  });

  test('should serialize tuple long numbers', () {
    const golden =
        'te6ccgEBAgEAKgABSgAAAQIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAqt4e0IsLXV0BAAA=';
    final serialized = TupleSerialization.serialize(
        [TupleItemInt(BigInt.parse('12312312312312323421'))]);
    expect(serialized.toBase64(idx: false, crc32: false), golden);
  });
  test('should serialize slices', () {
    const golden = 'te6ccgEBAwEAHwACDwAAAQQAB0AgAQIAAAAd4GEghEZ4iF1r9AWzyJs4';
    final serialized = TupleSerialization.serialize([
      TupleItemSlice(beginCell()
          .storeCoins(BigInt.parse('123123123123123234211234123123123'))
          .endCell())
    ]);
    expect(serialized.toBase64(idx: false, crc32: false), golden);
  });

  test('should serialize address', () {
    const golden =
        'te6ccgEBAwEAMgACDwAAAQQAELAgAQIAAABDn_k3QjSzAxvCFAxl2WAXIYvKOdG_BD9NlNG8vx1vw1C00A==';
    final serialized = TupleSerialization.serialize([
      TupleItemSlice(beginCell()
          .storeAddress(
              TonAddress('kf_JuhGlmBjeEKBjLssAuQxeUc6N-CH6bKaN5fjrfhqFpqVQ'))
          .endCell())
    ]);
    expect(
        serialized.toBase64(idx: false, crc32: false, urlsafe: true), golden);
  });
  test('should serialize int', () {
    const golden =
        'te6ccgEBAgEAKgABSgAAAQIAyboRpZgY3hCgYy7LALkMXlHOjfgh+mymjeX4634ahaYBAAA=';
    final serialized = TupleSerialization.serialize([
      TupleItemInt(BigInt.parse(
          '91243637913382117273357363328745502088904016167292989471764554225637796775334'))
    ]);
    expect(serialized.toBase64(idx: false, crc32: false), golden);
  });
  test('should serialize tuples', () {
    const golden =
        'te6ccgEBEAEAjgADDAAABwcABAEIDQESAf//////////AgESAQAAAAAAAAADAwESAQAAAAAAAAACBAESAQAAAAAAAAABBQECAAYBEgEAAAAAAAAAAQcAAAIACQwCAAoLABIBAAAAAAAAAHsAEgEAAAAAAAHimQECAw8BBgcAAQ4BCQQAB0AgDwAd4GEghEZ4iF1r9AWzyJs4';
    final st = TupleUtils.parse(Cell.fromBase64(golden));
    final gs = TupleSerialization.serialize(st);
    expect(gs.toBase64(idx: false, crc32: false), golden);
  });
  test('should parse large tuple from emulator', () {
    const boc =
        'te6cckECCAEAAwgAAg8AAAEEAD+AYAECAAAB/tC/0YDQuNCy0LXRgiDQvNC40YAg8J+RgCDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LgDAf7QstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIgBAH+0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIAUB/vCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9EGAf6A0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC1BwDc0YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYDQv9GA0LjQstC10YIg0LzQuNGAIPCfkYBG2Y9A';
    final cell = Cell.fromBase64(boc);
    TupleUtils.parse(cell);
  });
}
