import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/transaction.dart';

/// GetBlockchainTransaction invokes getBlockchainTransaction operation.
///
/// Get transaction data.
///
class TonApiGetBlockchainTransaction
    extends TonApiRequest<TransactionResponse, Map<String, dynamic>> {
  final String transactionId;
  TonApiGetBlockchainTransaction(this.transactionId);
  @override
  String get method => TonApiMethods.getblockchaintransaction.url;

  @override
  List<String> get pathParameters => [transactionId];

  @override
  TransactionResponse onResonse(Map<String, dynamic> result) {
    return TransactionResponse.fromJson(result);
  }
}
