import 'dart:typed_data' show Endian;

import 'package:blockchain_utils/utils/utils.dart';

class CryptoUtils {
  static const int _crc32cPoly = 0x82f63b78;

  static List<int> crc32c(List<int> source) {
    int crc = mask32;
    for (int n = 0; n < source.length; n++) {
      crc ^= source[n];
      for (var i = 0; i < 8; i++) {
        if ((crc & 1) == 1) {
          crc = (crc >> 1) ^ _crc32cPoly;
        } else {
          crc >>= 1;
        }
      }
    }
    crc ^= mask32;

    return IntUtils.toBytes(crc, length: 4, byteOrder: Endian.little);
  }
}
