import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'account_address.dart';
import 'image_preview.dart';
import 'nft_approved_by_item.dart';

class NftCollectionResponse with JsonSerialization {
  final String address;
  final BigInt nextItemIndex;
  final AccountAddressResponse? owner;
  final String rawCollectionContent;
  final Map<String, String>? metadata;
  final List<ImagePreviewResponse> previews;
  final List<NftApprovedByItemResponse> approvedBy;

  const NftCollectionResponse({
    required this.address,
    required this.nextItemIndex,
    required this.owner,
    required this.rawCollectionContent,
    required this.metadata,
    required this.previews,
    required this.approvedBy,
  });

  factory NftCollectionResponse.fromJson(Map<String, dynamic> json) {
    return NftCollectionResponse(
      address: json['address'],
      nextItemIndex: BigintUtils.parse(json['next_item_index']),
      owner: json['owner'] != null
          ? AccountAddressResponse.fromJson(json['owner'])
          : null,
      rawCollectionContent: json['raw_collection_content'],
      metadata:
          json['metadata'] != null ? (json['metadata'] as Map).cast() : null,
      previews: List<ImagePreviewResponse>.from((json['previews'] as List)
          .map((x) => ImagePreviewResponse.fromJson(x))),
      approvedBy: List<NftApprovedByItemResponse>.from(
          (json['approved_by'] as List).map((x) => x)),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'next_item_index': nextItemIndex,
      'owner': owner?.toJson(),
      'raw_collection_content': rawCollectionContent,
      'metadata': metadata,
      'previews': previews.map((x) => x.toJson()).toList(),
      'approved_by': approvedBy.map((x) => x).toList(),
    };
  }
}
