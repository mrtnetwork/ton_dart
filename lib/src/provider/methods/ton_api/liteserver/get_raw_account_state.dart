import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_account_state.dart';

/// GetRawAccountState invokes getRawAccountState operation.
///
/// Get raw account state.
///
class TonApiGetRawAccountState
    extends TonApiRequestParam<RawAccountStateResponse, Map<String, dynamic>> {
  final String accountId;

  /// target block: (workchain,shard,seqno,root_hash,file_hash)
  /// (-1,8000000000000000,4234234,3E575DAB1D25...90D8,47192E5C46C...BB29)
  final String? targetBlock;

  TonApiGetRawAccountState({required this.accountId, this.targetBlock});

  @override
  String get method => TonApiMethods.getrawaccountstate.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters => {"target_block": targetBlock};

  @override
  RawAccountStateResponse onResonse(Map<String, dynamic> json) {
    return RawAccountStateResponse.fromJson(json);
  }
}
