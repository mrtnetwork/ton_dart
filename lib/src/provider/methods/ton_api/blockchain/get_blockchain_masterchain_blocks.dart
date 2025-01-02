import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/blockchain_blocks.dart';

/// GetBlockchainMasterchainBlocks invokes getBlockchainMasterchainBlocks operation.
///
/// Get all blocks in all shards and workchains between target and previous masterchain block
/// according to shards last blocks snapshot in masterchain.  We don't recommend to build your app
/// around this method because it has problem with scalability and will work very slow in the future.
///
class TonApiGetBlockchainMasterchainBlocks
    extends TonApiRequest<BlockchainBlocksResponse, Map<String, dynamic>> {
  final int masterchainSeqno;
  TonApiGetBlockchainMasterchainBlocks(this.masterchainSeqno);
  @override
  String get method => TonApiMethods.getblockchainmasterchainblocks.url;

  @override
  List<String> get pathParameters => [masterchainSeqno.toString()];

  @override
  BlockchainBlocksResponse onResonse(Map<String, dynamic> result) {
    return BlockchainBlocksResponse.fromJson(result);
  }
}
