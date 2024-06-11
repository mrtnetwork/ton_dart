import 'package:ton_dart/src/serialization/serialization.dart';

class PriceResponse with JsonSerialization {
  final String value;
  final String tokenName;

  const PriceResponse({
    required this.value,
    required this.tokenName,
  });

  factory PriceResponse.fromJson(Map<String, dynamic> json) {
    return PriceResponse(
      value: json['value'],
      tokenName: json['token_name'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'value': value, 'token_name': tokenName};
  }
}
