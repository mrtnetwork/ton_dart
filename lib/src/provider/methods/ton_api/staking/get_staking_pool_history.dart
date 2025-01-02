import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/apy_history.dart';

/// GetStakingPoolHistory invokes getStakingPoolHistory operation.
///
/// Pool history.
///
class TonApiGetStakingPoolHistory
    extends TonApiRequest<List<ApyHistoryResponse>, Map<String, dynamic>> {
  final String accountId;
  TonApiGetStakingPoolHistory(this.accountId);
  @override
  String get method => TonApiMethods.getstakingpoolhistory.url;

  @override
  List<String> get pathParameters => [accountId];
  @override
  List<ApyHistoryResponse> onResonse(Map<String, dynamic> result) {
    return (result['apy'] as List)
        .map((e) => ApyHistoryResponse.fromJson(e))
        .toList();
  }
}
