import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'nft_item.dart';

class DomainInfoResponse with JsonSerialization {
  final String name;
  final BigInt? expiringAt;
  final NftItemResponse? item;

  const DomainInfoResponse({
    required this.name,
    required this.expiringAt,
    required this.item,
  });

  factory DomainInfoResponse.fromJson(Map<String, dynamic> json) {
    return DomainInfoResponse(
        name: json['name'],
        expiringAt: BigintUtils.tryParse(json['expiring_at']),
        item: json['item'] != null
            ? NftItemResponse.fromJson(json['item'])
            : null);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'expiring_at': expiringAt?.toString(),
      'item': item?.toJson()
    };
  }
}
