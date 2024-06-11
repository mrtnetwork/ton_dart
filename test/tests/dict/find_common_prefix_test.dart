import 'package:test/test.dart';
import 'package:ton_dart/src/dict/utils/utils.dart';

void main() {
  group("find common prefix", () => _test());
}

void _test() {
  test('should find common prefix', () {
    expect(DictionaryUtils.findCommonPrefix(['0000111', '0101111', '0001111']),
        "0");
    expect(DictionaryUtils.findCommonPrefix(['0000111', '0001111', '0000101']),
        "000");
    expect(DictionaryUtils.findCommonPrefix(['0000111', '1001111', '0000101']),
        "");
  });
}
