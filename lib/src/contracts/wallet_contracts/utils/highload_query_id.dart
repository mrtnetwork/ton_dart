import 'package:blockchain_utils/blockchain_utils.dart';

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
    BigInt shift,
    BigInt bitNumber,
  ) {
    if (shift < BigInt.zero ||
        shift > BigInt.from(_HighloadQueryIdConst.maxShift)) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid shift',
        details: {'shift': shift.toString()},
      );
    }
    if (bitNumber < BigInt.zero ||
        bitNumber > BigInt.from(_HighloadQueryIdConst.maxBitNumber)) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid bitNumber',
        details: {'bitNumber': bitNumber.toString()},
      );
    }
    return HighloadQueryId._(shift, bitNumber);
  }

  factory HighloadQueryId.fromQueryId(BigInt queryId) {
    final BigInt shift = queryId >> _HighloadQueryIdConst.bitNumberSize;
    final BigInt bitNumber = queryId & BigInt.from(1023);
    return HighloadQueryId.fromShiftAndBitNumber(shift, bitNumber);
  }

  factory HighloadQueryId.fromSeqno(BigInt i) {
    final BigInt shift = i ~/ BigInt.from(1023);
    final BigInt bitNumber = i % BigInt.from(1023);
    return HighloadQueryId.fromShiftAndBitNumber(shift, bitNumber);
  }

  HighloadQueryId getNext() {
    BigInt newBitNumber = _bitNumber + BigInt.one;
    BigInt newShift = _shift;

    if (newShift == BigInt.from(_HighloadQueryIdConst.maxShift) &&
        newBitNumber > BigInt.from(_HighloadQueryIdConst.maxBitNumber - 1)) {
      throw BuError(
        DefaultErrorType.invalidState,
        'HighloadQueryId overflow: no next id.',
        details: {
          'shift': '$newShift',
          'bitNumber': '$newBitNumber',
          'maxShift': '${_HighloadQueryIdConst.maxShift}',
          'maxBitNumber': '${_HighloadQueryIdConst.maxBitNumber}',
        },
      );
    }

    if (newBitNumber > BigInt.from(_HighloadQueryIdConst.maxBitNumber)) {
      newBitNumber = BigInt.zero;
      newShift += BigInt.one;
      if (newShift > BigInt.from(_HighloadQueryIdConst.maxShift)) {
        throw BuError(
          DefaultErrorType.invalidState,
          'HighloadQueryId overflow: no next id.',
          details: {
            'shift': '$newShift',
            'maxShift': '${_HighloadQueryIdConst.maxShift}',
          },
        );
      }
    }

    return HighloadQueryId.fromShiftAndBitNumber(newShift, newBitNumber);
  }

  bool hasNext() {
    final bool isEnd =
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
