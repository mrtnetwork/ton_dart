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

class BitString {
  static const BitString empty = BitString._(<int>[], 0, 0);

  final int _offset;
  final int _length;
  final List<int> _data;
  int get length => _length;

  const BitString._(this._data, this._offset, this._length);
  factory BitString(List<int> data, int offset, int length) {
    if (length < 0) {
      throw BocException("Length is out of bounds",
          details: {"length": length});
    }
    return BitString._(
        BytesUtils.toBytes(data, unmodifiable: true), offset, length);
  }

  BitString clone() {
    return BitString(List<int>.from(_data), _offset, _length);
  }

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

  BitString substring(int offset, int length) {
    _BitStringUtils.validateOffset(offset, _length, at: length);
    if (length == 0) {
      return BitString.empty;
    }
    return BitString(_data, _offset + offset, length);
  }

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

  List<int> get buffer => List<int>.from(_data);
}
