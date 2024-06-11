import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_shard_info.dart';

/// GetRawShardInfo invokes getRawShardInfo operation.
///
/// Get raw shard info.
///
class TonApiGetRawShardInfo
    extends TonApiRequestParam<RawShardInfoResponse, Map<String, dynamic>> {
  /// block ID: (workchain,shard,seqno,root_hash,file_hash)
  final String blockId;
  final int workchain;
  final int shard;
  final bool exact;
  TonApiGetRawShardInfo(
      {required this.blockId,
      required this.workchain,
      required this.shard,
      required this.exact});

  @override
  String get method => TonApiMethods.getrawshardinfo.url;

  @override
  List<String> get pathParameters => [blockId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"workchain": workchain, "shard": shard, "exact": exact};

  @override
  RawShardInfoResponse onResonse(Map<String, dynamic> json) {
    return RawShardInfoResponse.fromJson(json);
  }
}
