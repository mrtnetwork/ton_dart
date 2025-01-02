import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account.dart';

/// GetAccount invokes getAccount operation.
///
/// Get human-friendly information about an account without low-level details.
///
class TonApiGetAccount
    extends TonApiRequest<AccountResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiGetAccount(this.accountId);

  @override
  String get method => TonApiMethods.getaccount.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  AccountResponse onResonse(Map<String, dynamic> result) {
    return AccountResponse.fromJson(result);
  }
}
