import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/subscribtions.dart';

/// GetAccountSubscriptions invokes getAccountSubscriptions operation.
///
/// Get all subscriptions by wallet address.
///
class TonApiGetAccountSubscriptions
    extends TonApiRequestParam<SubscriptionsResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiGetAccountSubscriptions(this.accountId);
  @override
  String get method => TonApiMethods.getaccountsubscriptions.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  SubscriptionsResponse onResonse(Map<String, dynamic> json) {
    return SubscriptionsResponse.fromJson(json);
  }
}
