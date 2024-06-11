import 'package:ton_dart/src/serialization/serialization.dart';
import 'nft_item.dart';

class NftItemsResponse with JsonSerialization {
  final List<NftItemResponse> nftItems;

  const NftItemsResponse({required this.nftItems});

  factory NftItemsResponse.fromJson(Map<String, dynamic> json) {
    return NftItemsResponse(
      nftItems: (json['nft_items'] as List)
          .map((item) => NftItemResponse.fromJson(item))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'nft_items': nftItems.map((item) => item.toJson()).toList(),
    };
  }
}
