import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get up-to-date masterchain state.
/// https://toncenter.com/api/v2/#/blocks/get_masterchain_info_getMasterchainInfo_get
class TonCenterGetMasterchainInfo
    extends TonCenterPostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  TonCenterGetMasterchainInfo();

  @override
  String get method => TonCenterMethods.getMasterchainInfo.name;

  @override
  Map<String, dynamic> params() {
    return {};
  }
}
