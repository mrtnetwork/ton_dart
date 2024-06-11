import 'package:ton_dart/src/exception/exception.dart';

class BocException extends TonDartPluginException {
  BocException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
