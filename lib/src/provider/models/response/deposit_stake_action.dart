import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'account_address.dart';
import 'pool_implementation_type.dart';

class DepositStakeActionResponse with JsonSerialization {
  final BigInt amount;
  final AccountAddressResponse staker;
  final AccountAddressResponse pool;
  final PoolImplementationTypeResponse implementation;

  const DepositStakeActionResponse({
    required this.amount,
    required this.staker,
    required this.pool,
    required this.implementation,
  });

  factory DepositStakeActionResponse.fromJson(Map<String, dynamic> json) {
    return DepositStakeActionResponse(
      amount: BigintUtils.parse(json['amount']),
      staker: AccountAddressResponse.fromJson(json['staker']),
      pool: AccountAddressResponse.fromJson(json['pool']),
      implementation:
          PoolImplementationTypeResponse.fromName(json['implementation']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'amount': amount.toString(),
      'staker': staker.toJson(),
      'pool': pool.toJson(),
      'implementation': implementation.value
    };
  }
}
