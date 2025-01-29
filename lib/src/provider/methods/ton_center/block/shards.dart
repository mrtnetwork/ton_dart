import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get shards information.
/// https://toncenter.com/api/v2/#/blocks/get_shards_shards_get
class TonCenterShards
    extends TonCenterPostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  /// Masterchain seqno to fetch shards of.
  final int seqno;
  TonCenterShards(this.seqno);

  @override
  String get method => TonCenterMethods.shards.name;

  @override
  Map<String, dynamic> params() {
    return {'seqno': seqno};
  }
}
