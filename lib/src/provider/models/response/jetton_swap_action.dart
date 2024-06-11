import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'account_address.dart';
import 'jetton_preview.dart';
import 'jetton_swap_action_dex.dart';

class JettonSwapActionResponse with JsonSerialization {
  final JettonSwapActionDexResponse dex;
  final String amountIn;
  final String amountOut;
  final BigInt? tonIn;
  final BigInt? tonOut;
  final AccountAddressResponse userWallet;
  final AccountAddressResponse router;
  final JettonPreviewResponse? jettonMasterIn;
  final JettonPreviewResponse? jettonMasterOut;

  const JettonSwapActionResponse({
    required this.dex,
    required this.amountIn,
    required this.amountOut,
    required this.userWallet,
    required this.router,
    this.tonIn,
    this.tonOut,
    this.jettonMasterIn,
    this.jettonMasterOut,
  });

  factory JettonSwapActionResponse.fromJson(Map<String, dynamic> json) {
    return JettonSwapActionResponse(
      dex: JettonSwapActionDexResponse.fromName(json['dex']),
      amountIn: json['amount_in'] as String,
      amountOut: json['amount_out'] as String,
      tonIn: BigintUtils.tryParse(json['ton_in']),
      tonOut: BigintUtils.tryParse(json['ton_out']),
      userWallet: AccountAddressResponse.fromJson(json['user_wallet']),
      router: AccountAddressResponse.fromJson(json['router']),
      jettonMasterIn: json['jetton_master_in'] == null
          ? null
          : JettonPreviewResponse.fromJson(json['jetton_master_in']),
      jettonMasterOut: json['jetton_master_out'] == null
          ? null
          : JettonPreviewResponse.fromJson(json['jetton_master_out']),
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'dex': dex.value,
      'amount_in': amountIn,
      'amount_out': amountOut,
      'user_wallet': userWallet.toJson(),
      'router': router.toJson(),
      'ton_in': tonIn?.toString(),
      'ton_out': tonOut?.toString(),
      'jetton_master_in': jettonMasterIn?.toJson(),
      'jetton_master_out': jettonMasterOut?.toJson()
    };
  }
}
