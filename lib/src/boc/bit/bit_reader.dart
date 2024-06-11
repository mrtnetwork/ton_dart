import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'bit_string.dart';

class BitReader {
  final List<int> _checkpoints = [];
  final BitString _bits;
  int _offset;
  int get offset => _offset;
  int get remaining => _bits.length - _offset;

  BitReader(this._bits, {int offset = 0}) : _offset = offset;

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

  void reset() {
    if (_checkpoints.isNotEmpty) {
      _offset = _checkpoints.removeLast();
    } else {
      _offset = 0;
    }
  }

  void save() {
    _checkpoints.add(_offset);
  }

  bool loadBit() {
    bool r = _bits.at(_offset);
    _offset++;
    return r;
  }

  bool preloadBit() {
    return _bits.at(_offset);
  }

  BitString loadBits(int bits) {
    BitString r = _bits.substring(_offset, bits);
    _offset += bits;
    return r;
  }

  BitString preloadBits(int bits) {
    return _bits.substring(_offset, bits);
  }

  List<int> loadBuffer(int bytes) {
    List<int> buf = _preloadBuffer(bytes, _offset);
    _offset += bytes * 8;
    return buf;
  }

  List<int> preloadBuffer(int bytes) {
    return _preloadBuffer(bytes, _offset);
  }

  int loadUint(int bits) {
    return loadUintBig(bits).toInt();
  }

  BigInt loadUintBig(int bits) {
    BigInt loaded = _preloadUint(bits, _offset);
    _offset += bits;
    return loaded;
  }

  int preloadUint(int bits) {
    return _preloadUint(bits, _offset).toInt();
  }

  BigInt preloadUintBig(int bits) {
    return _preloadUint(bits, _offset);
  }

  int loadInt(int bits) {
    return loadIntBig(bits).toInt();
  }

  BigInt loadIntBig(int bits) {
    BigInt res = _preloadInt(bits, _offset);
    _offset += bits;
    return res;
  }

  int preloadInt(int bits) {
    return _preloadInt(bits, _offset).toInt();
  }

  BigInt preloadIntBig(int bits) {
    return _preloadInt(bits, _offset);
  }

  int loadVarUint(int bits) {
    int size = loadUint(bits);
    return loadUintBig(size * 8).toInt();
  }

  BigInt loadVarUintBig(int bits) {
    int size = loadUint(bits);
    return loadUintBig(size * 8);
  }

  int preloadVarUint(int bits) {
    return preloadVarUintBig(bits).toInt();
  }

  BigInt preloadVarUintBig(int bits) {
    int size = _preloadUint(bits, offset).toInt();
    return _preloadUint(size * 8, offset + bits);
  }

  int loadVarInt(int bits) {
    return loadVarIntBig(bits).toInt();
  }

  BigInt loadVarIntBig(int bits) {
    int size = loadUint(bits);
    return loadIntBig(size * 8);
  }

  int preloadVarInt(int bits) {
    return preloadVarIntBig(bits).toInt();
  }

  BigInt preloadVarIntBig(int bits) {
    int size = _preloadInt(bits, offset).toInt();
    return _preloadInt(size * 8, offset + bits);
  }

  BigInt loadCoins() {
    return loadVarUintBig(4);
  }

  BigInt preloadCoins() {
    return preloadVarUintBig(4);
  }

  TonAddress loadAddress() {
    return _loadInternalAddress();
  }

  TonAddress? loadMaybeAddress() {
    int type = preloadUint(2);
    if (type == 0) {
      _offset += 2;
      return null;
    }
    return _loadInternalAddress();
  }

  ExternalAddress loadExternalAddress() {
    return _loadExternalAddress();
  }

  ExternalAddress? loadMaybeExternalAddress() {
    int type = preloadUint(2);
    if (type == 0) {
      _offset += 2;
      return null;
    }
    return _loadExternalAddress();
  }

  TonBaseAddress? loadAddressAny() {
    int type = preloadUint(2);
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

    BitString r = _bits.substring(_offset, length);
    _offset += bits;
    return r;
  }

  BitReader clone() {
    return BitReader(_bits.clone(), offset: _offset);
  }

  BigInt _preloadInt(int bits, int offset) {
    if (bits == 0) {
      return BigInt.zero;
    }
    bool sign = _bits.at(offset);
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
    List<int>? fastBuffer = _bits.subbuffer(offset, bytes * 8);
    if (fastBuffer != null) {
      return fastBuffer;
    }

    List<int> buf = List<int>.filled(bytes, 0);
    for (int i = 0; i < bytes; i++) {
      buf[i] = _preloadUint(8, offset + i * 8).toInt();
    }
    return buf;
  }

  TonAddress _loadInternalAddress() {
    int type = preloadUint(2);
    if (type != 2) {
      throw BocException("Invalid address.");
    }

    if (_preloadUint(1, _offset + 2) != BigInt.zero) {
      throw BocException("Invalid address.");
    }

    int wc = _preloadInt(8, _offset + 3).toInt();
    List<int> hash = _preloadBuffer(32, _offset + 11);

    _offset += 267;

    return TonAddress.fromBytes(wc, hash);
  }

  ExternalAddress _loadExternalAddress() {
    int type = preloadUint(2);
    if (type != 1) {
      throw BocException('Invalid extenal address.');
    }

    int bits = _preloadUint(9, _offset + 2).toInt();
    BigInt value = _preloadUint(bits, _offset + 11);

    _offset += 11 + bits;
    return ExternalAddress(value, bits);
  }
}
