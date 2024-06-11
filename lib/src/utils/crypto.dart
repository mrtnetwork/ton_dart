import 'dart:typed_data' show Endian;
import 'package:blockchain_utils/binary/binary_operation.dart';
import 'package:blockchain_utils/numbers/int_utils.dart';

class CryptoUtils {
  static const int _crc32cPoly = 0x82f63b78;
  static const int _crc16Poly = 0x1021;

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

  static List<int> crc16(List<int> data) {
    int reg = 0;
    List<int> message = List<int>.filled(data.length + 2, 0);
    message.setAll(0, data);

    for (int byte in message) {
      int mask = 0x80;
      while (mask > 0) {
        reg <<= 1;
        if (byte & mask != 0) {
          reg += 1;
        }
        mask >>= 1;
        if (reg > mask16) {
          reg &= mask16;
          reg ^= _crc16Poly;
        }
      }
    }

    return List<int>.from([reg >> 8, reg & mask8]);
  }
}
