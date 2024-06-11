import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class AccountStakingInfoResponse with JsonSerialization {
  final String pool;
  final BigInt amount;
  final BigInt pendingDeposit;
  final BigInt pendingWithdraw;
  final BigInt readyWithdraw;

  const AccountStakingInfoResponse({
    required this.pool,
    required this.amount,
    required this.pendingDeposit,
    required this.pendingWithdraw,
    required this.readyWithdraw,
  });

  factory AccountStakingInfoResponse.fromJson(Map<String, dynamic> json) {
    return AccountStakingInfoResponse(
      pool: json['pool'],
      amount: BigintUtils.parse(json['amount']),
      pendingDeposit: BigintUtils.parse(json['pending_deposit']),
      pendingWithdraw: BigintUtils.parse(json['pending_withdraw']),
      readyWithdraw: BigintUtils.parse(json['ready_withdraw']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'pool': pool,
      'amount': amount.toString(),
      'pending_deposit': pendingDeposit.toString(),
      'pending_withdraw': pendingWithdraw.toString(),
      'ready_withdraw': readyWithdraw.toString(),
    };
  }
}
