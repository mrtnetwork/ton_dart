import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/blockchain_config.dart';

/// GetBlockchainConfig invokes getBlockchainConfig operation.
///
/// Get blockchain config.
///
class TonApiGetBlockchainConfig
    extends TonApiRequest<BlockchainConfigResponse, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.getblockchainconfig.url;

  @override
  BlockchainConfigResponse onResonse(Map<String, dynamic> result) {
    return BlockchainConfigResponse.fromJson(result);
  }
}
