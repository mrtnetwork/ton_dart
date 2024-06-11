import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Retrieve wallet information. This method parses contract state and currently supports more wallet types than
/// getExtendedAddressInformation: simple wallet, standart wallet, v3 wallet, v4 wallet.
/// https://toncenter.com/api/v2/#/accounts/get_wallet_information_getWalletInformation_get
class TonCenterGetWalletInformation extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  final String address;
  TonCenterGetWalletInformation(this.address);

  @override
  String get method => TonCenterMethods.getWalletInformation.name;

  @override
  Map<String, dynamic> params() {
    return {"address": address};
  }
}
