import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/all_raw_shards_info.dart';

/// GetAllRawShardsInfo invokes getAllRawShardsInfo operation.
///
/// Get all raw shards info.
///
class TonApiGetAllRawShardsInfo
    extends TonApiRequest<GetAllRawShardsInfoResponse, Map<String, dynamic>> {
  /// block ID: (workchain,shard,seqno,root_hash,file_hash)
  /// (-1,8000000000000000,4234234,3E575DAB1D25...90D8,47192E5C46C...BB29)
  final String blockId;
  TonApiGetAllRawShardsInfo(this.blockId);
  @override
  String get method => TonApiMethods.getallrawshardsinfo.url;

  @override
  List<String> get pathParameters => [blockId];

  @override
  GetAllRawShardsInfoResponse onResonse(Map<String, dynamic> result) {
    return GetAllRawShardsInfoResponse.fromJson(result);
  }
}
