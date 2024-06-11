import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/blockchain_account_inspect.dart';

/// BlockchainAccountInspectResponse invokes blockchainAccountInspect operation.
///
/// Blockchain account inspect.
///
class TonApiBlockchainAccountInspect extends TonApiRequestParam<
    BlockchainAccountInspectResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiBlockchainAccountInspect(this.accountId);
  @override
  String get method => TonApiMethods.blockchainaccountinspect.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  BlockchainAccountInspectResponse onResonse(Map<String, dynamic> json) {
    return BlockchainAccountInspectResponse.fromJson(json);
  }
}
