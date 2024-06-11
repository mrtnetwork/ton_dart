import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class SubscriptionResponse with JsonSerialization {
  final String address;
  final String walletAddress;
  final String beneficiaryAddress;
  final BigInt amount;
  final BigInt period;
  final BigInt startTime;
  final BigInt timeout;
  final BigInt lastPaymentTime;
  final BigInt lastRequestTime;
  final BigInt subscriptionID;
  final int failedAttempts;

  const SubscriptionResponse({
    required this.address,
    required this.walletAddress,
    required this.beneficiaryAddress,
    required this.amount,
    required this.period,
    required this.startTime,
    required this.timeout,
    required this.lastPaymentTime,
    required this.lastRequestTime,
    required this.subscriptionID,
    required this.failedAttempts,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionResponse(
      address: json['address'],
      walletAddress: json['wallet_address'],
      beneficiaryAddress: json['beneficiary_address'],
      amount: BigintUtils.parse(json['amount']),
      period: BigintUtils.parse(json['period']),
      startTime: BigintUtils.parse(json['start_time']),
      timeout: BigintUtils.parse(json['timeout']),
      lastPaymentTime: BigintUtils.parse(json['last_payment_time']),
      lastRequestTime: BigintUtils.parse(json['last_request_time']),
      subscriptionID: BigintUtils.parse(json['subscription_id']),
      failedAttempts: json['failed_attempts'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'wallet_address': walletAddress,
      'beneficiary_address': beneficiaryAddress,
      'amount': amount.toString(),
      'period': period.toString(),
      'start_time': startTime.toString(),
      'timeout': timeout.toString(),
      'last_payment_time': lastPaymentTime.toString(),
      'last_request_time': lastRequestTime.toString(),
      'subscription_id': subscriptionID.toString(),
      'failed_attempts': failedAttempts,
    };
  }
}
