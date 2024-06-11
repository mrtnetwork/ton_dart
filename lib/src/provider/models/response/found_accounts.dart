import 'package:ton_dart/src/serialization/serialization.dart';
import 'found_accounts_addresses_item.dart';

class FoundAccountsResponse with JsonSerialization {
  final List<FoundAccountsAddressesItemResponse> addresses;

  const FoundAccountsResponse({required this.addresses});

  factory FoundAccountsResponse.fromJson(Map<String, dynamic> json) {
    return FoundAccountsResponse(
        addresses: List<FoundAccountsAddressesItemResponse>.from(
            (json['addresses'] as List)
                .map((x) => FoundAccountsAddressesItemResponse.fromJson(x))));
  }

  @override
  Map<String, dynamic> toJson() {
    return {'addresses': addresses.map((x) => x.toJson()).toList()};
  }
}
