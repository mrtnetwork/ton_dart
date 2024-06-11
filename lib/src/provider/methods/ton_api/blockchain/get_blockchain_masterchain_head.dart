import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/blockchain_block.dart';

/// GetBlockchainMasterchainHead invokes getBlockchainMasterchainHead operation.
///
/// Get last known masterchain block.
///
class TonApiGetBlockchainMasterchainHead
    extends TonApiRequestParam<BlockchainBlockResponse, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.getblockchainmasterchainhead.url;

  @override
  List<String> get pathParameters => [];

  @override
  BlockchainBlockResponse onResonse(Map<String, dynamic> json) {
    return BlockchainBlockResponse.fromJson(json);
  }
}
