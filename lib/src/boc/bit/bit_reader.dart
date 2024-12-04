import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'bit_string.dart';

/// A reader for handling bit-level operations on a `BitString`.
/// It allows loading, preloading, and skipping of bits or byte-level data.
class BitReader {
  final List<int> _checkpoints = [];
  final BitString _bits;
  int _offset;

  /// Returns the current bit offset.
  int get offset => _offset;

  /// Returns the number of remaining bits in the `BitString`.
  int get remaining => _bits.length - _offset;

  /// Constructs a `BitReader` with the given `BitString` and optional offset.
  BitReader(this._bits, {int offset = 0}) : _offset = offset;

  /// Skips the specified number of bits, advancing the offset.
  void skip(int bits) {
    if (bits < 0 || _offset + bits > _bits.length) {
      throw BocException('Index out of bounds', details: {
        "length": bits,
        "offset": _offset,
        "index": _offset + bits
      });
    }
    _offset += bits;
  }

  /// Resets the offset to the last saved checkpoint, or to 0 if none exists.
  void reset() {
    if (_checkpoints.isNotEmpty) {
      _offset = _checkpoints.removeLast();
    } else {
      _offset = 0;
    }
  }

  /// Saves the current offset as a checkpoint.
  void save() {
    _checkpoints.add(_offset);
  }

  /// Loads a single bit and increments the offset.
  bool loadBit() {
    final bool r = _bits.at(_offset);
    _offset++;
    return r;
  }

  /// Preloads a single bit without changing the offset.
  bool preloadBit() {
    return _bits.at(_offset);
  }

  /// Loads the specified number of bits and increments the offset.
  BitString loadBits(int bits) {
    final BitString r = _bits.substring(_offset, bits);
    _offset += bits;
    return r;
  }

  /// Preloads the specified number of bits without changing the offset.
  BitString preloadBits(int bits) {
    return _bits.substring(_offset, bits);
  }

  /// Loads a buffer of the specified number of bytes and increments the offset.
  List<int> loadBuffer(int bytes) {
    final List<int> buf = _preloadBuffer(bytes, _offset);
    _offset += bytes * 8;
    return buf;
  }

  /// Preloads a buffer of the specified number of bytes without changing the offset.
  List<int> preloadBuffer(int bytes) {
    return _preloadBuffer(bytes, _offset);
  }

  /// Loads an unsigned integer of the specified number of bits.
  int loadUint(int bits) {
    return loadUintBig(bits).toInt();
  }

  /// Loads a large unsigned integer (BigInt) of the specified number of bits.
  BigInt loadUintBig(int bits) {
    final BigInt loaded = _preloadUint(bits, _offset);
    _offset += bits;
    return loaded;
  }

  /// Preloads an unsigned integer of the specified number of bits.
  int preloadUint(int bits) {
    return _preloadUint(bits, _offset).toInt();
  }

  /// Preloads a large unsigned integer (BigInt) of the specified number of bits.
  BigInt preloadUintBig(int bits) {
    return _preloadUint(bits, _offset);
  }

  /// Loads a signed integer of the specified number of bits.
  int loadInt(int bits) {
    return loadIntBig(bits).toInt();
  }

  /// Loads a large signed integer (BigInt) of the specified number of bits.
  BigInt loadIntBig(int bits) {
    final BigInt res = _preloadInt(bits, _offset);
    _offset += bits;
    return res;
  }

  /// Preloads a signed integer of the specified number of bits.
  int preloadInt(int bits) {
    return _preloadInt(bits, _offset).toInt();
  }

  /// Preloads a large signed integer (BigInt) of the specified number of bits.
  BigInt preloadIntBig(int bits) {
    return _preloadInt(bits, _offset);
  }

  /// Loads a variable-length unsigned integer, with a specified number of size bits.
  int loadVarUint(int bits) {
    final int size = loadUint(bits);
    return loadUintBig(size * 8).toInt();
  }

  /// Loads a variable-length unsigned integer (BigInt).
  BigInt loadVarUintBig(int bits) {
    final int size = loadUint(bits);
    return loadUintBig(size * 8);
  }

  /// Preloads a variable-length unsigned integer.
  int preloadVarUint(int bits) {
    return preloadVarUintBig(bits).toInt();
  }

  /// Preloads a variable-length unsigned integer (BigInt).
  BigInt preloadVarUintBig(int bits) {
    final int size = _preloadUint(bits, offset).toInt();
    return _preloadUint(size * 8, offset + bits);
  }

  /// Loads a variable-length signed integer.
  int loadVarInt(int bits) {
    return loadVarIntBig(bits).toInt();
  }

  /// Loads a variable-length signed integer (BigInt).
  BigInt loadVarIntBig(int bits) {
    final int size = loadUint(bits);
    return loadIntBig(size * 8);
  }

  /// Preloads a variable-length signed integer.
  int preloadVarInt(int bits) {
    return preloadVarIntBig(bits).toInt();
  }

  /// Preloads a variable-length signed integer (BigInt).
  BigInt preloadVarIntBig(int bits) {
    final int size = _preloadInt(bits, offset).toInt();
    return _preloadInt(size * 8, offset + bits);
  }

  /// Loads a value in coins (as BigInt).
  BigInt loadCoins() {
    return loadVarUintBig(4);
  }

  /// Preloads a value in coins.
  BigInt preloadCoins() {
    return preloadVarUintBig(4);
  }

  /// Loads a TON address from the bitstream.
  TonAddress loadAddress() {
    return _loadInternalAddress();
  }

  /// Loads a TON address if it exists, otherwise returns null.
  TonAddress? loadMaybeAddress() {
    final int type = preloadUint(2);
    if (type == 0) {
      _offset += 2;
      return null;
    }
    return _loadInternalAddress();
  }

  /// Loads an external address from the bitstream.
  ExternalAddress loadExternalAddress() {
    return _loadExternalAddress();
  }

  /// Loads an external address if it exists, otherwise returns null.
  ExternalAddress? loadMaybeExternalAddress() {
    final int type = preloadUint(2);
    if (type == 0) {
      _offset += 2;
      return null;
    }
    return _loadExternalAddress();
  }

  /// Loads any type of address (TON or external), or returns null if none exists.
  TonBaseAddress? loadAddressAny() {
    final int type = preloadUint(2);
    if (type == 0) {
      _offset += 2;
      return null;
    } else if (type == 2) {
      return _loadInternalAddress();
    } else if (type == 1) {
      return _loadExternalAddress();
    } else if (type == 3) {
      throw BocException('Unsupported adress type.');
    } else {
      throw BocException('Invalid address type.');
    }
  }

  /// Loads bits, taking into account padding (ensures byte-aligned).
  BitString loadPaddedBits(int bits) {
    if (bits % 8 != 0) {
      throw BocException("Invalid number of bits", details: {"bits": bits});
    }

    int length = bits;
    while (true) {
      if (_bits.at(_offset + length - 1)) {
        length--;
        break;
      } else {
        length--;
      }
    }

    final BitString r = _bits.substring(_offset, length);
    _offset += bits;
    return r;
  }

  /// Creates a clone of the current `BitReader`, preserving the bitstream and offset.
  BitReader clone() {
    return BitReader(_bits.clone(), offset: _offset);
  }

  BigInt _preloadInt(int bits, int offset) {
    if (bits == 0) {
      return BigInt.zero;
    }
    final bool sign = _bits.at(offset);
    BigInt res = BigInt.zero;
    for (int i = 0; i < bits - 1; i++) {
      if (_bits.at(offset + 1 + i)) {
        res += BigInt.one << (bits - i - 1 - 1);
      }
    }
    if (sign) {
      res -= BigInt.one << (bits - 1);
    }
    return res;
  }

  BigInt _preloadUint(int bits, int offset) {
    if (bits == 0) {
      return BigInt.zero;
    }
    BigInt res = BigInt.zero;
    for (int i = 0; i < bits; i++) {
      if (_bits.at(offset + i)) {
        res += BigInt.one << (bits - i - 1);
      }
    }
    return res;
  }

  List<int> _preloadBuffer(int bytes, int offset) {
    final List<int>? fastBuffer = _bits.subbuffer(offset, bytes * 8);
    if (fastBuffer != null) {
      return fastBuffer;
    }

    final List<int> buf = List<int>.filled(bytes, 0);
    for (int i = 0; i < bytes; i++) {
      buf[i] = _preloadUint(8, offset + i * 8).toInt();
    }
    return buf;
  }

  TonAddress _loadInternalAddress() {
    final int type = preloadUint(2);
    if (type != 2) {
      throw BocException("Invalid address.");
    }

    if (_preloadUint(1, _offset + 2) != BigInt.zero) {
      throw BocException("Invalid address.");
    }

    final int wc = _preloadInt(8, _offset + 3).toInt();
    final List<int> hash = _preloadBuffer(32, _offset + 11);

    _offset += 267;

    return TonAddress.fromBytes(wc, hash);
  }

  ExternalAddress _loadExternalAddress() {
    final int type = preloadUint(2);
    if (type != 1) {
      throw BocException('Invalid extenal address.');
    }

    final int bits = _preloadUint(9, _offset + 2).toInt();
    final BigInt value = _preloadUint(bits, _offset + 11);

    _offset += 11 + bits;
    return ExternalAddress(value, bits);
  }
}
