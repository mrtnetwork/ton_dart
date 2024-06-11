import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/validators.dart';

/// GetBlockchainValidators invokes getBlockchainValidators operation.
///
/// Get blockchain validators.
///
class TonApiGetBlockchainValidators
    extends TonApiRequestParam<ValidatorsResponse, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.getblockchainvalidators.url;

  @override
  ValidatorsResponse onResonse(Map<String, dynamic> json) {
    return ValidatorsResponse.fromJson(json);
  }
}
