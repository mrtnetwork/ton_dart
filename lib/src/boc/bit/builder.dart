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
  const BocSerializableObject();
  void store(Builder builder);
}

Builder beginCell() {
  return Builder();
}

/// A `Builder` class that facilitates storing bits, integers, addresses, coins,
/// and other complex data structures into a cell structure for serialization.
class Builder {
  /// Internal `BitBuilder` used to store bits.
  final BitBuilder _bits = BitBuilder();

  /// List of references (cells) stored within the builder.
  final List<Cell> _refs = [];

  /// Returns the number of references (cells) stored in the builder.
  int get refs => _refs.length;

  /// Returns the number of bits currently stored in the builder.
  int get bits => _bits.length;

  /// Returns the number of available bits left for storage.
  int get availableBits => 1023 - bits;

  /// Stores a single bit. If [value] is greater than 0, stores a `true` bit.
  Builder storeBit(int value) {
    _bits.writeBit(value > 0 ? true : false);
    return this;
  }

  /// Stores a boolean value as a bit.
  Builder storeBitBolean(bool value) {
    _bits.writeBit(value);
    return this;
  }

  /// Stores a `BitString` object.
  Builder storeBits(BitString src) {
    _bits.writeBits(src);
    return this;
  }

  /// Stores a buffer (list of integers) into the builder.
  Builder storeBuffer(List<int> src) {
    _bits.writeBuffer(src);
    return this;
  }

  /// Conditionally stores a buffer, depending on whether [src] is `null`.
  Builder storeMaybeBuffer(List<int>? src) {
    if (src != null) {
      storeBit(1);
      storeBuffer(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores an unsigned integer with a specified number of bits.
  Builder storeUint(dynamic value, int bits) {
    _bits.writeUint(value, bits);
    return this;
  }

  /// Stores an 8-bit unsigned integer.
  Builder storeUint8(dynamic value) {
    _bits.writeUint(value, 8);
    return this;
  }

  /// Stores a 4-bit unsigned integer.
  Builder storeUint4(dynamic value) {
    _bits.writeUint(value, 4);
    return this;
  }

  /// Stores a 32-bit unsigned integer.
  Builder storeUint32(dynamic value) {
    _bits.writeUint(value, 32);
    return this;
  }

  /// Stores a 64-bit unsigned integer.
  Builder storeUint64(dynamic value) {
    _bits.writeUint(value, 64);
    return this;
  }

  /// Stores a 256-bit unsigned integer.
  Builder storeUint256(dynamic value) {
    _bits.writeUint(value, 256);
    return this;
  }

  /// Stores a 16-bit unsigned integer.
  Builder storeUint16(dynamic value) {
    _bits.writeUint(value, 16);
    return this;
  }

  /// Conditionally stores an unsigned integer with the specified number of bits.
  Builder storeMaybeUint(dynamic value, int bits) {
    if (value != null) {
      storeBit(1);
      storeUint(value, bits);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores a signed integer with the specified number of bits.
  Builder storeInt(dynamic value, int bits) {
    _bits.writeInt(value, bits);
    return this;
  }

  /// Conditionally stores a signed integer with the specified number of bits.
  Builder storeMaybeInt(dynamic value, int bits) {
    if (value != null) {
      storeBit(1);
      storeInt(value, bits);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores a variable-length unsigned integer.
  Builder storeVarUint(dynamic value, int bits) {
    _bits.writeVarUint(value, bits);
    return this;
  }

  /// Conditionally stores a variable-length unsigned integer.
  Builder storeMaybeVarUint(dynamic value, int bits) {
    if (value != null) {
      storeBit(1);
      storeVarUint(value, bits);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores a variable-length signed integer.
  Builder storeVarInt(dynamic value, int bits) {
    _bits.writeVarInt(value, bits);
    return this;
  }

  /// Conditionally stores a variable-length signed integer.
  Builder storeMaybeVarInt(dynamic value, int bits) {
    if (value != null) {
      storeBit(1);
      storeVarInt(value, bits);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores a coin amount.
  Builder storeCoins(dynamic amount) {
    _bits.writeCoins(amount);
    return this;
  }

  /// Conditionally stores a coin amount.
  Builder storeMaybeCoins(dynamic amount) {
    if (amount != null) {
      storeBit(1);
      storeCoins(amount);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores a TON address.
  Builder storeAddress(TonBaseAddress? address) {
    _bits.writeAddress(address);
    return this;
  }

  /// Stores a reference (cell). Throws [BocException] if more than 4 references are added.
  Builder storeRef(Cell cell) {
    if (_refs.length >= 4) {
      throw BocException('Too many references.',
          details: {'maximum': 4, 'refrence': _refs.length});
    }
    _refs.add(cell);
    return this;
  }

  /// Conditionally stores a reference (cell).
  Builder storeMaybeRef({Cell? cell}) {
    if (cell != null) {
      storeBit(1);
      storeRef(cell);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores a slice of bits and references from another cell.
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

  /// Conditionally stores a slice.
  Builder storeMaybeSlice({Slice? src}) {
    if (src != null) {
      storeBit(1);
      storeSlice(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores another builder's contents as a slice.
  Builder storeBuilder(Builder src) {
    return storeSlice(src.endCell().beginParse());
  }

  /// Conditionally stores another builder's contents.
  Builder storeMaybeBuilder({Builder? src}) {
    if (src != null) {
      storeBit(1);
      storeBuilder(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores a `BocSerializableObject`.
  Builder storeWritable(BocSerializableObject writer) {
    writer.store(this);
    return this;
  }

  /// Conditionally stores a `BocSerializableObject`.
  Builder storeMaybeWritable({BocSerializableObject? writer}) {
    if (writer != null) {
      storeBit(1);
      storeWritable(writer);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Helper method to store a `BocSerializableObject`.
  Builder store(BocSerializableObject writer) {
    return storeWritable(writer);
  }

  /// Stores a string as a tail of bits.
  Builder storeStringTail(String src) {
    BocUtils.writeString(src, this);
    return this;
  }

  /// Stores a buffer (list of bytes) as a tail.
  Builder storeBytesTail(List<int> src) {
    BocUtils.writeBuffer(src, this);
    return this;
  }

  /// Conditionally stores a string tail.
  Builder storeMaybeStringTail({String? src}) {
    if (src != null) {
      storeBit(1);
      storeStringTail(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores a string reference tail.
  Builder storeStringRefTail(String src) {
    storeRef(beginCell().storeStringTail(src).asCell());
    return this;
  }

  /// Stores a bytes reference tail.
  Builder storeBytesRefTail(List<int> src) {
    storeRef(beginCell().storeBytesTail(src).asCell());
    return this;
  }

  /// Conditionally stores a string reference tail.
  Builder storeMaybeStringRefTail({String? src}) {
    if (src != null) {
      storeBit(1);
      storeStringRefTail(src);
    } else {
      storeBit(0);
    }
    return this;
  }

  /// Stores a dictionary with keys [K] and values [V].
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

  /// Stores a dictionary directly with keys [K] and values [V].
  Builder storeDictDirect<K extends Object, V>(Dictionary<K, V> dict,
      {DictionaryKey<K>? key, DictionaryValue<V>? value}) {
    dict.storeDirect(this, key: key, value: value);
    return this;
  }

  /// Finalizes the builder, returning a `Cell` with the stored bits and references.
  Cell endCell({bool? exotic}) {
    return Cell(bits: _bits.build(), refs: _refs, exotic: exotic ?? false);
  }

  /// Returns the cell built by the builder.
  Cell asCell() {
    return endCell();
  }

  /// Returns a `Slice` from the built cell.
  Slice asSlice() {
    return endCell().beginParse();
  }
}
