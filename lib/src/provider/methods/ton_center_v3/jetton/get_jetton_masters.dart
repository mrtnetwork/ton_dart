import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_v3_methods.dart';

/// Get Jetton masters by specified filters.
/// https://toncenter.com/api/v3/#/default/get_jetton_masters_api_v3_jetton_masters_get
class TonCenterV3GetJettonMasters extends TonCenterV3RequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  /// Jetton Master address. Must be sent in hex, base64 and base64url forms.
  final String? address;

  /// Address of Jetton Master's admin. Must be sent in hex, base64 and base64url forms.
  final String? adminAddress;

  /// Limit number of queried rows. Use with offset to batch read.
  /// Default value : 128
  final int? limit;

  /// Skip first N rows. Use with limit to batch read.
  /// Default value : 0
  final int? offset;

  @override
  Map<String, dynamic> get queryParameters => {
        "address": address,
        "admin_address": adminAddress,
        "limit": limit,
        "offset": offset
      };

  TonCenterV3GetJettonMasters(
      {this.address, this.adminAddress, this.limit, this.offset});
  @override
  String get method => TonCenterV3Methods.jettonMasters.uri;
}
