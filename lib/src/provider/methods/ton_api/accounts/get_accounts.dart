import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/accounts.dart';

/// GetAccounts invokes getAccounts operation.
///
/// Get human-friendly information about several accounts without low-level details.
///
class TonApiGetAccounts
    extends TonApiPostRequest<AccountsResponse, Map<String, dynamic>> {
  final List<String> accountIds;
  TonApiGetAccounts(this.accountIds);
  @override
  Map<String, dynamic> get body => {'account_ids': accountIds};

  @override
  String get method => TonApiMethods.getaccounts.url;

  @override
  List<String> get pathParameters => [];
  @override
  AccountsResponse onResonse(Map<String, dynamic> result) {
    return AccountsResponse.fromJson(result);
  }
}
