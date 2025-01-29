import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_raw.dart';

class RawShardInfoResponse with JsonSerialization {
  final BlockRawResponse id;
  final BlockRawResponse shardblk;
  final String shardProof;
  final String shardDescr;
  const RawShardInfoResponse({
    required this.id,
    required this.shardblk,
    required this.shardProof,
    required this.shardDescr,
  });
  factory RawShardInfoResponse.fromJson(Map<String, dynamic> json) {
    return RawShardInfoResponse(
      id: BlockRawResponse.fromJson(json['id']),
      shardblk: BlockRawResponse.fromJson(json['shardblk']),
      shardProof: json['shard_proof'],
      shardDescr: json['shard_descr'],
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'shardblk': shardblk.toJson(),
      'shard_proof': shardProof,
      'shard_descr': shardDescr
    };
  }
}
