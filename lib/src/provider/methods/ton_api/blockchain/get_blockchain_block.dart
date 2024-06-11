import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/blockchain_block.dart';

/// GetBlockchainBlock invokes getBlockchainBlock operation.
///
/// Get blockchain block data.
///
class TonApiGetBlockchainBlock
    extends TonApiRequestParam<BlockchainBlockResponse, Map<String, dynamic>> {
  final String blockId;
  TonApiGetBlockchainBlock(this.blockId);
  @override
  String get method => TonApiMethods.getblockchainblock.url;

  @override
  List<String> get pathParameters => [blockId];

  @override
  BlockchainBlockResponse onResonse(Map<String, dynamic> json) {
    return BlockchainBlockResponse.fromJson(json);
  }
}
