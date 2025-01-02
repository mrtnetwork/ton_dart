import 'package:blockchain_utils/utils/utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/dict/dictionary.dart';

void main() {
  group('serialize dict', () => _test());
}

void _test() {
  test('should build prefix tree', () {
    // From docs
    final Map<BigInt, BigInt> map = {};
    map[BigInt.from(13)] = BigInt.from(169);
    map[BigInt.from(17)] = BigInt.from(289);
    map[BigInt.from(239)] = BigInt.from(57121);

    // Test serialization
    final builder = beginCell();
    DictSerialization.serialize(
        map, 16, (src, cell) => cell.storeUint(src, 16), builder);
    final root = builder.endCell();
    expect(BytesUtils.toHexString(root.hash()),
        'c8c0ca7071eabf18a71adcbb398d1d2164b1378b9ae70c00510049fb865aec6a');
  });
}
