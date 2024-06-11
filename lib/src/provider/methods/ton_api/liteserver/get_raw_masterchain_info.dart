import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_master_chain_info.dart';

/// GetRawMasterchainInfo invokes getRawMasterchainInfo operation.
///
/// Get raw masterchain info.
///
class TonApiGetRawMasterchainInfo extends TonApiRequestParam<
    RawMasterchainInfoResponse, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.getrawmasterchaininfo.url;

  @override
  RawMasterchainInfoResponse onResonse(Map<String, dynamic> json) {
    return RawMasterchainInfoResponse.fromJson(json);
  }
}
