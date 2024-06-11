import 'package:ton_dart/src/serialization/serialization.dart';

class AccountAddressResponse with JsonSerialization {
  final String address;
  final String? name;
  final bool isScam;
  final String? icon;
  final bool isWallet;

  const AccountAddressResponse({
    required this.address,
    this.name,
    required this.isScam,
    this.icon,
    required this.isWallet,
  });

  factory AccountAddressResponse.fromJson(Map<String, dynamic> json) {
    return AccountAddressResponse(
      address: json['address'],
      name: json['name'],
      isScam: json['is_scam'],
      icon: json['icon'],
      isWallet: json['is_wallet'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'name': name,
      'is_scam': isScam,
      'icon': icon,
      'is_wallet': isWallet,
    };
  }
}
