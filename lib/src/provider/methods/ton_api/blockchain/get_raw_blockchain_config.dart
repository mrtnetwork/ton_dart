import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_blockchain_config.dart';

/// GetRawBlockchainConfig invokes getRawBlockchainConfig operation.
///
/// Get raw blockchain config.
///
class TonApiGetRawBlockchainConfig
    extends TonApiRequest<RawBlockchainConfigResponse, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.getrawblockchainconfig.url;

  @override
  RawBlockchainConfigResponse onResonse(Map<String, dynamic> result) {
    return RawBlockchainConfigResponse.fromJson(result);
  }
}
