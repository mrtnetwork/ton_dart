import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_block_proof.dart';

/// GetRawBlockProof invokes getRawBlockProof operation.
///
/// Get raw block proof.
///
class TonApiGetRawBlockProof
    extends TonApiRequest<RawBlockProofResponse, Map<String, dynamic>> {
  /// known block: (workchain,shard,seqno,root_hash,file_hash)
  /// (-1,8000000000000000,4234234,3E575DAB1D25...90D8,47192E5C46C...BB29)
  final String knownBlock;

  /// target block: (workchain,shard,seqno,root_hash,file_hash)
  /// (-1,8000000000000000,4234234,3E575DAB1D25...90D8,47192E5C46C...BB29)
  final String? targetBlock;
  final int mode;
  TonApiGetRawBlockProof(
      {required this.knownBlock, this.targetBlock, required this.mode});
  @override
  String get method => TonApiMethods.getrawblockproof.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, dynamic> get queryParameters =>
      {'known_block': knownBlock, 'target_block': targetBlock, 'mode': mode};

  @override
  RawBlockProofResponse onResonse(Map<String, dynamic> result) {
    return RawBlockProofResponse.fromJson(result);
  }
}
