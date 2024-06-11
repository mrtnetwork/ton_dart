import 'package:ton_dart/src/serialization/serialization.dart';
import 'blockchain_block.dart';

class BlockchainBlocksResponse with JsonSerialization {
  final List<BlockchainBlockResponse> blocks;

  const BlockchainBlocksResponse({required this.blocks});

  factory BlockchainBlocksResponse.fromJson(Map<String, dynamic> json) {
    return BlockchainBlocksResponse(
      blocks: (json['blocks'] as List<dynamic>)
          .map((item) => BlockchainBlockResponse.fromJson(item))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'blocks': blocks.map((block) => block.toJson()).toList(),
    };
  }
}
