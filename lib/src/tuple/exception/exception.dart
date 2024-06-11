import 'package:ton_dart/src/exception/exception.dart';

class TupleException extends TonDartPluginException {
  TupleException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
