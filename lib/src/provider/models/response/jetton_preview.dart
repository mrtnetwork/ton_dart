import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'jetton_verification_type.dart';

class JettonPreviewResponse with JsonSerialization {
  final TonAddress address;
  final String name;
  final String symbol;
  final int decimals;
  final String image;
  final JettonVerificationTypeResponse verification;

  const JettonPreviewResponse({
    required this.address,
    required this.name,
    required this.symbol,
    required this.decimals,
    required this.image,
    required this.verification,
  });

  factory JettonPreviewResponse.fromJson(Map<String, dynamic> json) {
    return JettonPreviewResponse(
      address: TonAddress(json['address'], bounceable: true),
      name: json['name'],
      symbol: json['symbol'],
      decimals: json['decimals'],
      image: json['image'],
      verification:
          JettonVerificationTypeResponse.fromName(json['verification']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'name': name,
      'symbol': symbol,
      'decimals': decimals,
      'image': image,
      'verification': verification.value,
    };
  }
}
