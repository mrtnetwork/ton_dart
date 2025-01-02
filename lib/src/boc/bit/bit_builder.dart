// Copyright (c) Whales Corp.
// All Rights Reserved.
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'bit_string.dart';

class _BitBuilderUtils {
  static final mask8Big = BigInt.from(0xff);
  static void validateBits(int bits) {
    if (bits < 0) {
      throw BocException('Invalid bit length.', details: {'length': bits});
    }
  }

  static BigInt parseBigint(dynamic value, {bool sign = false}) {
    if (value is! int && value is! BigInt) {
      throw BocException('Invalid integer type. value must be int or BigInt.',
          details: {'value': value, 'type': value.runtimeType.toString()});
    }
    BigInt val;
    if (value is int) {
      val = BigInt.from(value);
    } else {
      val = value;
    }
    if (!sign && val.isNegative) {
      throw BocException('Invalid unsigned integer.', details: {'value': val});
    }
    return val;
  }
}

/// A class for building and manipulating bits in a buffer.
class BitBuilder {
  final List<int> _bytes;
  int _length;

  /// Initializes a bit builder with a byte buffer of specified size.
  BitBuilder({int size = 1023})
      : _bytes = List<int>.filled((size / 8).ceil(), 0),
        _length = 0;

  /// Returns the current length of the bit stream.
  int get length => _length;

  /// Writes a single bit to the buffer.
  void writeBit(bool value) {
    if (_length > _bytes.length * 8) {
      throw BocException('Overflow bytes',
          details: {'offset': _length, 'length': _bytes.length * 8});
    }
    if (value) {
      _bytes[(_length / 8).floor()] |= 1 << (7 - (_length % 8));
    }

    _length++;
  }

  /// Writes a sequence of bits from a [BitString].
  void writeBits(BitString src) {
    for (int i = 0; i < src.length; i++) {
      writeBit(src.at(i));
    }
  }

  /// Writes a buffer of bytes to the bit stream.
  void writeBuffer(List<int> src) {
    BytesUtils.validateBytes(src);
    if (_length % 8 == 0) {
      if (_length + src.length * 8 > _bytes.length * 8) {
        throw BocException('Overflow bytes', details: {
          'offset': _length + src.length * 8,
          'length': _bytes.length * 8
        });
      }
      _bytes.setRange(_length ~/ 8, (_length ~/ 8) + src.length, src);
      _length += src.length * 8;
    } else {
      for (int i = 0; i < src.length; i++) {
        writeUint(src[i], 8);
      }
    }
  }

  /// Writes an unsigned integer value using a specified number of bits.
  void writeUint(dynamic value, int bits) {
    _BitBuilderUtils.validateBits(bits);
    final BigInt v = _BitBuilderUtils.parseBigint(value);

    if (bits == 0) {
      if (v != BigInt.zero) {
        throw BocException('value is not zero for $bits bits.',
            details: {'value': v});
      } else {
        return;
      }
    }

    if (v.bitLength > bits) {
      throw BocException('BitLength is too small for a value.',
          details: {'value': v, 'bits': bits, 'value_bitLength': v.bitLength});
    }

    if (_length + bits > _bytes.length * 8) {
      throw BocException('BitBuilder overflow');
    }

    final int tillByte = 8 - (_length % 8);
    if (tillByte > 0) {
      final int bidx = (_length / 8).floor();
      if (bits < tillByte) {
        final int wb = v.toInt();
        _bytes[bidx] |= wb << (tillByte - bits);
        _length += bits;
      } else {
        final int wb = (v >> (bits - tillByte)).toInt();
        _bytes[bidx] |= wb;
        _length += tillByte;
      }
    }
    bits -= tillByte;
    while (bits > 0) {
      if (bits >= 8) {
        _bytes[_length ~/ 8] =
            ((v >> (bits - 8)) & _BitBuilderUtils.mask8Big).toInt();
        _length += 8;
        bits -= 8;
      } else {
        _bytes[_length ~/ 8] =
            ((v << (8 - bits)) & _BitBuilderUtils.mask8Big).toInt();
        _length += bits;
        bits = 0;
      }
    }
  }

  /// Writes a signed integer value using a specified number of bits.
  void writeInt(dynamic value, int bits) {
    _BitBuilderUtils.validateBits(bits);
    BigInt v = _BitBuilderUtils.parseBigint(value, sign: true);

    if (bits == 0) {
      if (value != BigInt.zero) {
        throw BocException('value is not zero for $bits bits.',
            details: {'value': v});
      } else {
        return;
      }
    }

    if (bits == 1) {
      if (value != -BigInt.one && value != BigInt.zero) {
        throw BocException('value is not zero or -1 for $bits bits.',
            details: {'value': v});
      } else {
        writeBit(value == -BigInt.one);
        return;
      }
    }

    final BigInt vBits = BigInt.one << (bits - 1);
    if (v < -vBits || v >= vBits) {
      throw BocException('Out of range.',
          details: {'value': v, 'length': bits});
    }

    if (v < BigInt.zero) {
      writeBit(true);
      v = vBits + v;
    } else {
      writeBit(false);
    }

    writeUint(v, bits - 1);
  }

  /// Writes a variable-length unsigned integer value.
  void writeVarUint(dynamic value, int bits) {
    _BitBuilderUtils.validateBits(bits);
    final BigInt v = _BitBuilderUtils.parseBigint(value);

    if (v == BigInt.zero) {
      writeUint(0, bits);
      return;
    }

    final int sizeBytes = (v.bitLength + 7) ~/ 8;
    final int sizeBits = sizeBytes * 8;

    writeUint(sizeBytes, bits);

    writeUint(v, sizeBits);
  }

  /// Writes a variable-length signed integer value.
  void writeVarInt(dynamic value, int bits) {
    _BitBuilderUtils.validateBits(bits);
    final BigInt v = _BitBuilderUtils.parseBigint(value, sign: true);
    if (v == BigInt.zero) {
      writeUint(0, bits);
      return;
    }
    final BigInt v2 = v > BigInt.zero ? v : -v;
    final int sizeBytes = 1 + (v2.bitLength + 7) ~/ 8;
    final int sizeBits = sizeBytes * 8;
    writeUint(sizeBytes, bits);
    writeInt(v, sizeBits);
  }

  /// Writes the specified amount as coins.
  void writeCoins(dynamic amount) {
    writeVarUint(amount, 4);
  }

  /// Writes a TON base address or an external address.
  void writeAddress(TonBaseAddress? address) {
    if (address == null) {
      writeUint(0, 2);
    } else if (address is TonAddress) {
      writeUint(2, 2);
      writeUint(0, 1);
      writeInt(address.workChain, 8);
      writeBuffer(address.hash);
    } else {
      final ExternalAddress extAddress = address as ExternalAddress;
      writeUint(1, 2);
      writeUint(extAddress.bits, 9);
      writeUint(extAddress.value, extAddress.bits);
    }
  }

  /// Builds a [BitString] from the current buffer.
  BitString build() {
    return BitString(_bytes, 0, _length);
  }

  /// Returns the current buffer if it's byte-aligned.
  List<int> buffer() {
    if (_length % 8 != 0) {
      throw BocException('Buffer is not byte aligned');
    }
    return List<int>.unmodifiable(_bytes.sublist(0, _length ~/ 8));
  }

  /// Returns the byte buffer.
  List<int> toBytes() => List<int>.from(_bytes);
}
