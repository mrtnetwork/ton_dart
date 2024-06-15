import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'account_address.dart';

class SubscriptionActionResponse with JsonSerialization {
  final AccountAddressResponse subscriber;
  final String subscription;
  final AccountAddressResponse beneficiary;
  final BigInt amount;
  final bool initial;

  const SubscriptionActionResponse({
    required this.subscriber,
    required this.subscription,
    required this.beneficiary,
    required this.amount,
    required this.initial,
  });

  factory SubscriptionActionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionActionResponse(
      subscriber: AccountAddressResponse.fromJson(json['subscriber']),
      subscription: json['subscription'],
      beneficiary: AccountAddressResponse.fromJson(json['beneficiary']),
      amount: BigintUtils.parse(json['amount']),
      initial: json['initial'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'subscriber': subscriber.toJson(),
      'subscription': subscription,
      'beneficiary': beneficiary.toJson(),
      'amount': amount.toString(),
      'initial': initial,
    };
  }
}
