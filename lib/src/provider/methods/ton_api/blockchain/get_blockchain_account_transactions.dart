import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account_transaction_sort_order.dart';
import 'package:ton_dart/src/provider/models/response/transactions.dart';

/// GetBlockchainAccountTransactions invokes getBlockchainAccountTransactions operation.
///
/// Get account transactions.
///
class TonApiGetBlockchainAccountTransactions
    extends TonApiRequest<TransactionsResponse, Map<String, dynamic>> {
  final String accountId;
  final BigInt? afterLt;
  final BigInt? beforeLt;
  final int? limit;
  final GetBlockchainAccountTransactionsSortOrder? sortOrder;

  TonApiGetBlockchainAccountTransactions(
      {required this.accountId,
      this.afterLt,
      this.beforeLt,
      this.limit,
      this.sortOrder});

  @override
  String get method => TonApiMethods.getblockchainaccounttransactions.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters => {
        'sort_order': sortOrder?.name,
        'before_lt': beforeLt,
        'after_lt': afterLt,
        'limit': limit
      };

  @override
  TransactionsResponse onResonse(Map<String, dynamic> result) {
    return TransactionsResponse.fromJson(result);
  }
}
