import 'package:ton_dart/src/exception/exception.dart';

class TokenMetadataException extends TonDartPluginException {
  const TokenMetadataException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
