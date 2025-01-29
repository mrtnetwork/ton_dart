import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/blockchain_block_shards.dart';

/// GetBlockchainMasterchainShards invokes getBlockchainMasterchainShards operation.
///
/// Get blockchain block shards.
///
class TonApiGetBlockchainMasterchainShards
    extends TonApiRequest<BlockchainBlockShardsResponse, Map<String, dynamic>> {
  final int masterchainSeqno;
  TonApiGetBlockchainMasterchainShards(this.masterchainSeqno);
  @override
  String get method => TonApiMethods.getblockchainmasterchainshards.url;

  @override
  List<String> get pathParameters => [masterchainSeqno.toString()];

  @override
  BlockchainBlockShardsResponse onResonse(Map<String, dynamic> result) {
    return BlockchainBlockShardsResponse.fromJson(result);
  }
}
