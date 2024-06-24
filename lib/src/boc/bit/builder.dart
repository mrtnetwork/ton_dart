import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'package:ton_dart/src/boc/utils/utils.dart';
import 'package:ton_dart/src/dict/dictionary/dictionary.dart';
import 'package:ton_dart/src/dict/dictionary/key.dart';
import 'package:ton_dart/src/dict/dictionary/value.dart';
import 'bit_builder.dart';
import '../cell/cell.dart';
import '../cell/slice.dart';

abstract class BocSerializableObject {
  void store(Builder builder);
}

Builder beginCell() {
  return Builder();
}

class Builder {
  final BitBuilder _bits = BitBuilder();
  final List<Cell> _refs = [];
  int get refs => _refs.length;

  int get bits => _bits.length;
  int get availableBits => 1023 - bits;

  Builder storeBit(int value) {
    _bits.writeBit(value > 0 ? true : false);
    return this;
  }

  Builder storeBitBolean(bool value) {
    _bits.writeBit(value);
    return this;
  }

  Builder storeBits(BitString src) {
    _bits.writeBits(src);
    return this;
  }

  Builder storeBuffer(List<int> src) {
    _bits.writeBuffer(src);
    return this;
  }

  Builder storeMaybeBuffer(List<int>? src) {
    if (src != null) {
      storeBit(1);
      storeBuffer(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeUint(dynamic value, int bits) {
    _bits.writeUint(value, bits);
    return this;
  }

  Builder storeUint8(dynamic value) {
    _bits.writeUint(value, 8);
    return this;
  }

  Builder storeUint32(dynamic value) {
    _bits.writeUint(value, 32);
    return this;
  }

  Builder storeUint64(dynamic value) {
    _bits.writeUint(value, 64);
    return this;
  }

  Builder storeUint16(dynamic value) {
    _bits.writeUint(value, 16);
    return this;
  }

  Builder storeMaybeUint(dynamic value, int bits) {
    if (value != null) {
      storeBit(1);
      storeUint(value, bits);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeInt(dynamic value, int bits) {
    _bits.writeInt(value, bits);
    return this;
  }

  Builder storeMaybeInt(dynamic value, int bits) {
    if (value != null) {
      storeBit(1);
      storeInt(value, bits);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeVarUint(dynamic value, int bits) {
    _bits.writeVarUint(value, bits);
    return this;
  }

  Builder storeMaybeVarUint(dynamic value, int bits) {
    if (value != null) {
      storeBit(1);
      storeVarUint(value, bits);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeVarInt(dynamic value, int bits) {
    _bits.writeVarInt(value, bits);
    return this;
  }

  Builder storeMaybeVarInt(dynamic value, int bits) {
    if (value != null) {
      storeBit(1);
      storeVarInt(value, bits);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeCoins(dynamic amount) {
    _bits.writeCoins(amount);
    return this;
  }

  Builder storeMaybeCoins(dynamic amount) {
    if (amount != null) {
      storeBit(1);
      storeCoins(amount);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeAddress(TonBaseAddress? address) {
    _bits.writeAddress(address);
    return this;
  }

  Builder storeRef(Cell cell) {
    if (_refs.length >= 4) {
      throw BocException("Too many references.",
          details: {"maximum": 4, "refrence": _refs.length});
    }
    _refs.add(cell);
    return this;
  }

  Builder storeMaybeRef({Cell? cell}) {
    if (cell != null) {
      storeBit(1);
      storeRef(cell);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeSlice(Slice src) {
    final c = src.clone();
    if (c.remainingBits > 0) {
      storeBits(c.loadBits(c.remainingBits));
    }
    while (c.remainingRefs > 0) {
      storeRef(c.loadRef());
    }
    return this;
  }

  Builder storeMaybeSlice({Slice? src}) {
    if (src != null) {
      storeBit(1);
      storeSlice(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeBuilder(Builder src) {
    return storeSlice(src.endCell().beginParse());
  }

  Builder storeMaybeBuilder({Builder? src}) {
    if (src != null) {
      storeBit(1);
      storeBuilder(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeWritable(BocSerializableObject writer) {
    writer.store(this);
    return this;
  }

  Builder storeMaybeWritable({BocSerializableObject? writer}) {
    if (writer != null) {
      storeBit(1);
      storeWritable(writer);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder store(BocSerializableObject writer) {
    return storeWritable(writer);
  }

  Builder storeStringTail(String src) {
    BocUtils.writeString(src, this);
    return this;
  }

  Builder storeBytesTail(List<int> src) {
    BocUtils.writeBuffer(src, this);
    return this;
  }

  Builder storeMaybeStringTail({String? src}) {
    if (src != null) {
      storeBit(1);
      storeStringTail(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeStringRefTail(String src) {
    storeRef(beginCell().storeStringTail(src).asCell());
    return this;
  }

  Builder storeBytesRefTail(List<int> src) {
    storeRef(beginCell().storeBytesTail(src).asCell());
    return this;
  }

  Builder storeMaybeStringRefTail({String? src}) {
    if (src != null) {
      storeBit(1);
      storeStringRefTail(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeDict<K extends Object, V>(
      {Dictionary<K, V>? dict,
      DictionaryKey<K>? key,
      DictionaryValue<V>? value}) {
    if (dict != null) {
      dict.store(this, key: key, value: value);
    } else {
      storeBit(0);
    }
    return this;
  }

  Builder storeDictDirect<K extends Object, V>(Dictionary<K, V> dict,
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    dict.storeDirect(this, key: key, value: value);
    return this;
  }

  Cell endCell({bool? exotic}) {
    return Cell(bits: _bits.build(), refs: _refs, exotic: exotic ?? false);
  }

  Cell asCell() {
    return endCell();
  }

  Slice asSlice() {
    return endCell().beginParse();
  }
}
