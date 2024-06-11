import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class ValidatorsSetListItemResponse with JsonSerialization {
  final String publicKey;
  final BigInt weight;
  final String? adnlAddr;

  const ValidatorsSetListItemResponse(
      {required this.publicKey, required this.weight, this.adnlAddr});

  factory ValidatorsSetListItemResponse.fromJson(Map<String, dynamic> json) {
    return ValidatorsSetListItemResponse(
        publicKey: json['public_key'],
        weight: BigintUtils.parse(json['weight']),
        adnlAddr: json['adnl_addr']);
  }
  @override
  Map<String, dynamic> toJson() => {
        'public_key': publicKey,
        'weight': weight.toString(),
        'adnl_addr': adnlAddr
      };
}
