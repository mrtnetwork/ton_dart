import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_blockchain_block_state.dart';

/// GetRawBlockchainBlockState invokes getRawBlockchainBlockState operation.
///
/// Get raw blockchain block state.
///
class TonApiGetRawBlockchainBlockState extends TonApiRequest<
    RawBlockchainBlockStateResponse, Map<String, dynamic>> {
  final String blockId;
  TonApiGetRawBlockchainBlockState(this.blockId);
  @override
  String get method => TonApiMethods.getrawblockchainblockstate.url;

  @override
  List<String> get pathParameters => [blockId];

  @override
  RawBlockchainBlockStateResponse onResonse(Map<String, dynamic> result) {
    return RawBlockchainBlockStateResponse.fromJson(result);
  }
}
