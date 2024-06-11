import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account_staking.dart';

/// GetAccountNominatorsPools invokes getAccountNominatorsPools operation.
///
/// All pools where account participates.
///
class TonApiGetAccountNominatorsPools
    extends TonApiRequestParam<AccountStakingResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiGetAccountNominatorsPools(this.accountId);
  @override
  String get method => TonApiMethods.getaccountnominatorspools.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  AccountStakingResponse onResonse(Map<String, dynamic> json) {
    return AccountStakingResponse.fromJson(json);
  }
}
