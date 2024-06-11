import 'package:ton_dart/src/exception/exception.dart';

class KeyException extends TonDartPluginException {
  KeyException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
