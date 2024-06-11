import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get merkle proof of shardchain block.
/// https://toncenter.com/api/v2/#/blocks/get_shard_block_proof_getShardBlockProof_get
class TonCenterGetShardBlockProof extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  /// Block workchain id
  final int workchain;

  /// Block shard id
  final int shard;

  /// Block seqno
  final int seqno;

  /// Seqno of masterchain block starting from which proof is required. If not specified latest masterchain block is used.
  final int? fromSeqno;

  TonCenterGetShardBlockProof(
      {required this.workchain,
      required this.shard,
      required this.seqno,
      this.fromSeqno});

  @override
  String get method => TonCenterMethods.getShardBlockProof.name;

  @override
  Map<String, dynamic> params() {
    return {
      "workchain": workchain,
      "shard": shard,
      "seqno": seqno,
      "from_seqno": fromSeqno,
    };
  }
}
