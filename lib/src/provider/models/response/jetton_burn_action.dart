import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'jetton_preview.dart';

class JettonBurnActionResponse with JsonSerialization {
  final AccountAddressResponse sender;
  final String sendersWallet;
  final String amount;
  final JettonPreviewResponse jetton;

  const JettonBurnActionResponse({
    required this.sender,
    required this.sendersWallet,
    required this.amount,
    required this.jetton,
  });

  factory JettonBurnActionResponse.fromJson(Map<String, dynamic> json) {
    return JettonBurnActionResponse(
      sender: AccountAddressResponse.fromJson(json['sender']),
      sendersWallet: json['senders_wallet'],
      amount: json['amount'],
      jetton: JettonPreviewResponse.fromJson(json['jetton']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'senders_wallet': sendersWallet,
      'amount': amount,
      'jetton': jetton.toJson(),
    };
  }
}
