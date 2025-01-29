import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_v3_methods.dart';

class TonCenterV3Account extends TonCenterV3RequestParam<Map<String, dynamic>,
    Map<String, dynamic>> {
  final String address;
  TonCenterV3Account({required this.address});

  @override
  Map<String, dynamic> get queryParameters => {'address': address};

  @override
  String get method => TonCenterV3Methods.account.uri;
}
