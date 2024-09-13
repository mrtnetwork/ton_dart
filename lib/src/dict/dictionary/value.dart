import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/codecs/codecs.dart';

import 'dictionary.dart';
import 'key.dart';

/// Represents a value in a dictionary, defining how to serialize and parse
/// the value.
class DictionaryValue<V> {
  /// Function to serialize the value into a `Builder`.
  final void Function(V source, Builder builder) serialize;

  /// Function to parse a value from a `Slice`.
  final V Function(Slice slice) parse;

  /// Constructs a `DictionaryValue` with the specified serialization and parsing functions.
  const DictionaryValue({required this.serialize, required this.parse});

  /// Returns a `DictionaryValue` for `BigInt` with the specified bit length.
  static DictionaryValue<BigInt> bigIntValueCodec(int bits) =>
      DictionaryCodecs.createBigIntValue(bits);

  /// Returns a `DictionaryValue` for `int` with the specified bit length.
  static DictionaryValue<int> intValueCodec(int bits) =>
      DictionaryCodecs.createIntValue(bits);

  /// Returns a `DictionaryValue` for `BigInt` with the specified bit length for variable-length integers.
  static DictionaryValue<BigInt> bigVarIntCodec(int bits) =>
      DictionaryCodecs.createBigVarIntValue(bits);

  /// Returns a `DictionaryValue` for `BigInt` with the specified bit length for unsigned integers.
  static DictionaryValue<BigInt> bigUintCodec(int bits) =>
      DictionaryCodecs.createBigUintValue(bits);

  /// Returns a `DictionaryValue` for `int` with the specified bit length for unsigned integers.
  static DictionaryValue<int> uintCodec(int bits) =>
      DictionaryCodecs.createUintValue(bits);

  /// Returns a `DictionaryValue` for `BigInt` with the specified bit length for variable-length unsigned integers.
  static DictionaryValue<BigInt> bigVarUintCodec(int bits) =>
      DictionaryCodecs.createBigVarUintValue(bits);

  /// Returns a `DictionaryValue` for `bool`.
  static DictionaryValue<bool> boolCodec() =>
      DictionaryCodecs.createBooleanValue();

  /// Returns a `DictionaryValue` for `TonAddress`.
  static DictionaryValue<TonAddress> addressCodec() =>
      DictionaryCodecs.createAddressValue();

  /// Returns a `DictionaryValue` for `TonBaseAddress`.
  static DictionaryValue<TonBaseAddress> addressBaseCodec() =>
      DictionaryCodecs.createBaseAddressValue();

  /// Returns a `DictionaryValue` for `Cell`.
  static DictionaryValue<Cell> cellCodec() =>
      DictionaryCodecs.createCellValue();

  /// Returns a `DictionaryValue` for a `List<int>` with the specified byte length.
  static DictionaryValue<List<int>> bytesCodec(int bytes) =>
      DictionaryCodecs.createBufferValue(bytes);

  /// Returns a `DictionaryValue` for `BitString` with the specified bit length.
  static DictionaryValue<BitString> bitStringCodec(int bits) =>
      DictionaryCodecs.createBitStringValue(bits);

  /// Returns a `DictionaryValue` for a dictionary with the specified key and value codecs.
  static DictionaryValue<Dictionary<K, V>> dictionaryCodec<K extends Object, V>(
      DictionaryKey<K> key, DictionaryValue<V> value) {
    return DictionaryCodecs.createDictionaryValue(key, value);
  }
}
