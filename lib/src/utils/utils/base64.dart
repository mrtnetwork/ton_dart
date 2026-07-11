import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/exception/exception.dart';

class Base64Utils {
  static String encodeBase64(List<int> bytes, {bool urlSafe = false}) {
    return StringUtils.decode(
      bytes,
      encoding: switch (urlSafe) {
        true => StringEncoding.base64UrlSafe,
        false => StringEncoding.base64,
      },
    );
  }

  static List<int> decodeBase64(String base64) {
    try {
      return StringUtils.encode(
        base64,
        encoding: StringEncoding.base64,
        allowUrlSafe: true,
        validateB64Padding: false,
      );
    } catch (e) {
      throw TonDartPluginException(
        'Invalid base64 string.',
        details: {'value': base64},
      );
    }
  }
}
