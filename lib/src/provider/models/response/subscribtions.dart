import 'package:ton_dart/src/serialization/serialization.dart';
import 'subscribtion.dart';

class SubscriptionsResponse with JsonSerialization {
  final List<SubscriptionResponse> subscriptions;

  const SubscriptionsResponse({required this.subscriptions});

  factory SubscriptionsResponse.fromJson(Map<String, dynamic> json) {
    return SubscriptionsResponse(
        subscriptions: (json['subscriptions'] as List)
            .map((subscriptionJson) =>
                SubscriptionResponse.fromJson(subscriptionJson))
            .toList());
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'subscriptions':
          subscriptions.map((subscription) => subscription.toJson()).toList()
    };
  }
}
