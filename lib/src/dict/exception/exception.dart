import 'package:ton_dart/src/exception/exception.dart';

class DictException extends TonDartPluginException {
  DictException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
