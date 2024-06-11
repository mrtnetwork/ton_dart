import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// GetAccountPublicKey invokes getAccountPublicKey operation.
///
/// Get public key by account id.
///
class TonApiGetAccountPublicKey
    extends TonApiRequestParam<String, Map<String, dynamic>> {
  final String accountId;
  TonApiGetAccountPublicKey(this.accountId);
  @override
  String get method => TonApiMethods.getaccountpublickey.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  String onResonse(Map<String, dynamic> json) {
    return json["public_key"];
  }
}
