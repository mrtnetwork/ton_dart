import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Convert an address from human-readable to raw format.
/// https://toncenter.com/api/v2/#/accounts/unpack_address_unpackAddress_get
class TonCenterUnpackAddress extends TonCenterPostRequest<String, String> {
  /// Identifier of target TON account in raw form
  /// Example : EQCD39VS5jcptHL8vMjEXrzGaRcCVYto7HUn4bpAOg8xqB2N
  final String address;

  TonCenterUnpackAddress(this.address);

  @override
  String get method => TonCenterMethods.unpackAddress.name;

  @override
  Map<String, dynamic> params() {
    return {'address': address};
  }
}
