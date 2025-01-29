import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_blockchain_config.dart';

/// GetRawBlockchainConfigFromBlock invokes getRawBlockchainConfigFromBlock operation.
///
/// Get raw blockchain config from a specific block, if present.
///
class TonApiGetRawBlockchainConfigFromBlock
    extends TonApiRequest<RawBlockchainConfigResponse, Map<String, dynamic>> {
  final int masterchainSeqno;
  TonApiGetRawBlockchainConfigFromBlock(this.masterchainSeqno);
  @override
  String get method => TonApiMethods.getrawblockchainconfigfromblock.url;

  @override
  List<String> get pathParameters => [masterchainSeqno.toString()];

  @override
  RawBlockchainConfigResponse onResonse(Map<String, dynamic> result) {
    return RawBlockchainConfigResponse.fromJson(result);
  }
}
