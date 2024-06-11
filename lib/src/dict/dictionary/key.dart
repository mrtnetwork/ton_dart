import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/dict/codecs/codecs.dart';

class DictionaryKey<K extends Object> {
  final int bits;
  final BigInt Function(K) serialize;
  final K Function(BigInt) parse;
  const DictionaryKey(
      {required this.bits, required this.serialize, required this.parse});

  static DictionaryKey<TonBaseAddress> addressCodec() =>
      DictionaryCodecs.createAddressKey();
  static DictionaryKey<BigInt> bigIntCodec(int bits) =>
      DictionaryCodecs.createBigIntKey(bits);
  static DictionaryKey<int> intCodec(int bits) =>
      DictionaryCodecs.createIntKey(bits);
  static DictionaryKey<BigInt> bigUintCodec(int bits) =>
      DictionaryCodecs.createBigUintKey(bits);
  static DictionaryKey<int> uintCodec(int bits) =>
      DictionaryCodecs.createUintKey(bits);
  static DictionaryKey<List<int>> bufferCodec(int bits) =>
      DictionaryCodecs.createBufferKey(bits);
  static DictionaryKey<BitString> bitStringCodec(int bits) =>
      DictionaryCodecs.createBitStringKey(bits);
}
