import 'package:ton_dart/src/utils/math.dart';

class _LevelMaskUtils {
  static int countSetBits(int n) {
    n = n - ((n >> 1) & 0x55555555);
    n = (n & 0x33333333) + ((n >> 2) & 0x33333333);
    return ((n + (n >> 4) & 0xF0F0F0F) * 0x1010101) >> 24;
  }
}

class LevelMask {
  final int _mask;
  final int _hashIndex;
  final int _hashCount;
  LevelMask._(this._mask, this._hashIndex, this._hashCount);
  factory LevelMask({int mask = 0}) {
    final int hashIndex = _LevelMaskUtils.countSetBits(mask);
    final int hashCount = hashIndex + 1;
    return LevelMask._(mask, hashIndex, hashCount);
  }

  int get value => _mask;

  late final int level = 32 - MathUtils.clz32(_mask);

  int get hashIndex => _hashIndex;

  int get hashCount => _hashCount;

  LevelMask apply(int level) {
    return LevelMask(mask: _mask & ((1 << level) - 1));
  }

  bool isSignificant(int level) {
    return level == 0 || ((_mask >> (level - 1)) & 1) != 0;
  }
}
