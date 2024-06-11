import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';
import 'package:ton_dart/src/provider/models/response/ton_center_address_info.dart';

/// Get basic information about the address: balance, code, data, last_transaction_id.
/// https://toncenter.com/api/v2/#/accounts/get_address_information_getAddressInformation_get
class TonCenterGetAddressInformation extends TonCenterPostRequestParam<
    TonCenterFullAccountStateResponse, Map<String, dynamic>> {
  /// Identifier of target TON account in any form.
  final String address;
  TonCenterGetAddressInformation(this.address);

  @override
  String get method => TonCenterMethods.getAddressInformation.name;

  @override
  Map<String, dynamic> params() {
    return {"address": address};
  }

  @override
  TonCenterFullAccountStateResponse onResonse(Map<String, dynamic> json) {
    return TonCenterFullAccountStateResponse.fromJson(json);
  }
}
