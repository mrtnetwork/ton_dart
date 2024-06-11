import 'package:ton_dart/src/serialization/serialization.dart';
import 'blockchain_shards_shards_item.dart';

class BlockchainBlockShardsResponse with JsonSerialization {
  final List<BlockchainBlockShardsShardsItemResponse> shards;

  const BlockchainBlockShardsResponse({required this.shards});

  factory BlockchainBlockShardsResponse.fromJson(Map<String, dynamic> json) {
    return BlockchainBlockShardsResponse(
      shards: (json['shards'] as List<dynamic>)
          .map((item) => BlockchainBlockShardsShardsItemResponse.fromJson(item))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'shards': shards.map((shard) => shard.toJson()).toList(),
    };
  }
}
