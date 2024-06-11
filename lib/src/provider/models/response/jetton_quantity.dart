import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'jetton_preview.dart';

class JettonQuantityResponse with JsonSerialization {
  final String quantity;
  final AccountAddressResponse walletAddress;
  final JettonPreviewResponse jetton;

  const JettonQuantityResponse(
      {required this.quantity,
      required this.walletAddress,
      required this.jetton});

  factory JettonQuantityResponse.fromJson(Map<String, dynamic> json) {
    return JettonQuantityResponse(
      quantity: json['quantity'],
      walletAddress: AccountAddressResponse.fromJson(json['wallet_address']),
      jetton: JettonPreviewResponse.fromJson(json['jetton']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'wallet_address': walletAddress.toJson(),
      'jetton': jetton.toJson()
    };
  }
}
