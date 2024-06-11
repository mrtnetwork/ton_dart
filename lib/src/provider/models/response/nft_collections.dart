import 'package:ton_dart/src/serialization/serialization.dart';
import 'nft_collection.dart';

class NftCollectionsResponse with JsonSerialization {
  final List<NftCollectionResponse> nftCollections;

  const NftCollectionsResponse({required this.nftCollections});

  factory NftCollectionsResponse.fromJson(Map<String, dynamic> json) {
    return NftCollectionsResponse(
      nftCollections: List<NftCollectionResponse>.from(json['nft_collections']
          .map((x) => NftCollectionResponse.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'nft_collections': nftCollections.map((x) => x.toJson()).toList()};
  }
}
