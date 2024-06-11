import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Convert an address from raw to human-readable format
/// https://toncenter.com/api/v2/#/accounts/pack_address_packAddress_get
class TonCenterPackAddress extends TonCenterPostRequestParam<String, String> {
  /// Identifier of target TON account in raw form
  /// Example : 0:83DFD552E63729B472FCBCC8C45EBCC6691702558B68EC7527E1BA403A0F31A8
  final String address;

  TonCenterPackAddress(this.address);

  @override
  String get method => TonCenterMethods.packAddress.name;

  @override
  Map<String, dynamic> params() {
    return {"address": address};
  }
}
