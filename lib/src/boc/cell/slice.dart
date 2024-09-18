import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/bit/bit_reader.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'package:ton_dart/src/boc/utils/utils.dart';
import 'package:ton_dart/src/dict/dictionary/dictionary.dart';
import 'package:ton_dart/src/dict/dictionary/key.dart';
import 'package:ton_dart/src/dict/dictionary/value.dart';
import 'cell.dart';

/// The `Slice` class provides methods to read and manipulate a portion of data from a bit stream.
/// It handles the extraction of various data types and references from a binary object code (BOC) slice.
class Slice {
  final BitReader _reader;
  final List<Cell> _refs;
  int _refsOffset = 0;

  /// Creates a new `Slice` with a bit reader and a list of cell references.
  ///
  /// [reader] The bit reader to read bits from.
  /// [refs] The list of cell references.
  Slice(BitReader reader, List<Cell> refs)
      : _reader = reader.clone(),
        _refs = List<Cell>.unmodifiable(refs);

  /// Returns the number of remaining bits in the slice.
  int get remainingBits {
    return _reader.remaining;
  }

  /// Returns the current offset of bits read.
  int get offsetBits {
    return _reader.offset;
  }

  /// Returns the number of remaining cell references in the slice.
  int get remainingRefs {
    return _refs.length - _refsOffset;
  }

  /// Returns the current offset of cell references read.
  int get offsetRefs {
    return _refsOffset;
  }

  /// Alias for the bit reader's offset.
  int get readerOffset => _reader.offset;

  /// Alias for the bit reader's remaining bits.
  int get readerremaining => _reader.remaining;

  /// Skips a specified number of bits in the slice.
  ///
  /// [bits] The number of bits to skip.
  ///
  /// Returns the updated `Slice` instance.
  Slice skip(int bits) {
    _reader.skip(bits);
    return this;
  }

  /// Loads a single bit from the bit stream.
  ///
  /// Returns `true` if the bit is 1, `false` if it is 0.
  bool loadBit() {
    return _reader.loadBit();
  }

  /// Preloads a single bit from the bit stream without advancing the reader.
  ///
  /// Returns `true` if the bit is 1, `false` if it is 0.
  bool preloadBit() {
    return _reader.preloadBit();
  }

  /// Loads a boolean value from the bit stream (same as `loadBit`).
  bool loadBoolean() {
    return loadBit();
  }

  /// Loads a boolean value or returns `null` if the bit indicating presence is 0.
  ///
  /// Returns a boolean value or `null`.
  bool? loadMaybeBoolean() {
    if (loadBit()) {
      return loadBoolean();
    } else {
      return null;
    }
  }

  /// Loads a specified number of bits from the bit stream.
  ///
  /// [bits] The number of bits to load.
  ///
  /// Returns a `BitString` representing the loaded bits.
  BitString loadBits(int bits) {
    return _reader.loadBits(bits);
  }

  /// Preloads a specified number of bits from the bit stream without advancing the reader.
  ///
  /// [bits] The number of bits to preload.
  ///
  /// Returns a `BitString` representing the preloaded bits.
  BitString preloadBits(int bits) {
    return _reader.preloadBits(bits);
  }

  /// Loads an unsigned integer of a specified bit length from the bit stream.
  ///
  /// [bits] The number of bits for the unsigned integer.
  ///
  /// Returns the loaded unsigned integer.
  int loadUint(int bits) {
    return _reader.loadUint(bits);
  }

  /// Loads an 8-bit unsigned integer from the bit stream.
  int loadUint8() {
    return _reader.loadUint(8);
  }

  /// Loads a 4-bit unsigned integer from the bit stream.
  int loadUint4() {
    return _reader.loadUint(4);
  }

  /// Attempts to load an 8-bit unsigned integer and returns `null` if it fails.
  int? tryLoadUint8() {
    try {
      return _reader.loadUint(8);
    } on BocException {
      return null;
    }
  }

  /// Loads a big unsigned integer of a specified bit length from the bit stream.
  ///
  /// [bits] The number of bits for the big unsigned integer.
  ///
  /// Returns the loaded big unsigned integer.
  BigInt loadUintBig(int bits) {
    return _reader.loadUintBig(bits);
  }

  /// Loads a 64-bit big unsigned integer from the bit stream.
  BigInt loadUint64() {
    return _reader.loadUintBig(64);
  }

  /// Loads a 256-bit big unsigned integer from the bit stream.
  BigInt loadUint256() {
    return _reader.loadUintBig(256);
  }

  /// Loads a 32-bit unsigned integer from the bit stream.
  int loadUint32() {
    return _reader.loadUint(32);
  }

  /// Attempts to load a 32-bit unsigned integer and returns `null` if it fails.
  int? tryLoadUint32() {
    try {
      return _reader.loadUint(32);
    } on BocException {
      return null;
    }
  }

  /// Attempts to preload a 8-bit unsigned integer and returns `null` if it fails.
  int? tryPreLoadUint8() {
    try {
      return _reader.preloadUint(8);
    } on BocException {
      return null;
    }
  }

  /// Attempts to preload a 32-bit unsigned integer and returns `null` if it fails.
  int? tryPreloadUint32() {
    try {
      return _reader.preloadUint(32);
    } on BocException {
      return null;
    }
  }

  /// Loads a 16-bit unsigned integer from the bit stream.
  int loadUint16() {
    return _reader.loadUint(16);
  }

  /// Preloads an unsigned integer of a specified bit length from the bit stream without advancing the reader.
  ///
  /// [bits] The number of bits for the unsigned integer.
  ///
  /// Returns the preloaded unsigned integer.
  int preloadUint(int bits) {
    return _reader.preloadUint(bits);
  }

  /// Preloads a big unsigned integer of a specified bit length from the bit stream without advancing the reader.
  ///
  /// [bits] The number of bits for the big unsigned integer.
  ///
  /// Returns the preloaded big unsigned integer.
  BigInt preloadUintBig(int bits) {
    return _reader.preloadUintBig(bits);
  }

  /// Loads an unsigned integer of a specified bit length if a preceding bit indicates its presence.
  ///
  /// [bits] The number of bits for the unsigned integer.
  ///
  /// Returns the loaded unsigned integer or `null`.
  int? loadMaybeUint(int bits) {
    if (loadBit()) {
      return loadUint(bits);
    } else {
      return null;
    }
  }

  /// Loads a big unsigned integer of a specified bit length if a preceding bit indicates its presence.
  ///
  /// [bits] The number of bits for the big unsigned integer.
  ///
  /// Returns the loaded big unsigned integer or `null`.
  BigInt? loadMaybeUintBig(int bits) {
    if (loadBit()) {
      return loadUintBig(bits);
    } else {
      return null;
    }
  }

  /// Loads a signed integer of a specified bit length from the bit stream.
  ///
  /// [bits] The number of bits for the signed integer.
  ///
  /// Returns the loaded signed integer.
  int loadInt(int bits) {
    return _reader.loadInt(bits);
  }

  /// Loads a big signed integer of a specified bit length from the bit stream.
  ///
  /// [bits] The number of bits for the big signed integer.
  ///
  /// Returns the loaded big signed integer.
  BigInt loadIntBig(int bits) {
    return _reader.loadIntBig(bits);
  }

  /// Preloads a signed integer of a specified bit length from the bit stream without advancing the reader.
  ///
  /// [bits] The number of bits for the signed integer.
  ///
  /// Returns the preloaded signed integer.
  int preloadInt(int bits) {
    return _reader.preloadInt(bits);
  }

  /// Preloads a big signed integer of a specified bit length from the bit stream without advancing the reader.
  ///
  /// [bits] The number of bits for the big signed integer.
  ///
  /// Returns the preloaded big signed integer.
  BigInt preloadIntBig(int bits) {
    return _reader.preloadIntBig(bits);
  }

  /// Loads a signed integer of a specified bit length if a preceding bit indicates its presence.
  ///
  /// [bits] The number of bits for the signed integer.
  ///
  /// Returns the loaded signed integer or `null`.
  int? loadMaybeInt(int bits) {
    if (loadBit()) {
      return loadInt(bits);
    } else {
      return null;
    }
  }

  /// Loads a big signed integer of a specified bit length if a preceding bit indicates its presence.
  ///
  /// [bits] The number of bits for the big signed integer.
  ///
  /// Returns the loaded big signed integer or `null`.
  BigInt? loadMaybeIntBig(int bits) {
    if (loadBit()) {
      return loadIntBig(bits);
    } else {
      return null;
    }
  }

  /// Loads and returns a variable-length unsigned integer from the slice.
  ///
  /// The number of bits determines the length of the integer.
  int loadVarUint(int bits) {
    return _reader.loadVarUint(bits);
  }

  /// Loads and returns a variable-length unsigned integer as a `BigInt` from the slice.
  ///
  /// The number of bits determines the length of the integer.
  BigInt loadVarUintBig(int bits) {
    return _reader.loadVarUintBig(bits);
  }

  /// Peeks at a variable-length unsigned integer from the slice without advancing the reader.
  ///
  /// The number of bits determines the length of the integer.
  int preloadVarUint(int bits) {
    return _reader.preloadVarUint(bits);
  }

  /// Peeks at a variable-length unsigned integer as a `BigInt` from the slice without advancing the reader.
  ///
  /// The number of bits determines the length of the integer.
  BigInt preloadVarUintBig(int bits) {
    return _reader.preloadVarUintBig(bits);
  }

  /// Loads and returns a variable-length signed integer from the slice.
  ///
  /// The number of bits determines the length of the integer.
  int loadVarInt(int bits) {
    return _reader.loadVarInt(bits);
  }

  /// Loads and returns a variable-length signed integer as a `BigInt` from the slice.
  ///
  /// The number of bits determines the length of the integer.
  BigInt loadVarIntBig(int bits) {
    return _reader.loadVarIntBig(bits);
  }

  /// Peeks at a variable-length signed integer from the slice without advancing the reader.
  ///
  /// The number of bits determines the length of the integer.
  int preloadVarInt(int bits) {
    return _reader.preloadVarInt(bits);
  }

  /// Peeks at a variable-length signed integer as a `BigInt` from the slice without advancing the reader.
  ///
  /// The number of bits determines the length of the integer.
  BigInt preloadVarIntBig(int bits) {
    return _reader.preloadVarIntBig(bits);
  }

  /// Loads and returns the coin value from the slice as a `BigInt`.
  BigInt loadCoins() {
    return _reader.loadCoins();
  }

  /// Peeks at the coin value from the slice as a `BigInt` without advancing the reader.
  BigInt preloadCoins() {
    return _reader.preloadCoins();
  }

  /// Loads the coin value if the next bit is set; otherwise, returns `null`.
  BigInt? loadMaybeCoins() {
    if (loadBit()) {
      return loadCoins();
    } else {
      return null;
    }
  }

  /// Loads and returns a `TonAddress` from the slice.
  TonAddress loadAddress() {
    return _reader.loadAddress();
  }

  /// Loads a `TonAddress` if present; otherwise, returns `null`.
  TonAddress? loadMaybeAddress() {
    return _reader.loadMaybeAddress();
  }

  /// Loads and returns an `ExternalAddress` from the slice.
  ExternalAddress loadExternalAddress() {
    return _reader.loadExternalAddress();
  }

  /// Loads an `ExternalAddress` if present; otherwise, returns `null`.
  ExternalAddress? loadMaybeExternalAddress() {
    return _reader.loadMaybeExternalAddress();
  }

  /// Loads and returns a `TonBaseAddress` if present; otherwise, returns `null`.
  TonBaseAddress? loadAddressAny() {
    return _reader.loadAddressAny();
  }

  /// Loads and returns a `Cell` reference from the slice.
  ///
  /// Throws a `BocException` if there are no more references available.
  Cell loadRef() {
    if (_refsOffset >= _refs.length) {
      throw BocException('No more references');
    }
    return _refs[_refsOffset++];
  }

  /// Peeks at and returns a `Cell` reference from the slice without advancing the reader.
  ///
  /// Throws a `BocException` if there are no more references available.
  Cell preloadRef() {
    if (_refsOffset >= _refs.length) {
      throw BocException('No more references');
    }
    return _refs[_refsOffset];
  }

  /// Loads a `Cell` reference if the next bit is set; otherwise, returns `null`.
  Cell? loadMaybeRef() {
    if (loadBit()) {
      return loadRef();
    } else {
      return null;
    }
  }

  /// Attempts to load a `Cell` reference if the next bit is set; returns `null` on failure.
  Cell? tryLoadRef() {
    try {
      if (loadBit()) {
        return loadRef();
      } else {
        return null;
      }
    } on BocException {
      return null;
    }
  }

  /// Attempts to peek at a `Cell` reference if the next bit is set; returns `null` on failure.
  Cell? preloadMaybeRef() {
    if (preloadBit()) {
      return preloadRef();
    } else {
      return null;
    }
  }

  /// Loads and returns a buffer of the specified size (in bytes) from the slice.
  List<int> loadBuffer(int bytes) {
    return _reader.loadBuffer(bytes);
  }

  /// Peeks at a buffer of the specified size (in bytes) from the slice without advancing the reader.
  List<int> preloadBuffer(int bytes) {
    return _reader.preloadBuffer(bytes);
  }

  /// Loads and returns the remaining string from the slice.
  String loadStringTail() {
    return BocUtils.readString(this);
  }

  /// Loads and returns the remaining buffer from the slice.
  List<int> loadBufferTail() {
    return BocUtils.readBuffer(this);
  }

  /// Loads and returns the remaining string if the next bit is set; otherwise, returns `null`.
  String? loadMaybeStringTail() {
    if (loadBit()) {
      return BocUtils.readString(this);
    } else {
      return null;
    }
  }

  /// Loads and returns the remaining string from a referenced `Cell`.
  String loadStringRefTail() {
    return BocUtils.readString(loadRef().beginParse());
  }

  /// Loads and returns the remaining string from a referenced `Cell` if present; otherwise, returns `null`.
  String? loadMaybeStringRefTail() {
    final ref = loadMaybeRef();
    if (ref != null) {
      return BocUtils.readString(ref.beginParse());
    } else {
      return null;
    }
  }

  /// Loads and returns a dictionary from the slice using the provided key and value serializers.
  Dictionary<K, V> loadDict<K extends Object, V>(
      DictionaryKey<K> key, DictionaryValue<V> value) {
    return Dictionary.load<K, V>(key, value, this);
  }

  /// Loads and returns a dictionary directly from the slice using the provided key and value serializers.
  Dictionary<K, V> loadDictDirect<K extends Object, V>(
      DictionaryKey<K> key, DictionaryValue<V> value) {
    return Dictionary.loadDirect<K, V>(key: key, value: value, slice: this);
  }

  /// Checks if the slice is fully parsed (i.e., all bits and references have been consumed).
  ///
  /// Throws a `BocException` if there are remaining bits or references.
  void endParse() {
    if (remainingBits > 0 || remainingRefs > 0) {
      throw BocException('Slice is not empty');
    }
  }

  /// Converts the slice into a `Cell`.
  Cell asCell() {
    return beginCell().storeSlice(this).endCell();
  }

  /// Converts the slice into a `Builder` for further manipulation.
  Builder asBuilder() {
    return beginCell().storeSlice(this);
  }

  /// Creates a new `Slice` instance by cloning the current slice.
  ///
  /// If `fromStart` is `true`, the reader is reset to the beginning.
  Slice clone({bool fromStart = false}) {
    if (fromStart) {
      final reader = _reader.clone();
      reader.reset();
      return Slice(reader, _refs);
    } else {
      final res = Slice(_reader, _refs);
      res._refsOffset = _refsOffset;
      return res;
    }
  }

  void reset() {
    _reader.reset();
    _refsOffset = 0;
  }

  @override
  String toString() {
    return asCell().toString();
  }
}
