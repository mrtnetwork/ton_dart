import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'jetton_holders_addresses_item.dart';

class JettonHoldersResponse with JsonSerialization {
  final List<JettonHoldersAddressesItemResponse> addresses;
  final BigInt total;

  const JettonHoldersResponse({
    required this.addresses,
    required this.total,
  });

  factory JettonHoldersResponse.fromJson(Map<String, dynamic> json) {
    return JettonHoldersResponse(
        addresses: List<JettonHoldersAddressesItemResponse>.from(
            (json['addresses'] as List)
                .map((x) => JettonHoldersAddressesItemResponse.fromJson(x))),
        total: BigintUtils.parse(json['total']));
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'addresses': addresses.map((x) => x.toJson()).toList(),
      'total': total.toString(),
    };
  }
}
