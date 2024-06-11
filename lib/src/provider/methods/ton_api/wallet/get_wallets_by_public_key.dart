import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/accounts.dart';

/// GetWalletsByPublicKey invokes getWalletsByPublicKey operation.
///
/// Get wallets by public key.
///
class TonApiGetWalletsByPublicKey
    extends TonApiRequestParam<AccountsResponse, Map<String, dynamic>> {
  final String publicKey;
  TonApiGetWalletsByPublicKey(this.publicKey);
  @override
  String get method => TonApiMethods.getwalletsbypublickey.url;

  @override
  List<String> get pathParameters => [publicKey];

  @override
  AccountsResponse onResonse(Map<String, dynamic> json) {
    return AccountsResponse.fromJson(json);
  }
}
