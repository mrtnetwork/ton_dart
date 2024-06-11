import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get all possible address forms
/// https://toncenter.com/api/v2/#/accounts/detect_address_detectAddress_get
class TonCenterDetectAddress extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  /// Identifier of target TON account in any form
  final String address;
  TonCenterDetectAddress(this.address);

  @override
  String get method => TonCenterMethods.detectAddress.name;

  @override
  Map<String, dynamic> params() {
    return {"address": address};
  }
}
