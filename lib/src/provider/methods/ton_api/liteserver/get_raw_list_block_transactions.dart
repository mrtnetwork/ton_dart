import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_list_block_transactions.dart';

/// GetRawListBlockTransactions invokes getRawListBlockTransactions operation.
///
/// Get raw list block transactions.
///
class TonApiGetRawListBlockTransactions extends TonApiRequestParam<
    RawListBlockTransactionsResponse, Map<String, dynamic>> {
  /// block ID: (workchain,shard,seqno,root_hash,file_hash)
  final String blockId;
  final int mode;
  final int count;
  final String? accountId;
  final BigInt? lt;
  TonApiGetRawListBlockTransactions(
      {required this.blockId,
      required this.mode,
      required this.count,
      this.accountId,
      this.lt});

  @override
  String get method => TonApiMethods.getrawlistblocktransactions.url;

  @override
  List<String> get pathParameters => [blockId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"lt": lt, "account_id": accountId, "count": count, "mode": mode};

  @override
  RawListBlockTransactionsResponse onResonse(Map<String, dynamic> json) {
    return RawListBlockTransactionsResponse.fromJson(json);
  }
}
