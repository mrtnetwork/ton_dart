import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_blockchain_block_header.dart';

/// GetRawBlockchainBlockHeader invokes getRawBlockchainBlockHeader operation.
///
/// Get raw blockchain block header.
///
class TonApiGetRawBlockchainBlockHeader extends TonApiRequest<
    RawBlockchainBlockHeaderResponseResponse, Map<String, dynamic>> {
  final String blockId;
  final int mode;
  TonApiGetRawBlockchainBlockHeader(
      {required this.blockId, required this.mode});

  @override
  String get method => TonApiMethods.getrawblockchainblockheader.url;

  @override
  List<String> get pathParameters => [blockId];

  @override
  Map<String, dynamic> get queryParameters => {'mode': mode};

  @override
  RawBlockchainBlockHeaderResponseResponse onResonse(
      Map<String, dynamic> result) {
    return RawBlockchainBlockHeaderResponseResponse.fromJson(result);
  }
}
