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

class Slice {
  final BitReader _reader;
  final List<Cell> _refs;
  int _refsOffset = 0;

  Slice(BitReader reader, List<Cell> refs)
      : _reader = reader.clone(),
        _refs = List<Cell>.unmodifiable(refs);

  int get remainingBits {
    return _reader.remaining;
  }

  int get offsetBits {
    return _reader.offset;
  }

  int get remainingRefs {
    return _refs.length - _refsOffset;
  }

  int get offsetRefs {
    return _refsOffset;
  }

  int get readerOffset => _reader.offset;
  int get readerremaining => _reader.remaining;

  Slice skip(int bits) {
    _reader.skip(bits);
    return this;
  }

  bool loadBit() {
    return _reader.loadBit();
  }

  bool preloadBit() {
    return _reader.preloadBit();
  }

  bool loadBoolean() {
    return loadBit();
  }

  bool? loadMaybeBoolean() {
    if (loadBit()) {
      return loadBoolean();
    } else {
      return null;
    }
  }

  BitString loadBits(int bits) {
    return _reader.loadBits(bits);
  }

  BitString preloadBits(int bits) {
    return _reader.preloadBits(bits);
  }

  int loadUint(int bits) {
    return _reader.loadUint(bits);
  }

  int loadUint8() {
    return _reader.loadUint(8);
  }

  BigInt loadUintBig(int bits) {
    return _reader.loadUintBig(bits);
  }

  BigInt loadUint64() {
    return _reader.loadUintBig(64);
  }

  int loadUint32() {
    return _reader.loadUint(32);
  }

  int loadUint16() {
    return _reader.loadUint(16);
  }

  int preloadUint(int bits) {
    return _reader.preloadUint(bits);
  }

  BigInt preloadUintBig(int bits) {
    return _reader.preloadUintBig(bits);
  }

  int? loadMaybeUint(int bits) {
    if (loadBit()) {
      return loadUint(bits);
    } else {
      return null;
    }
  }

  BigInt? loadMaybeUintBig(int bits) {
    if (loadBit()) {
      return loadUintBig(bits);
    } else {
      return null;
    }
  }

  int loadInt(int bits) {
    return _reader.loadInt(bits);
  }

  BigInt loadIntBig(int bits) {
    return _reader.loadIntBig(bits);
  }

  int preloadInt(int bits) {
    return _reader.preloadInt(bits);
  }

  BigInt preloadIntBig(int bits) {
    return _reader.preloadIntBig(bits);
  }

  int? loadMaybeInt(int bits) {
    if (loadBit()) {
      return loadInt(bits);
    } else {
      return null;
    }
  }

  BigInt? loadMaybeIntBig(int bits) {
    if (loadBit()) {
      return loadIntBig(bits);
    } else {
      return null;
    }
  }

  int loadVarUint(int bits) {
    return _reader.loadVarUint(bits);
  }

  BigInt loadVarUintBig(int bits) {
    return _reader.loadVarUintBig(bits);
  }

  int preloadVarUint(int bits) {
    return _reader.preloadVarUint(bits);
  }

  BigInt preloadVarUintBig(int bits) {
    return _reader.preloadVarUintBig(bits);
  }

  int loadVarInt(int bits) {
    return _reader.loadVarInt(bits);
  }

  BigInt loadVarIntBig(int bits) {
    return _reader.loadVarIntBig(bits);
  }

  int preloadVarInt(int bits) {
    return _reader.preloadVarInt(bits);
  }

  BigInt preloadVarIntBig(int bits) {
    return _reader.preloadVarIntBig(bits);
  }

  BigInt loadCoins() {
    return _reader.loadCoins();
  }

  BigInt preloadCoins() {
    return _reader.preloadCoins();
  }

  BigInt? loadMaybeCoins() {
    if (loadBit()) {
      return loadCoins();
    } else {
      return null;
    }
  }

  TonAddress loadAddress() {
    return _reader.loadAddress();
  }

  TonAddress? loadMaybeAddress() {
    return _reader.loadMaybeAddress();
  }

  ExternalAddress loadExternalAddress() {
    return _reader.loadExternalAddress();
  }

  ExternalAddress? loadMaybeExternalAddress() {
    return _reader.loadMaybeExternalAddress();
  }

  TonBaseAddress? loadAddressAny() {
    return _reader.loadAddressAny();
  }

  Cell loadRef() {
    if (_refsOffset >= _refs.length) {
      throw BocException('No more references');
    }
    return _refs[_refsOffset++];
  }

  Cell preloadRef() {
    if (_refsOffset >= _refs.length) {
      throw BocException('No more references');
    }
    return _refs[_refsOffset];
  }

  Cell? loadMaybeRef() {
    if (loadBit()) {
      return loadRef();
    } else {
      return null;
    }
  }

  Cell? preloadMaybeRef() {
    if (preloadBit()) {
      return preloadRef();
    } else {
      return null;
    }
  }

  List<int> loadBuffer(int bytes) {
    return _reader.loadBuffer(bytes);
  }

  List<int> preloadBuffer(int bytes) {
    return _reader.preloadBuffer(bytes);
  }

  String loadStringTail() {
    return BocUtils.readString(this);
  }

  String? loadMaybeStringTail() {
    if (loadBit()) {
      return BocUtils.readString(this);
    } else {
      return null;
    }
  }

  String loadStringRefTail() {
    return BocUtils.readString(loadRef().beginParse());
  }

  String? loadMaybeStringRefTail() {
    final ref = loadMaybeRef();
    if (ref != null) {
      return BocUtils.readString(ref.beginParse());
    } else {
      return null;
    }
  }

  Dictionary<K, V> loadDict<K extends Object, V>(
      DictionaryKey<K> key, DictionaryValue<V> value) {
    return Dictionary.load(key, value, this);
  }

  Dictionary<K, V> loadDictDirect<K extends Object, V>(
      DictionaryKey<K> key, DictionaryValue<V> value) {
    return Dictionary.loadDirect(key, value, this);
  }

  void endParse() {
    if (remainingBits > 0 || remainingRefs > 0) {
      throw BocException('Slice is not empty');
    }
  }

  Cell asCell() {
    return beginCell().storeSlice(this).endCell();
  }

  Builder asBuilder() {
    return beginCell().storeSlice(this);
  }

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

  @override
  String toString() {
    return asCell().toString();
  }
}
