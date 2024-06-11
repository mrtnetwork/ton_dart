import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class CreditPhaseResponse with JsonSerialization {
  final BigInt feesCollected;
  final BigInt credit;

  const CreditPhaseResponse(
      {required this.feesCollected, required this.credit});

  factory CreditPhaseResponse.fromJson(Map<String, dynamic> json) {
    return CreditPhaseResponse(
      feesCollected: BigintUtils.parse(json['fees_collected']),
      credit: BigintUtils.parse(json['credit']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'fees_collected': feesCollected.toString(),
      'credit': credit.toString()
    };
  }
}
