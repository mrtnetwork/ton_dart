import 'package:ton_dart/src/contracts/exception/exception.dart';

class _HighloadQueryIdConst {
  static const int bitNumberSize = 10; // 10 bit
  static const int maxBitNumber = 1022;
  static const int maxShift = 8191; // 2^13 = 8192
}

class HighloadQueryId {
  BigInt _shift = BigInt.zero;
  BigInt _bitNumber = BigInt.zero;
  BigInt get shift => _shift;
  BigInt get bitNumber => _bitNumber;

  HighloadQueryId();

  HighloadQueryId._(this._shift, this._bitNumber);

  factory HighloadQueryId.fromShiftAndBitNumber(
      BigInt shift, BigInt bitNumber) {
    if (shift < BigInt.zero ||
        shift > BigInt.from(_HighloadQueryIdConst.maxShift)) {
      throw TonContractException("Invalid shift", details: {"shift": shift});
    }
    if (bitNumber < BigInt.zero ||
        bitNumber > BigInt.from(_HighloadQueryIdConst.maxBitNumber)) {
      throw TonContractException("Invalid bitNumber",
          details: {"bitNumber": bitNumber});
    }
    return HighloadQueryId._(shift, bitNumber);
  }

  factory HighloadQueryId.fromQueryId(BigInt queryId) {
    BigInt shift = queryId >> _HighloadQueryIdConst.bitNumberSize;
    BigInt bitNumber = queryId & BigInt.from(1023);
    return HighloadQueryId.fromShiftAndBitNumber(shift, bitNumber);
  }

  factory HighloadQueryId.fromSeqno(BigInt i) {
    BigInt shift = i ~/ BigInt.from(1023);
    BigInt bitNumber = i % BigInt.from(1023);
    return HighloadQueryId.fromShiftAndBitNumber(shift, bitNumber);
  }

  HighloadQueryId getNext() {
    BigInt newBitNumber = _bitNumber + BigInt.one;
    BigInt newShift = _shift;

    if (newShift == BigInt.from(_HighloadQueryIdConst.maxShift) &&
        newBitNumber > BigInt.from(_HighloadQueryIdConst.maxBitNumber - 1)) {
      throw const TonContractException("Overload");
    }

    if (newBitNumber > BigInt.from(_HighloadQueryIdConst.maxBitNumber)) {
      newBitNumber = BigInt.zero;
      newShift += BigInt.one;
      if (newShift > BigInt.from(_HighloadQueryIdConst.maxShift)) {
        throw const TonContractException("Overload");
      }
    }

    return HighloadQueryId.fromShiftAndBitNumber(newShift, newBitNumber);
  }

  bool hasNext() {
    bool isEnd =
        _bitNumber >= BigInt.from(_HighloadQueryIdConst.maxBitNumber - 1) &&
            _shift == BigInt.from(_HighloadQueryIdConst.maxShift);
    return !isEnd;
  }

  BigInt getShift() => _shift;

  BigInt getBitNumber() => _bitNumber;

  BigInt getQueryId() {
    return (_shift << _HighloadQueryIdConst.bitNumberSize) + _bitNumber;
  }

  BigInt toSeqno() {
    return _bitNumber + _shift * BigInt.from(1023);
  }
}
