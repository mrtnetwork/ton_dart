import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary/dictionary.dart';
import 'package:ton_dart/src/dict/dictionary/key.dart';
import 'package:ton_dart/src/dict/dictionary/value.dart';
import 'package:ton_dart/src/dict/exception/exception.dart';

/// Provides factory methods for creating `DictionaryKey` and `DictionaryValue`
/// instances for various data types, used in serialization and deserialization
/// within dictionaries.
class DictionaryCodecs {
  /// Creates a `DictionaryKey` for `TonBaseAddress` with a fixed bit length of 267.
  ///
  /// The `serialize` function stores the address in a cell and encodes it as a
  /// big integer. The `parse` function decodes the big integer from a cell and
  /// retrieves the address.
  static DictionaryKey<TonBaseAddress> createAddressKey() {
    return DictionaryKey<TonBaseAddress>(
      bits: 267,
      serialize: (src) {
        return beginCell()
            .storeAddress(src)
            .endCell()
            .beginParse()
            .preloadUintBig(267);
      },
      parse: (src) {
        return beginCell()
            .storeUint(src, 267)
            .endCell()
            .beginParse()
            .loadAddress();
      },
    );
  }

  /// Creates a `DictionaryKey` for `BigInt` with a specified bit length.
  ///
  /// The `serialize` function stores the big integer in a cell and encodes it as
  /// a big integer. The `parse` function decodes the big integer from a cell and
  /// retrieves the big integer.
  static DictionaryKey<BigInt> createBigIntKey(int bits) {
    return DictionaryKey<BigInt>(
      bits: bits,
      serialize: (src) {
        return beginCell()
            .storeInt(src, bits)
            .endCell()
            .beginParse()
            .loadUintBig(bits);
      },
      parse: (src) {
        return beginCell()
            .storeUint(src, bits)
            .endCell()
            .beginParse()
            .loadIntBig(bits);
      },
    );
  }

  /// Creates a `DictionaryKey` for `int` with a specified bit length.
  ///
  /// The `serialize` function stores the integer in a cell and encodes it as
  /// a big integer. The `parse` function decodes the big integer from a cell and
  /// retrieves the integer.
  static DictionaryKey<int> createIntKey(int bits) {
    return DictionaryKey<int>(
      bits: bits,
      serialize: (src) {
        if (!src.isFinite) {
          throw DictException('Key is not a safe integer.');
        }
        return beginCell()
            .storeInt(src, bits)
            .endCell()
            .beginParse()
            .loadUintBig(bits);
      },
      parse: (src) {
        return beginCell()
            .storeUint(src, bits)
            .endCell()
            .beginParse()
            .loadInt(bits);
      },
    );
  }

  /// Creates a `DictionaryKey` for `BigInt` with a specified bit length for unsigned integers.
  ///
  /// The `serialize` function checks if the big integer is non-negative, stores it in a
  /// cell, and encodes it as a big integer. The `parse` function decodes the big integer
  /// from a cell and retrieves it.
  static DictionaryKey<BigInt> createBigUintKey(int bits) {
    return DictionaryKey<BigInt>(
      bits: bits,
      serialize: (src) {
        if (src.isNegative) {
          throw DictException("Key is negative.", details: {"key": src});
        }
        return beginCell()
            .storeUint(src, bits)
            .endCell()
            .beginParse()
            .loadUintBig(bits);
      },
      parse: (src) {
        return beginCell()
            .storeUint(src, bits)
            .endCell()
            .beginParse()
            .loadUintBig(bits);
      },
    );
  }

  /// Creates a `DictionaryKey` for `int` with a specified bit length for unsigned integers.
  ///
  /// The `serialize` function checks if the integer is finite and non-negative,
  /// stores it in a cell, and encodes it as a big integer. The `parse` function decodes
  /// the big integer from a cell and retrieves it as an `int`.
  static DictionaryKey<int> createUintKey(int bits) {
    return DictionaryKey<int>(
      bits: bits,
      serialize: (src) {
        if (!src.isFinite) {
          throw DictException("Key is not a safe integer.");
        }
        if (src.isNegative) {
          throw DictException("Key is negative.", details: {"key": src});
        }
        return beginCell()
            .storeUint(src, bits)
            .endCell()
            .beginParse()
            .loadUintBig(bits);
      },
      parse: (src) {
        return int.parse(beginCell()
            .storeUint(src, bits)
            .endCell()
            .beginParse()
            .loadUint(bits)
            .toString());
      },
    );
  }

  /// Creates a `DictionaryKey` for a `List<int>` with a specified byte length.
  ///
  /// The `serialize` function stores the buffer in a cell and encodes it as a
  /// big integer. The `parse` function decodes the big integer from a cell and
  /// retrieves the buffer.
  static DictionaryKey<List<int>> createBufferKey(int bytes) {
    return DictionaryKey<List<int>>(
      bits: bytes * 8,
      serialize: (src) {
        return beginCell()
            .storeBuffer(src)
            .endCell()
            .beginParse()
            .loadUintBig(bytes * 8);
      },
      parse: (src) {
        return beginCell()
            .storeUint(src, bytes * 8)
            .endCell()
            .beginParse()
            .loadBuffer(bytes);
      },
    );
  }

  /// Creates a `DictionaryKey` for `BitString` with a specified bit length.
  ///
  /// The `serialize` function stores the bit string in a cell and encodes it as
  /// a big integer. The `parse` function decodes the big integer from a cell and
  /// retrieves the bit string.
  static DictionaryKey<BitString> createBitStringKey(int bits) {
    return DictionaryKey<BitString>(
      bits: bits,
      serialize: (src) {
        final res =
            beginCell().storeBits(src).endCell().beginParse().loadUintBig(bits);
        return res;
      },
      parse: (src) {
        return beginCell()
            .storeUint(src, bits)
            .endCell()
            .beginParse()
            .loadBits(bits);
      },
    );
  }

  /// Creates a `DictionaryValue` for `int` with a specified bit length.
  ///
  /// The `serialize` function stores the integer in a builder with the specified bit length.
  /// The `parse` function retrieves the integer from the source with the specified bit length.
  static DictionaryValue<int> createIntValue(int bits) {
    return DictionaryValue<int>(
      serialize: (src, builder) {
        builder.storeInt(src, bits);
      },
      parse: (src) {
        return src.loadInt(bits);
      },
    );
  }

  /// Creates a `DictionaryValue` for `BigInt` with a specified bit length.
  ///
  /// The `serialize` function stores the big integer in a builder with the specified bit length.
  /// The `parse` function retrieves the big integer from the source with the specified bit length.
  static DictionaryValue<BigInt> createBigIntValue(int bits) {
    return DictionaryValue<BigInt>(
      serialize: (src, builder) {
        builder.storeInt(src, bits);
      },
      parse: (src) {
        return src.loadIntBig(bits);
      },
    );
  }

  /// Creates a `DictionaryValue` for `BigInt` with a specified bit length using variable-length encoding.
  ///
  /// The `serialize` function stores the big integer in a builder with variable-length encoding.
  /// The `parse` function retrieves the big integer from the source using variable-length encoding.
  static DictionaryValue<BigInt> createBigVarIntValue(int bits) {
    return DictionaryValue<BigInt>(
      serialize: (src, builder) {
        builder.storeVarInt(src, bits);
      },
      parse: (src) {
        return src.loadVarIntBig(bits);
      },
    );
  }

  /// Creates a `DictionaryValue` for `BigInt` with a specified bit length using variable-length encoding.
  ///
  /// The `serialize` function stores the big integer in a builder with variable-length encoding.
  /// The `parse` function retrieves the big integer from the source using variable-length encoding.
  static DictionaryValue<BigInt> createBigVarUintValue(int bits) {
    return DictionaryValue<BigInt>(
      serialize: (src, builder) {
        builder.storeVarUint(src, bits);
      },
      parse: (src) {
        return src.loadVarUintBig(bits);
      },
    );
  }

  /// Creates a `DictionaryValue` for `int` with a specified bit length for unsigned integers.
  ///
  /// The `serialize` function stores the integer in a builder with the specified bit length.
  /// The `parse` function retrieves the integer from the source with the specified bit length.
  static DictionaryValue<int> createUintValue(int bits) {
    return DictionaryValue<int>(
      serialize: (src, builder) {
        builder.storeUint(src, bits);
      },
      parse: (src) {
        return src.loadUint(bits);
      },
    );
  }

  /// Creates a `DictionaryValue` for `BigInt` with a specified bit length for unsigned integers.
  ///
  /// The `serialize` function stores the big integer in a builder with the specified bit length.
  /// The `parse` function retrieves the big integer from the source with the specified bit length.
  static DictionaryValue<BigInt> createBigUintValue(int bits) {
    return DictionaryValue<BigInt>(
      serialize: (src, builder) {
        builder.storeUint(src, bits);
      },
      parse: (src) {
        return src.loadUintBig(bits);
      },
    );
  }

  /// Creates a `DictionaryValue` for `bool`.
  ///
  /// The `serialize` function stores the boolean value as a single bit (0 or 1).
  /// The `parse` function retrieves the boolean value from the source.
  static DictionaryValue<bool> createBooleanValue() {
    return DictionaryValue<bool>(
      serialize: (src, builder) {
        builder.storeBit(src ? 1 : 0);
      },
      parse: (src) {
        return src.loadBit();
      },
    );
  }

  /// Creates a `DictionaryValue` for `TonAddress`.
  ///
  /// The `serialize` function stores the `TonAddress` in a builder.
  /// The `parse` function retrieves the `TonAddress` from the source.
  static DictionaryValue<TonAddress> createAddressValue() {
    return DictionaryValue<TonAddress>(
      serialize: (src, builder) {
        builder.storeAddress(src);
      },
      parse: (src) {
        return src.loadAddress();
      },
    );
  }

  /// Creates a `DictionaryValue` for `TonBaseAddress`.
  ///
  /// The `serialize` function stores the `TonBaseAddress` in a builder.
  /// The `parse` function retrieves the `TonBaseAddress` from the source.
  static DictionaryValue<TonBaseAddress> createBaseAddressValue() {
    return DictionaryValue<TonBaseAddress>(
      serialize: (src, builder) {
        builder.storeAddress(src);
      },
      parse: (src) {
        return src.loadAddress();
      },
    );
  }

  /// Creates a `DictionaryValue` for `Cell`.
  ///
  /// The `serialize` function stores the `Cell` as a reference in the builder.
  /// The `parse` function retrieves the `Cell` from the source.
  static DictionaryValue<Cell> createCellValue() {
    return DictionaryValue<Cell>(
      serialize: (src, builder) {
        builder.storeRef(src);
      },
      parse: (src) {
        return src.loadRef();
      },
    );
  }

  /// Creates a `DictionaryValue` for a `Dictionary` with specified key and value codecs.
  ///
  /// The `serialize` function stores the dictionary in the builder using the provided key and value codecs.
  /// The `parse` function retrieves the dictionary from the source using the provided key and value codecs.
  static DictionaryValue<Dictionary<K, V>>
      createDictionaryValue<K extends Object, V>(
          DictionaryKey<K> key, DictionaryValue<V> value) {
    return DictionaryValue<Dictionary<K, V>>(
      serialize: (src, builder) {
        src.store(builder);
      },
      parse: (src) {
        return Dictionary.load(key, value, src);
      },
    );
  }

  /// Creates a `DictionaryValue` for a `List<int>` with a specified size.
  ///
  /// The `serialize` function stores the buffer in the builder and validates its size.
  /// The `parse` function retrieves the buffer from the source with the specified size.
  static DictionaryValue<List<int>> createBufferValue(int size) {
    return DictionaryValue<List<int>>(
      serialize: (src, builder) {
        if (src.length != size) {
          throw DictException("Invalid buffer size.",
              details: {"size": size, "source_length": src.length});
        }
        builder.storeBuffer(src);
      },
      parse: (src) {
        return src.loadBuffer(size);
      },
    );
  }

  /// Creates a `DictionaryValue` for `BitString` with a specified bit length.
  ///
  /// The `serialize` function stores the bit string in the builder and validates its length.
  /// The `parse` function retrieves the bit string from the source with the specified bit length.
  static DictionaryValue<BitString> createBitStringValue(int bits) {
    return DictionaryValue<BitString>(
      serialize: (src, builder) {
        if (src.length != bits) {
          throw DictException("Invalid BitString size.",
              details: {"size": bits, "source_length": src.length});
        }
        builder.storeBits(src);
      },
      parse: (src) {
        return src.loadBits(bits);
      },
    );
  }
}
