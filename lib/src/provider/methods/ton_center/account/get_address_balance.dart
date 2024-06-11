import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get balance (in nanotons) of a given address.
/// https://toncenter.com/api/v2/#/accounts/get_address_balance_getAddressBalance_get
class TonCenterGetAddressBalance
    extends TonCenterPostRequestParam<BigInt, String> {
  /// Identifier of target TON account in any form.
  final String address;

  TonCenterGetAddressBalance(this.address);

  @override
  String get method => TonCenterMethods.getAddressBalance.name;

  @override
  Map<String, dynamic> params() {
    return {"address": address};
  }

  @override
  BigInt onResonse(String json) {
    return BigintUtils.parse(json);
  }
}
