import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'account_address.dart';

class ElectionsRecoverStakeActionResponse with JsonSerialization {
  final BigInt amount;
  final AccountAddressResponse staker;

  const ElectionsRecoverStakeActionResponse(
      {required this.amount, required this.staker});

  factory ElectionsRecoverStakeActionResponse.fromJson(
      Map<String, dynamic> json) {
    return ElectionsRecoverStakeActionResponse(
      amount: BigintUtils.parse(json['amount']),
      staker: AccountAddressResponse.fromJson(json['staker']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'amount': amount.toString(),
      'staker': staker.toJson(),
    };
  }
}
