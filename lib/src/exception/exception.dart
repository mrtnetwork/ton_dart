import 'package:blockchain_utils/exception/exceptions.dart';

class TonDartPluginException extends BlockchainUtilsException {
  const TonDartPluginException(String message, {Map<String, dynamic>? details})
      : super(message, details: details);
}
