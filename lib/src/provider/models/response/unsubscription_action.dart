import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';

class UnSubscriptionActionResponse with JsonSerialization {
  final AccountAddressResponse subscriber;
  final String subscription;
  final AccountAddressResponse beneficiary;

  const UnSubscriptionActionResponse(
      {required this.subscriber,
      required this.subscription,
      required this.beneficiary});

  factory UnSubscriptionActionResponse.fromJson(Map<String, dynamic> json) {
    return UnSubscriptionActionResponse(
        subscriber: AccountAddressResponse.fromJson(json['subscriber']),
        subscription: json['subscription'],
        beneficiary: AccountAddressResponse.fromJson(json['beneficiary']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'subscriber': subscriber.toJson(),
      'subscription': subscription,
      'beneficiary': beneficiary.toJson()
    };
  }
}
