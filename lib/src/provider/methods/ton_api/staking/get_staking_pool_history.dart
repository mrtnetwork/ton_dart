import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/apy_history.dart';

/// GetStakingPoolHistory invokes getStakingPoolHistory operation.
///
/// Pool history.
///
class TonApiGetStakingPoolHistory
    extends TonApiRequestParam<List<ApyHistoryResponse>, Map<String, dynamic>> {
  final String accountId;
  TonApiGetStakingPoolHistory(this.accountId);
  @override
  String get method => TonApiMethods.getstakingpoolhistory.url;

  @override
  List<String> get pathParameters => [accountId];
  @override
  List<ApyHistoryResponse> onResonse(Map<String, dynamic> json) {
    return (json["apy"] as List)
        .map((e) => ApyHistoryResponse.fromJson(e))
        .toList();
  }
}
