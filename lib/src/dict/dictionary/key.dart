import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/dict/codecs/codecs.dart';

/// Represents a key used in a dictionary, defining how to serialize and parse
/// the key value, as well as the bit length used for encoding.
class DictionaryKey<K extends Object> {
  /// The number of bits used to encode the key.
  final int bits;

  /// Function to serialize the key value into a `BigInt`.
  final BigInt Function(K) serialize;

  /// Function to parse a `BigInt` into the key value.
  final K Function(BigInt) parse;

  /// Constructs a `DictionaryKey` with the specified bit length, serialization,
  /// and parsing functions.
  const DictionaryKey(
      {required this.bits, required this.serialize, required this.parse});

  /// Returns a `DictionaryKey` for `TonBaseAddress` with a bit length of 267.
  static DictionaryKey<TonBaseAddress> addressCodec() =>
      DictionaryCodecs.createAddressKey();

  /// Returns a `DictionaryKey` for `BigInt` with the specified bit length.
  static DictionaryKey<BigInt> bigIntCodec(int bits) =>
      DictionaryCodecs.createBigIntKey(bits);

  /// Returns a `DictionaryKey` for `int` with the specified bit length.
  static DictionaryKey<int> intCodec(int bits) =>
      DictionaryCodecs.createIntKey(bits);

  /// Returns a `DictionaryKey` for `BigInt` with the specified bit length for unsigned integers.
  static DictionaryKey<BigInt> bigUintCodec(int bits) =>
      DictionaryCodecs.createBigUintKey(bits);

  /// Returns a `DictionaryKey` for `int` with the specified bit length for unsigned integers.
  static DictionaryKey<int> uintCodec(int bits) =>
      DictionaryCodecs.createUintKey(bits);

  /// Returns a `DictionaryKey` for a `List<int>` with the specified byte length.
  static DictionaryKey<List<int>> bufferCodec(int bytes) =>
      DictionaryCodecs.createBufferKey(bytes);

  /// Returns a `DictionaryKey` for `BitString` with the specified bit length.
  static DictionaryKey<BitString> bitStringCodec(int bits) =>
      DictionaryCodecs.createBitStringKey(bits);
}
