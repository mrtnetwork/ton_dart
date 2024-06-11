import 'package:ton_dart/src/serialization/serialization.dart';

class OracleResponse with JsonSerialization {
  final String address;
  final String secpPubkey;

  OracleResponse({
    required this.address,
    required this.secpPubkey,
  });

  factory OracleResponse.fromJson(Map<String, dynamic> json) {
    return OracleResponse(
      address: json['address'],
      secpPubkey: json['secp_pubkey'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'secp_pubkey': secpPubkey,
    };
  }
}
