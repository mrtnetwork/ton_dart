import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_v3_methods.dart';

class TonCenterV3GetMasterChainInfo extends TonCenterV3RequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  @override
  String get method => TonCenterV3Methods.masterchainInfo.uri;
}
