import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/exception/exception.dart';
import 'package:ton_dart/src/dict/serialization/serialization.dart';
import 'package:ton_dart/src/dict/utils/utils.dart';
import 'key.dart';
import 'value.dart';

/// Represents a dictionary where keys and values can be serialized and deserialized
/// using the provided key and value codecs.
class Dictionary<K extends Object, V> {
  final DictionaryKey<K>? _key;
  final DictionaryValue<V>? _value;
  final Map<String, V> _map;

  /// Gets the number of entries in the dictionary.
  int get size => _map.length;

  /// Constructs a `Dictionary` with the specified map, key codec, and value codec.
  Dictionary(this._map, this._key, this._value);

  /// Creates an empty dictionary with optional key and value codecs.
  static Dictionary<K, V> empty<K extends Object, V>(
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    if (key != null && value != null) {
      return Dictionary<K, V>(<String, V>{}, key, value);
    } else {
      return Dictionary<K, V>(<String, V>{}, null, null);
    }
  }

  /// Creates a dictionary from the given key, value codecs, and map of entries.
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

  /// Loads a dictionary from the given `Slice`. Returns an empty dictionary if no
  /// reference is found or if the cell is exotic.
  static Dictionary<K, V> load<K extends Object, V>(
      DictionaryKey<K> key, DictionaryValue<V> value, Slice slice) {
    final cell = slice.loadMaybeRef();
    if (cell != null && !cell.isExotic) {
      return loadDirect<K, V>(key: key, value: value, slice: cell.beginParse());
    } else {
      return empty<K, V>(key: key, value: value);
    }
  }

  /// Loads a dictionary directly from the given `Slice`. If the `Slice` is null,
  /// returns an empty dictionary.
  static Dictionary<K, V> loadDirect<K extends Object, V>(
      {required DictionaryKey<K> key,
      required DictionaryValue<V> value,
      required Slice? slice}) {
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

  /// Gets an iterable of the dictionary's values.
  Iterable<V> get values => _map.values;

  /// Retrieves the value for the given key, or `null` if the key is not present.
  V? operator [](K key) => _map[DictionaryUtils.serializeInternalKey(key)];

  /// Checks if the dictionary contains the given key.
  bool containsKey(K key) =>
      _map.containsKey(DictionaryUtils.serializeInternalKey(key));

  /// Adds or updates the value for the given key.
  void operator []=(K key, V value) {
    _map[DictionaryUtils.serializeInternalKey(key)] = value;
  }

  /// Removes the entry for the given key. Returns `true` if the key was removed.
  bool remove(K key) =>
      _map.remove(DictionaryUtils.serializeInternalKey(key)) != null;

  /// Clears all entries in the dictionary.
  void clear() => _map.clear();

  /// Gets an iterable of the dictionary's entries as `MapEntry<K, V>`.
  Iterable<MapEntry<K, V>> get entries sync* {
    for (final entry in _map.entries) {
      yield MapEntry(
          DictionaryUtils.deserializeInternalKey(entry.key), entry.value);
    }
  }

  /// Gets an iterable of the dictionary's keys.
  Iterable<K> get keys sync* {
    for (final key in _map.keys) {
      yield DictionaryUtils.deserializeInternalKey(key);
    }
  }

  /// Serializes the dictionary and stores it in the given `Builder`.
  /// Throws `DictException` if the key or value serializers are not defined.
  void store(Builder builder,
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    if (_map.isEmpty) {
      builder.storeBit(0);
    } else {
      final resolvedKey = key ?? _key;
      final resolvedValue = value ?? _value;
      if (resolvedKey == null) {
        throw DictException('Key serializer is not defined');
      }
      if (resolvedValue == null) {
        throw DictException('Value serializer is not defined');
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

  /// Serializes the dictionary directly into the `Builder`.
  /// Throws `DictException` if the dictionary is empty or if key/value serializers are not defined.
  void storeDirect(Builder builder,
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    if (_map.isEmpty) {
      throw DictException('Cannot store empty dictionary directly');
    }

    final resolvedKey = key ?? _key;
    final resolvedValue = value ?? _value;
    if (resolvedKey == null) {
      throw DictException('Key serializer is not defined');
    }
    if (resolvedValue == null) {
      throw DictException('Value serializer is not defined');
    }
    final prepared = Map<BigInt, V>.fromEntries(_map.entries.map((entry) =>
        MapEntry(
            resolvedKey
                .serialize(DictionaryUtils.deserializeInternalKey(entry.key)),
            entry.value)));
    DictSerialization.serialize(
        prepared, resolvedKey.bits, resolvedValue.serialize, builder);
  }

  /// Generates a Merkle proof for the given key.
  Cell generateMerkleProof(K key) =>
      DictionaryUtils.generateMerkleProof(this, key, _key!);

  /// Generates a Merkle update for the given key and new value.
  Cell generateMerkleUpdate(K key, V newValue) =>
      DictionaryUtils.generateMerkleUpdate<K, V>(this, key, _key!, newValue);

  /// Loads dictionary entries from a `Slice` and updates the dictionary.
  /// Throws `DictException` if key or value serializers are not defined.
  void loadFromClice(Slice slice,
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    final resolvedKey = key ?? _key;
    final resolvedValue = value ?? _value;
    if (resolvedKey == null) {
      throw DictException('Key serializer is not defined');
    }
    if (resolvedValue == null) {
      throw DictException('Value serializer is not defined');
    }
    final load = slice.loadDict(resolvedKey, resolvedValue);
    for (final i in load.entries) {
      this[i.key] = i.value;
    }
  }

  /// Converts the dictionary to a `Map<K, V>`.
  Map<K, V> get asMap => Map<K, V>.fromEntries(entries);
}
