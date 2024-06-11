import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class ValidatorResponse with JsonSerialization {
  final String address;
  final String adnlAddress;
  final BigInt stake;
  final BigInt maxFactor;

  const ValidatorResponse(
      {required this.address,
      required this.adnlAddress,
      required this.stake,
      required this.maxFactor});

  factory ValidatorResponse.fromJson(Map<String, dynamic> json) {
    return ValidatorResponse(
        address: json['address'],
        adnlAddress: json['adnl_address'],
        stake: BigintUtils.parse(json['stake']),
        maxFactor: BigintUtils.parse(json['max_factor']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'adnl_address': adnlAddress,
      'stake': stake.toString(),
      'max_factor': maxFactor.toString()
    };
  }
}
