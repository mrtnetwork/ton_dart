import 'package:ton_dart/src/serialization/serialization.dart';

import 'block_raw.dart';

class RawAccountStateResponse with JsonSerialization {
  final BlockRawResponse id;
  final BlockRawResponse shardblk;
  final String shardProof;
  final String proof;
  final String state;
  const RawAccountStateResponse(
      {required this.id,
      required this.shardblk,
      required this.shardProof,
      required this.proof,
      required this.state});
  factory RawAccountStateResponse.fromJson(Map<String, dynamic> json) {
    return RawAccountStateResponse(
        id: BlockRawResponse.fromJson(json['id']),
        shardblk: BlockRawResponse.fromJson(json['shardblk']),
        shardProof: json['shard_proof'],
        proof: json['proof'],
        state: json['state']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'shardblk': shardblk.toJson(),
      'shard_proof': shardProof,
      'proof': proof,
      'state': state
    };
  }
}
