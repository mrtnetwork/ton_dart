import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/transaction.dart';

/// GetBlockchainTransactionByMessageHash invokes getBlockchainTransactionByMessageHash operation.
///
/// Get transaction data by message hash.
///
class TonApiGetBlockchainTransactionByMessageHash
    extends TonApiRequestParam<TransactionResponse, Map<String, dynamic>> {
  final String messageId;
  TonApiGetBlockchainTransactionByMessageHash(this.messageId);

  @override
  String get method => TonApiMethods.getblockchaintransactionbymessagehash.url;

  @override
  List<String> get pathParameters => [messageId];

  @override
  TransactionResponse onResonse(Map<String, dynamic> json) {
    return TransactionResponse.fromJson(json);
  }
}
