import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_v3_methods.dart';
import 'package:ton_dart/src/provider/models/response/toncenter_v3_transactions.dart';

/// Get transactions by specified filter.
/// https://toncenter.com/api/v3/index.html#/blockchain/api_v3_get_transactions
class TonCenterV3Traces extends TonCenterV3RequestParam<TonCenterTracesResponse,
    Map<String, dynamic>> {
  final String? account;
  final List<String>? traceId;
  final List<String>? txHash;
  final List<String>? msgHash;
  final int? mcSeqno;
  final int? startUtime;
  final int? endUtime;
  final int? startLt;
  final int? endLt;
  final bool? includeActions;
  final List<String>? supportActionType;
  final int? limit;
  final int? offset;
  final String? sort;
  TonCenterV3Traces(
      {this.mcSeqno,
      this.traceId,
      this.txHash,
      this.msgHash,
      this.includeActions,
      this.supportActionType,
      this.account,
      this.startUtime,
      this.endUtime,
      this.startLt,
      this.endLt,
      this.limit,
      this.offset,
      this.sort});
  @override
  Map<String, dynamic> get queryParameters => {
        "account": account,
        "trace_id": traceId,
        "tx_hash": txHash,
        "msg_hash": msgHash,
        "mc_seqno": mcSeqno,
        "start_utime": startUtime,
        "end_utime": endUtime,
        "start_lt": startLt,
        "end_lt": endLt,
        "limit": limit,
        "offset": offset,
        "sort": sort,
        "supported_action_types": supportActionType,
        "include_actions": includeActions
      };
  @override
  String get method => TonCenterV3Methods.traces.uri;

  @override
  TonCenterTracesResponse onResonse(Map<String, dynamic> result) {
    return TonCenterTracesResponse.fromJson(result);
  }
}
