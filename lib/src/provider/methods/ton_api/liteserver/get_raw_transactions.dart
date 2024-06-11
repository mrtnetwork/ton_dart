import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_transaction.dart';

/// GetRawTransactions invokes getRawTransactions operation.
///
/// Get raw transactions.
///
class TonApiGetRawTransactions
    extends TonApiRequestParam<RawTransactionResponse, Map<String, dynamic>> {
  final String accountId;
  final int count;
  final BigInt lt;
  final String hash;
  TonApiGetRawTransactions(
      {required this.accountId,
      required this.count,
      required this.lt,
      required this.hash});
  @override
  String get method => TonApiMethods.getrawtransactions.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"count": count, "lt": lt, "hash": hash};

  @override
  RawTransactionResponse onResonse(Map<String, dynamic> json) {
    return RawTransactionResponse.fromJson(json);
  }
}
