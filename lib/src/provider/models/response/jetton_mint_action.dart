import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'jetton_preview.dart';

class JettonMintActionResponse with JsonSerialization {
  final AccountAddressResponse recipient;
  final String recipientsWallet;
  final String amount;
  final JettonPreviewResponse jetton;

  const JettonMintActionResponse(
      {required this.recipient,
      required this.recipientsWallet,
      required this.amount,
      required this.jetton});

  factory JettonMintActionResponse.fromJson(Map<String, dynamic> json) {
    return JettonMintActionResponse(
        recipient: AccountAddressResponse.fromJson(json['recipient']),
        recipientsWallet: json['recipients_wallet'],
        amount: json['amount'],
        jetton: JettonPreviewResponse.fromJson(json['jetton']));
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'recipient': recipient.toJson(),
      'recipients_wallet': recipientsWallet,
      'amount': amount,
      'jetton': jetton.toJson(),
    };
  }
}
