import 'package:ton_dart/src/serialization/serialization.dart';

class AccountInfoByStateInitResponse with JsonSerialization {
  final String publicKey;
  final String address;

  AccountInfoByStateInitResponse({
    required this.publicKey,
    required this.address,
  });

  factory AccountInfoByStateInitResponse.fromJson(Map<String, dynamic> json) {
    return AccountInfoByStateInitResponse(
      publicKey: json['public_key'],
      address: json['address'],
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {'public_key': publicKey, 'address': address};
  }
}
