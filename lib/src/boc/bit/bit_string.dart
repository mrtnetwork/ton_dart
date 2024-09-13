import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'package:ton_dart/src/boc/utils/utils.dart';

class _BitStringUtils {
  static void validateOffset(int offset, int length, {int? at}) {
    if (offset.isNegative) {
      throw BocException("Offset is out of bounds",
          details: {"offset": offset, "length": length, "at": at});
    }
    final int index = offset + (at ?? 0);
    if (index > length) {
      throw BocException("Offset is out of bounds",
          details: {"offset": index, "length": length, "at": at});
    }
  }
}

/// A utility class to handle sequences of bits.
/// Provides methods to manipulate, retrieve, and clone bit-level data.
class BitString {
  /// Represents an empty `BitString`.
  static const BitString empty = BitString._(<int>[], 0, 0);

  final int _offset;
  final int _length;
  final List<int> _data;

  /// Returns the length of the bitstring.
  int get length => _length;

  /// Private constructor for `BitString`.
  const BitString._(this._data, this._offset, this._length);

  /// Constructs a `BitString` from raw data, with an offset and length.
  /// Throws a [BocException] if the length is out of bounds.
  factory BitString(List<int> data, int offset, int length) {
    if (length < 0) {
      throw BocException("Length is out of bounds",
          details: {"length": length});
    }
    return BitString._(
        BytesUtils.toBytes(data, unmodifiable: true), offset, length);
  }

  /// Returns a copy (clone) of this `BitString`.
  BitString clone() {
    return BitString(List<int>.from(_data), _offset, _length);
  }

  /// Returns the value of the bit at the specified index.
  /// Throws a [BocException] if the index is out of bounds.
  bool at(int index) {
    _BitStringUtils.validateOffset(index, _length);
    if (index >= _length) {
      throw BocException("index is out of bounds",
          details: {"index": index, "length": length});
    }

    int byteIndex = (_offset + index) >> 3;
    int bitIndex = 7 - ((_offset + index) % 8);

    return (_data[byteIndex] & (1 << bitIndex)) != 0;
  }

  /// Checks if the specified index is within the bitstring's length.
  /// Returns `true` if the bit exists, `false` otherwise.
  bool hasBit(int index) {
    if (index >= _length) {
      return false;
    }
    return true;
  }

  /// Returns a substring of the bitstring starting at the given offset and of the specified length.
  /// If the length is 0, returns the empty `BitString`.
  BitString substring(int offset, int length) {
    _BitStringUtils.validateOffset(offset, _length, at: length);
    if (length == 0) {
      return BitString.empty;
    }
    return BitString(_data, _offset + offset, length);
  }

  /// Returns a sub-buffer of the bitstring at the specified offset and length.
  /// The length must be a multiple of 8, and the offset must be byte-aligned.
  /// Returns `null` if these conditions are not met.
  List<int>? subbuffer(int offset, int length) {
    _BitStringUtils.validateOffset(offset, _length, at: length);
    if (length % 8 != 0) {
      return null;
    }
    if ((_offset + offset) % 8 != 0) {
      return null;
    }

    int start = ((_offset + offset) >> 3);
    int end = start + (length >> 3);
    return _data.sublist(start, end);
  }

  /// Converts the `BitString` to a hex string representation.
  @override
  String toString() {
    final padded = BocUtils.bitsToPaddedBuffer(this).buffer();

    if (_length % 4 == 0) {
      final hex = BytesUtils.toHexString(
          padded.sublist(0, (_length / 8).ceil()),
          lowerCase: false);
      if (_length % 8 == 0) {
        return hex;
      } else {
        return hex.substring(0, hex.length - 1);
      }
    } else {
      final hex = BytesUtils.toHexString(padded, lowerCase: false);
      if (_length % 8 <= 4) {
        return '${hex.substring(0, hex.length - 1)}_';
      } else {
        return '${hex}_';
      }
    }
  }

  /// Returns a copy of the internal data buffer as a list of bytes.
  List<int> get buffer => List<int>.from(_data);

  @override
  operator ==(other) {
    if (other is! BitString) return false;
    if (other.length != _length) return false;
    for (int i = 0; i < _length; i++) {
      if (at(i) != other.at(i)) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(_data, _length);
}
