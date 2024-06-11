import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get NFT or Jetton information.
/// https://toncenter.com/api/v2/#/accounts/get_token_data_getTokenData_get
class TonCenterGetTokenData extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  /// TonAddress of NFT collection/item or Jetton master/wallet smart contract
  final String address;
  TonCenterGetTokenData(this.address);

  @override
  String get method => TonCenterMethods.getTokenData.name;

  @override
  Map<String, dynamic> params() {
    return {"address": address};
  }
}
