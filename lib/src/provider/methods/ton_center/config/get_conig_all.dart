import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get config by id.
/// https://toncenter.com/api/v2/#/get%20config/get_config_param_getConfigParam_get
class TonCenterGetConfigAll
    extends TonCenterPostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  /// Masterchain seqno. If not specified, latest blockchain state will be used.
  final int? seqno;
  TonCenterGetConfigAll({this.seqno});

  @override
  String get method => TonCenterMethods.getConfigAll.name;

  @override
  Map<String, dynamic> params() {
    return {'seqno': seqno};
  }
}
