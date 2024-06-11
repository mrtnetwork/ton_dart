import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'nft_item.dart';

class DnsExpiringItemsItemResponse with JsonSerialization {
  final BigInt expiringAt;
  final String name;
  final NftItemResponse? dnsItem;

  const DnsExpiringItemsItemResponse({
    required this.expiringAt,
    required this.name,
    this.dnsItem,
  });

  factory DnsExpiringItemsItemResponse.fromJson(Map<String, dynamic> json) {
    return DnsExpiringItemsItemResponse(
        expiringAt: BigintUtils.parse(json['expiring_at']),
        name: json['name'],
        dnsItem: json['dns_item'] != null
            ? NftItemResponse.fromJson(json['dns_item'])
            : null);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'expiring_at': expiringAt.toString(),
      'name': name,
      'dns_item': dnsItem?.toJson()
    };
  }
}
