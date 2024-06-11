import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary/dictionary.dart';
import 'package:ton_dart/src/dict/dictionary/key.dart';
import 'package:ton_dart/src/dict/dictionary/value.dart';
import 'package:ton_dart/src/dict/exception/exception.dart';

class DictionaryCodecs {
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

  static DictionaryValue<TonBaseAddress> createAddressValue() {
    return DictionaryValue<TonBaseAddress>(
      serialize: (src, builder) {
        builder.storeAddress(src);
      },
      parse: (src) {
        return src.loadAddress();
      },
    );
  }

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
