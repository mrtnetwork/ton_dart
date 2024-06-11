import 'package:ton_dart/src/serialization/serialization.dart';
import 'dns_expiring_items_item.dart';

class DnsExpiringResponse with JsonSerialization {
  final List<DnsExpiringItemsItemResponse> items;

  const DnsExpiringResponse({required this.items});

  factory DnsExpiringResponse.fromJson(Map<String, dynamic> json) {
    return DnsExpiringResponse(
      items: List<DnsExpiringItemsItemResponse>.from(
          json['items'].map((x) => DnsExpiringItemsItemResponse.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'items': items.map((x) => x.toJson()).toList()};
  }
}
