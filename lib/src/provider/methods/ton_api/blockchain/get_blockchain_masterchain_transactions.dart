import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/transactions.dart';

/// GetBlockchainMasterchainTransactions invokes getBlockchainMasterchainTransactions operation.
///
/// Get all transactions in all shards and workchains between target and previous masterchain block
/// according to shards last blocks snapshot in masterchain. We don't recommend to build your app
/// around this method because it has problem with scalability and will work very slow in the future.
///
class TonApiGetBlockchainMasterchainTransactions
    extends TonApiRequest<TransactionsResponse, Map<String, dynamic>> {
  final int masterchainSeqno;
  TonApiGetBlockchainMasterchainTransactions(this.masterchainSeqno);
  @override
  String get method => TonApiMethods.getblockchainmasterchaintransactions.url;

  @override
  List<String> get pathParameters => [masterchainSeqno.toString()];

  @override
  TransactionsResponse onResonse(Map<String, dynamic> result) {
    return TransactionsResponse.fromJson(result);
  }
}
