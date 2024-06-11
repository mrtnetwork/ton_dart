import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account_info_by_state_init.dart';

/// GetAccountInfoByStateInit invokes getAccountInfoByStateInit operation.
///
/// Get account info by state init.
///
class TonApiGetAccountInfoByStateInit extends TonApiPostRequestParam<
    AccountInfoByStateInitResponse, Map<String, dynamic>> {
  final String stateInit;
  TonApiGetAccountInfoByStateInit(this.stateInit);
  @override
  Object get body => {"state_init": stateInit};

  @override
  String get method => TonApiMethods.getaccountinfobystateinit.url;

  @override
  AccountInfoByStateInitResponse onResonse(Map<String, dynamic> json) {
    return AccountInfoByStateInitResponse.fromJson(json);
  }
}
