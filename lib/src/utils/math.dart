import 'dart:math' as math;

class MathUtils {
  static int log2(int n) {
    return (math.log(n) / math.log(2)).ceil();
  }

  static int min(int a, int b) => math.min(a, b);
  static int max(int a, int b) => math.max(a, b);
  static int clz32(int x) {
    if (x == 0) return 32;
    int n = 1;
    if ((x >> 16) == 0) {
      n += 16;
      x <<= 16;
    }
    if ((x >> 24) == 0) {
      n += 8;
      x <<= 8;
    }
    if ((x >> 28) == 0) {
      n += 4;
      x <<= 4;
    }
    if ((x >> 30) == 0) {
      n += 2;
      x <<= 2;
    }
    n -= x >> 31;
    return n;
  }
}
