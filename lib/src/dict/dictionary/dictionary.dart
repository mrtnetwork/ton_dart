import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/exception/exception.dart';
import 'package:ton_dart/src/dict/serialization/serialization.dart';
import 'package:ton_dart/src/dict/utils/utils.dart';
import 'key.dart';
import 'value.dart';

class Dictionary<K extends Object, V> {
  final DictionaryKey<K>? _key;
  final DictionaryValue<V>? _value;
  final Map<String, V> _map;
  int get size => _map.length;

  Dictionary(this._map, this._key, this._value);

  static Dictionary<K, V> empty<K extends Object, V>(
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    if (key != null && value != null) {
      return Dictionary<K, V>(<String, V>{}, key, value);
    } else {
      return Dictionary<K, V>(<String, V>{}, null, null);
    }
  }

  static Dictionary<K, V> fromEnteries<K extends Object, V>(
      {required DictionaryKey<K> key,
      required DictionaryValue<V> value,
      required Map<K, V> map}) {
    final dict = empty<K, V>(key: key, value: value);
    for (final i in map.entries) {
      dict[i.key] = i.value;
    }
    return dict;
  }

  static Dictionary<K, V> load<K extends Object, V>(
      DictionaryKey<K> key, DictionaryValue<V> value, Slice slice) {
    final cell = slice.loadMaybeRef();
    if (cell != null && !cell.isExotic) {
      return loadDirect<K, V>(key, value, cell.beginParse());
    } else {
      return empty<K, V>(key: key, value: value);
    }
  }

  static Dictionary<K, V> loadDirect<K extends Object, V>(
      DictionaryKey<K> key, DictionaryValue<V> value, Slice? slice) {
    if (slice == null) {
      return empty<K, V>(key: key, value: value);
    }
    final values = DictionaryUtils.parseDict(slice, key.bits, value.parse);
    final Map<String, V> prepared = {};
    for (final i in values.entries) {
      prepared[DictionaryUtils.serializeInternalKey(key.parse(i.key))] =
          i.value;
    }

    return Dictionary<K, V>(prepared, key, value);
  }

  Iterable<V> get values => _map.values;

  V? operator [](K key) => _map[DictionaryUtils.serializeInternalKey(key)];

  bool containsKey(K key) =>
      _map.containsKey(DictionaryUtils.serializeInternalKey(key));

  void operator []=(K key, V value) {
    _map[DictionaryUtils.serializeInternalKey(key)] = value;
  }

  bool remove(K key) =>
      _map.remove(DictionaryUtils.serializeInternalKey(key)) != null;

  void clear() => _map.clear();

  Iterable<MapEntry<K, V>> get entries sync* {
    for (final entry in _map.entries) {
      yield MapEntry(
          DictionaryUtils.deserializeInternalKey(entry.key), entry.value);
    }
  }

  Iterable<K> get keys sync* {
    for (final key in _map.keys) {
      yield DictionaryUtils.deserializeInternalKey(key);
    }
  }

  void store(Builder builder,
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    if (_map.isEmpty) {
      builder.storeBit(0);
    } else {
      final resolvedKey = key ?? _key;
      final resolvedValue = value ?? _value;
      if (resolvedKey == null) {
        throw DictException("Key serializer is not defined");
      }
      if (resolvedValue == null) {
        throw DictException("Value serializer is not defined");
      }

      final prepared = Map<BigInt, V>.fromEntries(_map.entries.map((entry) =>
          MapEntry(
              resolvedKey
                  .serialize(DictionaryUtils.deserializeInternalKey(entry.key)),
              entry.value)));

      builder.storeBit(1);
      final dd = beginCell();
      DictSerialization.serialize(
          prepared, resolvedKey.bits, resolvedValue.serialize, dd);
      builder.storeRef(dd.endCell());
    }
  }

  void storeDirect(Builder builder,
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    if (_map.isEmpty) {
      throw DictException("Cannot store empty dictionary directly");
    }

    final resolvedKey = key ?? _key;
    final resolvedValue = value ?? _value;
    if (resolvedKey == null) {
      throw DictException("Key serializer is not defined");
    }
    if (resolvedValue == null) {
      throw DictException("Value serializer is not defined");
    }
    final prepared = Map<BigInt, V>.fromEntries(_map.entries.map((entry) =>
        MapEntry(
            resolvedKey
                .serialize(DictionaryUtils.deserializeInternalKey(entry.key)),
            entry.value)));

    DictSerialization.serialize(
        prepared, resolvedKey.bits, resolvedValue.serialize, builder);
  }

  Cell generateMerkleProof(K key) =>
      DictionaryUtils.generateMerkleProof(this, key, _key!);

  Cell generateMerkleUpdate(K key, V newValue) =>
      DictionaryUtils.generateMerkleUpdate<K, V>(this, key, _key!, newValue);

  void loadFromClice(Slice slice,
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    final resolvedKey = key ?? _key;
    final resolvedValue = value ?? _value;
    if (resolvedKey == null) {
      throw DictException("Key serializer is not defined");
    }
    if (resolvedValue == null) {
      throw DictException("Value serializer is not defined");
    }
    final load = slice.loadDict(resolvedKey, resolvedValue);
    for (final i in load.entries) {
      this[i.key] = i.value;
    }
  }

  Map<K, V> get asMap => Map<K, V>.fromEntries(entries);
}

/// 000000000000000
