import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/codecs/codecs.dart';

import 'dictionary.dart';
import 'key.dart';

class DictionaryValue<V> {
  final void Function(V source, Builder builder) serialize;
  final V Function(Slice slice) parse;
  const DictionaryValue({required this.serialize, required this.parse});

  static DictionaryValue<BigInt> bigIntValueCodec(int bits) =>
      DictionaryCodecs.createBigIntValue(bits);
  static DictionaryValue<int> intValueCodec(int bits) =>
      DictionaryCodecs.createIntValue(bits);
  static DictionaryValue<BigInt> bigVarIntCodec(int bits) =>
      DictionaryCodecs.createBigVarIntValue(bits);
  static DictionaryValue<BigInt> bigUintCodec(int bits) =>
      DictionaryCodecs.createBigUintValue(bits);
  static DictionaryValue<int> uintCodec(int bits) =>
      DictionaryCodecs.createUintValue(bits);
  static DictionaryValue<BigInt> bigVarUintCodec(int bits) =>
      DictionaryCodecs.createBigVarUintValue(bits);
  static DictionaryValue<bool> boolCodec() =>
      DictionaryCodecs.createBooleanValue();
  static DictionaryValue<TonBaseAddress> addressCodec() =>
      DictionaryCodecs.createAddressValue();
  static DictionaryValue<Cell> cellCodec() =>
      DictionaryCodecs.createCellValue();
  static DictionaryValue<List<int>> bytesCodec(int bytes) =>
      DictionaryCodecs.createBufferValue(bytes);
  static DictionaryValue<BitString> bitStringCodec(int bits) =>
      DictionaryCodecs.createBitStringValue(bits);
  static DictionaryValue<Dictionary<K, V>> dictionaryCodec<K extends Object, V>(
      DictionaryKey<K> key, DictionaryValue<V> value) {
    return DictionaryCodecs.createDictionaryValue(key, value);
  }
}
