import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// GetRawBlockchainBlock invokes getRawBlockchainBlock operation.
///
/// Get raw blockchain block.
///
class TonApiGetRawBlockchainBlock
    extends TonApiRequestParam<Map<String, dynamic>, Map<String, dynamic>> {
  /// block ID: (workchain,shard,seqno,root_hash,file_hash)
  final String blockId;
  TonApiGetRawBlockchainBlock(this.blockId);
  @override
  String get method => TonApiMethods.getrawblockchainblock.url;

  @override
  List<String> get pathParameters => [blockId];
}
