import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'jetton_metadata.dart';
import 'jetton_verification_type.dart';

class JettonInfoResponse with JsonSerialization {
  final bool mintable;
  final String totalSupply;
  final AccountAddressResponse? admin;
  final JettonMetadataResponse metadata;
  final JettonVerificationTypeResponse verification;
  final int holdersCount;

  const JettonInfoResponse({
    required this.mintable,
    required this.totalSupply,
    this.admin,
    required this.metadata,
    required this.verification,
    required this.holdersCount,
  });

  factory JettonInfoResponse.fromJson(Map<String, dynamic> json) {
    return JettonInfoResponse(
        mintable: json['mintable'],
        totalSupply: json['total_supply'],
        admin: json['admin'] != null
            ? AccountAddressResponse.fromJson(json['admin'])
            : null,
        metadata: JettonMetadataResponse.fromJson(json['metadata']),
        verification:
            JettonVerificationTypeResponse.fromName(json['verification']),
        holdersCount: json['holders_count']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'mintable': mintable,
      'total_supply': totalSupply,
      'metadata': metadata.toJson(),
      'verification': verification.value,
      'holders_count': holdersCount,
      'admin': admin?.toJson()
    };
  }
}
