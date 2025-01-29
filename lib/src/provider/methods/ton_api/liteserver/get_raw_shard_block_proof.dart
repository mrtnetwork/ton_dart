import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_shard_block_proof.dart';

/// GetRawShardBlockProof invokes getRawShardBlockProof operation.
///
/// Get raw shard block proof.
///
class TonApiGetRawShardBlockProof
    extends TonApiRequest<RawShardBlockProofResponse, Map<String, dynamic>> {
  /// block ID: (workchain,shard,seqno,root_hash,file_hash)
  final String blockId;
  TonApiGetRawShardBlockProof(this.blockId);
  @override
  String get method => TonApiMethods.getrawshardblockproof.url;

  @override
  List<String> get pathParameters => [blockId];

  @override
  RawShardBlockProofResponse onResonse(Map<String, dynamic> result) {
    return RawShardBlockProofResponse.fromJson(result);
  }
}
