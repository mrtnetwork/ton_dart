import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// GetBlockchainConfigFromBlock invokes getBlockchainConfigFromBlock operation.
///
/// Get blockchain config from a specific block, if present.
///
class TonApiGetBlockchainConfigFromBlock
    extends TonApiRequest<Map<String, dynamic>, Map<String, dynamic>> {
  final String masterChainSeqno;
  TonApiGetBlockchainConfigFromBlock(this.masterChainSeqno);
  @override
  String get method => TonApiMethods.getblockchainconfigfromblock.url;

  @override
  List<String> get pathParameters => [masterChainSeqno];
}
