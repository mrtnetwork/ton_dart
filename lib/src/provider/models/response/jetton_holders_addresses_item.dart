import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';

class JettonHoldersAddressesItemResponse with JsonSerialization {
  final String address;
  final AccountAddressResponse owner;
  final String balance;

  const JettonHoldersAddressesItemResponse({
    required this.address,
    required this.owner,
    required this.balance,
  });

  factory JettonHoldersAddressesItemResponse.fromJson(
      Map<String, dynamic> json) {
    return JettonHoldersAddressesItemResponse(
      address: json['address'],
      owner: AccountAddressResponse.fromJson(json['owner']),
      balance: json['balance'],
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'address': address, 'owner': owner.toJson(), 'balance': balance};
}
