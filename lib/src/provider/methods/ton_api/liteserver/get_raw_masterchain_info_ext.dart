import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_master_chain_info_ext.dart';

/// GetRawMasterchainInfoExt invokes getRawMasterchainInfoExt operation.
///
/// Get raw masterchain info ext.
///
class TonApiGetRawMasterchainInfoExt extends TonApiRequestParam<
    RawMasterchainInfoExtResponse, Map<String, dynamic>> {
  final int mode;
  TonApiGetRawMasterchainInfoExt(this.mode);
  @override
  String get method => TonApiMethods.getrawmasterchaininfoext.url;

  @override
  Map<String, dynamic> get queryParameters => {"mode": mode};
  @override
  RawMasterchainInfoExtResponse onResonse(Map<String, dynamic> json) {
    return RawMasterchainInfoExtResponse.fromJson(json);
  }
}
