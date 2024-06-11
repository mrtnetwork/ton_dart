import 'package:ton_dart/src/serialization/serialization.dart';
import 'blockchain_block.dart';

class BlockchainBlockShardsShardsItemResponse with JsonSerialization {
  final String lastKnownBlockId;
  final BlockchainBlockResponse lastKnownBlock;

  const BlockchainBlockShardsShardsItemResponse(
      {required this.lastKnownBlockId, required this.lastKnownBlock});

  factory BlockchainBlockShardsShardsItemResponse.fromJson(
      Map<String, dynamic> json) {
    return BlockchainBlockShardsShardsItemResponse(
      lastKnownBlockId: json['last_known_block_id'],
      lastKnownBlock:
          BlockchainBlockResponse.fromJson(json['last_known_block']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'last_known_block_id': lastKnownBlockId,
      'last_known_block': lastKnownBlock.toJson()
    };
  }
}
