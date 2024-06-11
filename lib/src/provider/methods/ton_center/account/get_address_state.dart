import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get state of a given address. State can be either unitialized, active or frozen.
/// https://toncenter.com/api/v2/#/accounts/get_address_getAddressState_get
class TonCenterGetAddressState
    extends TonCenterPostRequestParam<String, String> {
  /// Identifier of target TON account in any form
  final String address;
  TonCenterGetAddressState(this.address);

  @override
  String get method => TonCenterMethods.getAddressState.name;

  @override
  Map<String, dynamic> params() {
    return {"address": address};
  }
}
