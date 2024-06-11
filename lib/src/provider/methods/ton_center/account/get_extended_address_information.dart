import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Similar to getAddressInformation but tries to parse additional information for known contract types.
/// This method is based on tonlib's function getAccountState. For detecting wallets we recommend to use getWalletInformation.
/// https://toncenter.com/api/v2/#/accounts/get_extended_address_information_getExtendedAddressInformation_get
class TonCenterGetExtendedAddressInformation extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  /// Identifier of target TON account in any form
  final String address;

  TonCenterGetExtendedAddressInformation(this.address);

  @override
  String get method => TonCenterMethods.getExtendedAddressInformation.name;

  @override
  Map<String, dynamic> params() {
    return {"address": address};
  }
}
