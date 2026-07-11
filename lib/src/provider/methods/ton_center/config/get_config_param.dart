import 'package:blockchain_utils/utils/json/json.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';
import 'package:ton_dart/src/provider/models/response/v2_config_params.dart';

/// Get config by id.
/// https://toncenter.com/api/v2/#/get%20config/get_config_param_getConfigParam_get
class TonCenterGetConfigParam
    extends TonCenterPostRequest<V2ConfigParamsResponse, Map<String, dynamic>> {
  final int configId;

  /// Masterchain seqno. If not specified, latest blockchain state will be used.
  final int? seqno;
  TonCenterGetConfigParam({required this.configId, this.seqno});

  @override
  String get method => TonCenterMethods.getConfigParam.name;

  @override
  Map<String, dynamic> params() {
    return {'config_id': configId, 'seqno': seqno};
  }

  @override
  V2ConfigParamsResponse onResonse(Map<String, dynamic> result) {
    return V2ConfigParamsResponse.fromJson(
      result.valueEnsureAsMap<String, dynamic>("config"),
    );
  }
}
