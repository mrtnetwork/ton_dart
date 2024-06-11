import 'package:blockchain_utils/blockchain_utils.dart';

class Base64Utils {
  static String encodeBase64(List<int> bytes, {bool urlSafe = false}) {
    final encode = StringUtils.decode(bytes, StringEncoding.base64);
    if (urlSafe) {
      return encode.replaceAll('+', '-').replaceAll('/', '_');
    }
    return encode;
  }

  static List<int> decodeBase64(String base64) {
    try {
      String b64 = base64;
      final int reminder = b64.length % 4;
      if (reminder != 0 && !b64.endsWith("=")) {
        b64 += "=" * (4 - reminder);
      }
      return StringUtils.encode(b64, StringEncoding.base64);
    } catch (e) {
      throw MessageException("Invalid base64 string.",
          details: {"value": base64});
    }
  }
}
