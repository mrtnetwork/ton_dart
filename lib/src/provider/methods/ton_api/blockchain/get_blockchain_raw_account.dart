import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/blockchain_raw_account.dart';

/// GetBlockchainRawAccount invokes getBlockchainRawAccount operation.
///
/// Get low-level information about an account taken directly from the blockchain.
///
class TonApiGetBlockchainRawAccount
    extends TonApiRequest<BlockchainRawAccountResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiGetBlockchainRawAccount(this.accountId);
  @override
  String get method => TonApiMethods.getblockchainrawaccount.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  BlockchainRawAccountResponse onResonse(Map<String, dynamic> result) {
    return BlockchainRawAccountResponse.fromJson(result);
  }
}
