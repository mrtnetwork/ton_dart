import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get metadata of a given block.
/// https://toncenter.com/api/v2/#/blocks/get_block_header_getBlockHeader_get
class TonCenterGetBlockHeader extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  final int workchain;
  final int shard;
  final int seqno;
  final String? rootHash;
  final String? fileHash;

  TonCenterGetBlockHeader(
      {required this.workchain,
      required this.shard,
      required this.seqno,
      this.rootHash,
      this.fileHash});

  @override
  String get method => TonCenterMethods.getBlockHeader.name;

  @override
  Map<String, dynamic> params() {
    return {
      "workchain": workchain,
      "shard": shard,
      "seqno": seqno,
      "root_hash": rootHash,
      "file_hash": fileHash
    };
  }
}
