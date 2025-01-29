import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_v3_methods.dart';
import 'package:ton_dart/src/provider/models/response/jetton_wallets_response.dart';

/// Get Jetton wallets by specified filters.
/// https://toncenter.com/api/v3/#/default/get_jetton_wallets_api_v3_jetton_wallets_get
class TonCenterV3GetJettonWallets extends TonCenterV3RequestParam<
    List<JettonWalletsResponse>, Map<String, dynamic>> {
  static const int maximumLimit = 256;

  /// Jetton wallet address. Must be sent in hex, base64 and base64url forms.
  final String? address;

  /// Address of Jetton wallet's owner. Must be sent in hex, base64 and base64url forms.
  final String? ownerAddress;

  /// Jetton Master. Must be sent in hex, base64 and base64url forms.
  final String? jettonAddress;

  /// Limit number of queried rows. Use with offset to batch read.
  /// Default value : 128
  final int? limit;

  /// Skip first N rows. Use with limit to batch read.
  /// Default value : 0
  final int? offset;

  @override
  Map<String, dynamic> get queryParameters => {
        'address': address,
        'owner_address': ownerAddress,
        'jetton_address': jettonAddress,
        'limit': limit,
        'offset': offset
      };

  TonCenterV3GetJettonWallets(
      {this.address,
      this.ownerAddress,
      this.jettonAddress,
      this.limit = maximumLimit,
      this.offset});
  @override
  String get method => TonCenterV3Methods.jettonWallets.uri;

  @override
  List<JettonWalletsResponse> onResonse(Map<String, dynamic> result) {
    return (result['jetton_wallets'] as List?)
            ?.map((e) => JettonWalletsResponse.fromJson(e))
            .toList() ??
        [];
  }
}
