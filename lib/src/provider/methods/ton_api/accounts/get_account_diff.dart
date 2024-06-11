import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// GetAccountDiff invokes getAccountDiff operation.
///
/// Get account's balance change.
///
class TonApiGetAccountDiff
    extends TonApiRequestParam<BigInt, Map<String, dynamic>> {
  final String accountId;
  final BigInt startDate;
  final BigInt endDate;

  TonApiGetAccountDiff(
      {required this.accountId,
      required this.startDate,
      required this.endDate});
  @override
  String get method => TonApiMethods.getaccountdiff.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"start_date": startDate.toString(), "end_date": endDate.toString()};
  @override
  BigInt onResonse(Map<String, dynamic> json) {
    return BigintUtils.parse(json["balance_change"]);
  }
}
