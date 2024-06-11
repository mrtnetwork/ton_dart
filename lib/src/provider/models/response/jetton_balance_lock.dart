import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class JettonBalanceLockResponse with JsonSerialization {
  final String amount;
  final BigInt till;

  const JettonBalanceLockResponse({required this.amount, required this.till});

  factory JettonBalanceLockResponse.fromJson(Map<String, dynamic> json) {
    return JettonBalanceLockResponse(
        amount: json['amount'], till: BigintUtils.parse(json['till']));
  }

  @override
  Map<String, dynamic> toJson() => {'amount': amount, 'till': till.toString()};
}
