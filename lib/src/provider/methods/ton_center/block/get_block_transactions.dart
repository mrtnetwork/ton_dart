import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get transactions of the given block.
/// https://toncenter.com/api/v2/#/blocks/get_block_transactions_getBlockTransactions_get
class TonCenterGetBlockTransactions extends TonCenterPostRequestParam<
    List<Map<String, dynamic>>, List<Map<String, dynamic>>> {
  final int workchain;
  final int shard;
  final int seqno;
  final String? rootHash;
  final String? fileHash;
  final int? afterLt;
  final String? afterHash;
  final int? count;

  TonCenterGetBlockTransactions(
      {required this.workchain,
      required this.shard,
      required this.seqno,
      this.rootHash,
      this.fileHash,
      this.afterLt,
      this.afterHash,
      this.count});

  @override
  String get method => TonCenterMethods.getBlockTransactions.name;

  @override
  Map<String, dynamic> params() {
    return {
      "workchain": workchain,
      "shard": shard,
      "seqno": seqno,
      "root_hash": rootHash,
      "file_hash": fileHash,
      "after_lt": afterLt,
      "after_hash": afterHash,
      "count": count
    };
  }
}
