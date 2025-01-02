import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Look up block by either seqno, lt or unixtime.
/// https://toncenter.com/api/v2/#/blocks/lookup_block_lookupBlock_get
class TonCenterLookupBlock
    extends TonCenterPostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  /// Workchain id to look up block in
  final int workchain;

  /// Shard id to look up block in
  final int shard;

  /// Block's height
  final int? seqno;

  /// Block's logical time
  final int? lt;

  /// Block's unixtime
  final int? unixtime;

  TonCenterLookupBlock(
      {required this.workchain,
      required this.shard,
      this.seqno,
      this.lt,
      this.unixtime});

  @override
  String get method => TonCenterMethods.lookupBlock.name;

  @override
  Map<String, dynamic> params() {
    return {
      'workchain': workchain,
      'shard': shard,
      'seqno': seqno,
      'lt': lt,
      'unixtime': unixtime
    };
  }
}
