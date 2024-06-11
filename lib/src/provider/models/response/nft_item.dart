import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'account_address.dart';
import 'image_preview.dart';
import 'nft_approved_by_item.dart';
import 'nft_item_collection.dart';
import 'sale.dart';
import 'trust_type.dart';

class NftItemResponse with JsonSerialization {
  final String address;
  final BigInt index;
  final AccountAddressResponse? owner;
  final NftItemCollectionResponse? collection;
  final bool verified;
  final Map<String, String> metadata;
  final SaleResponse? sale;
  final List<ImagePreviewResponse> previews;
  final String? dns;
  final List<NftApprovedByItemResponse> approvedBy;
  final bool? includeCnft;
  final TrustTypeResponse trust;

  NftItemResponse({
    required this.address,
    required this.index,
    this.owner,
    this.collection,
    required this.verified,
    required this.metadata,
    this.sale,
    required this.previews,
    this.dns,
    required this.approvedBy,
    this.includeCnft,
    required this.trust,
  });

  factory NftItemResponse.fromJson(Map<String, dynamic> json) {
    return NftItemResponse(
      address: json['address'],
      index: BigintUtils.parse(json['index']),
      owner: json['owner'] != null
          ? AccountAddressResponse.fromJson(json['owner'])
          : null,
      collection: json['collection'] != null
          ? NftItemCollectionResponse.fromJson(json['collection'])
          : null,
      verified: json['verified'],
      metadata: (json['metadata'] as Map).cast(),
      sale: json['sale'] != null ? SaleResponse.fromJson(json['sale']) : null,
      previews: (json['previews'] as List)
          .map((preview) => ImagePreviewResponse.fromJson(preview))
          .toList(),
      dns: json['dns'],
      approvedBy: (json['approved_by'] as List)
          .map((item) => NftApprovedByItemResponse.fromName(item))
          .toList(),
      includeCnft: json['include_cnft'],
      trust: TrustTypeResponse.values.firstWhere(
          (e) => e.toString() == 'TrustTypeResponse.${json['trust']}'),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'index': index.toString(),
      'verified': verified,
      'metadata': metadata,
      'previews': previews.map((preview) => preview.toJson()).toList(),
      'approved_by': approvedBy.map((item) => item.value).toList(),
      'trust': trust.value,
      'owner': owner?.toJson(),
      'collection': collection?.toJson(),
      'sale': sale?.toJson(),
      'dns': dns,
      'include_cnft': includeCnft
    };
  }
}
