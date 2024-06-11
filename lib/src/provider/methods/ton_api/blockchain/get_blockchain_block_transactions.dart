import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/transactions.dart';

/// GetBlockchainBlockTransactions invokes getBlockchainBlockTransactions operation.
///
/// Get transactions from block.
///
class TonApiGetBlockchainBlockTransactions
    extends TonApiRequestParam<TransactionsResponse, Map<String, dynamic>> {
  final String blockId;
  TonApiGetBlockchainBlockTransactions(this.blockId);
  @override
  String get method => TonApiMethods.getblockchainblocktransactions.url;

  @override
  List<String> get pathParameters => [blockId];

  @override
  TransactionsResponse onResonse(Map<String, dynamic> json) {
    return TransactionsResponse.fromJson(json);
  }
}
