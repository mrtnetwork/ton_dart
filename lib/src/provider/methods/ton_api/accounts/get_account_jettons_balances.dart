import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/jettons_balances.dart';

/// GetAccountJettonsBalances invokes getAccountJettonsBalances operation.
///
/// Get all JettonsResponse balances by owner address.
///
class TonApiGetAccountJettonsBalances
    extends TonApiRequestParam<JettonsBalancesResponse, Map<String, dynamic>> {
  final String accountId;

  /// accept ton and all possible fiat currencies
  final List<String>? currencies;
  TonApiGetAccountJettonsBalances({required this.accountId, this.currencies});
  @override
  String get method => TonApiMethods.getaccountjettonsbalances.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"currencies": currencies?.join(",")};
  @override
  JettonsBalancesResponse onResonse(Map<String, dynamic> json) {
    return JettonsBalancesResponse.fromJson(json);
  }
}
