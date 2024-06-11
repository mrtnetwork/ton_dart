import 'package:ton_dart/src/serialization/serialization.dart';

class BlockRawResponse with JsonSerialization {
  final int workchain;
  final String shard;
  final int seqno;
  final String rootHash;
  final String fileHash;

  const BlockRawResponse({
    required this.workchain,
    required this.shard,
    required this.seqno,
    required this.rootHash,
    required this.fileHash,
  });

  factory BlockRawResponse.fromJson(Map<String, dynamic> json) {
    return BlockRawResponse(
      workchain: json['workchain'],
      shard: json['shard'],
      seqno: json['seqno'],
      rootHash: json['root_hash'],
      fileHash: json['file_hash'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'workchain': workchain,
      'shard': shard,
      'seqno': seqno,
      'root_hash': rootHash,
      'file_hash': fileHash
    };
  }
}
