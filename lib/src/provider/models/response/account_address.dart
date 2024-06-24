import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/ton_dart.dart';

class AccountAddressResponse with JsonSerialization {
  final TonAddress address;
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
        address: TonAddress(json['address'], bounceable: true),
        name: json['name'],
        isScam: json['is_scam'],
        icon: json['icon'],
        isWallet: json['is_wallet']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address.toFriendlyAddress(),
      'name': name,
      'is_scam': isScam,
      'icon': icon,
      'is_wallet': isWallet,
    };
  }
}
