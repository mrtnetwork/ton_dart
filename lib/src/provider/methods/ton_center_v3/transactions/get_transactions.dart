import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_v3_methods.dart';
import 'package:ton_dart/src/provider/models/response/toncenter_v3_transactions.dart';

/// Get transactions by specified filter.
/// https://toncenter.com/api/v3/index.html#/blockchain/api_v3_get_transactions
class TonCenterV3GetTransactions extends TonCenterV3RequestParam<
    TonCenterV3GetTransactionsResponse, Map<String, dynamic>> {
  final int? workchain;
  final String? shard;
  final int? seqno;
  final int? mcSeqno;
  final List<String>? account;
  final List<String>? excludeAccount;
  final String? hash;
  final int? lt;
  final int? startUtime;
  final int? endUtime;
  final int? startLt;
  final int? endLt;
  final int? limit;
  final int? offset;
  final String? sort;
  TonCenterV3GetTransactions(
      {this.workchain,
      this.shard,
      this.seqno,
      this.mcSeqno,
      this.account,
      this.excludeAccount,
      this.hash,
      this.lt,
      this.startUtime,
      this.endUtime,
      this.startLt,
      this.endLt,
      this.limit,
      this.offset,
      this.sort});
  @override
  Map<String, dynamic> get queryParameters => {
        "workchain": workchain,
        "shard": shard,
        "seqno": seqno,
        "mc_seqno": mcSeqno,
        "account": account,
        "exclude_account": excludeAccount,
        "hash": hash,
        "lt": lt,
        "start_utime": startUtime,
        "end_utime": endUtime,
        "start_lt": startLt,
        "end_lt": endLt,
        "limit": limit,
        "offset": offset,
        "sort": sort
      };
  @override
  String get method => TonCenterV3Methods.transactions.uri;

  @override
  TonCenterV3GetTransactionsResponse onResonse(Map<String, dynamic> result) {
    return TonCenterV3GetTransactionsResponse.fromJson(result);
  }
}
