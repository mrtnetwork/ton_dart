import 'package:ton_dart/src/exception/exception.dart';

class TonAddressException extends TonDartPluginException {
  TonAddressException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
