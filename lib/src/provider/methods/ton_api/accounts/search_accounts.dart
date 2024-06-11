import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/found_accounts.dart';

/// SearchAccounts invokes searchAccounts operation.
///
/// Search by account domain name.
///
class TonApiSearchAccounts
    extends TonApiRequestParam<FoundAccountsResponse, Map<String, dynamic>> {
  final String name;
  TonApiSearchAccounts(this.name);

  @override
  String get method => TonApiMethods.searchaccounts.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, dynamic> get queryParameters => {"name": name};

  @override
  FoundAccountsResponse onResonse(Map<String, dynamic> json) {
    return FoundAccountsResponse.fromJson(json);
  }
}
