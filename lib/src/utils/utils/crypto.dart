import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/utils/binary/binary_operation.dart';

class CryptoUtils {
  static const int _crc32cPoly = 0x82f63b78;

  static List<int> crc32c(List<int> source) {
    int crc = BinaryOps.mask32;
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
    crc ^= BinaryOps.mask32;

    return crc.toU32LeBytes();
  }
}
