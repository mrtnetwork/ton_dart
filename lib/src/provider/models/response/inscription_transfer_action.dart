import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'incription_balance_type.dart';

class InscriptionTransferActionResponse with JsonSerialization {
  final AccountAddressResponse sender;
  final AccountAddressResponse recipient;
  final String amount;
  final String? comment;
  final InscriptionTypeResponse type;
  final String ticker;
  final int decimals;

  const InscriptionTransferActionResponse({
    required this.sender,
    required this.recipient,
    required this.amount,
    this.comment,
    required this.type,
    required this.ticker,
    required this.decimals,
  });

  factory InscriptionTransferActionResponse.fromJson(
      Map<String, dynamic> json) {
    return InscriptionTransferActionResponse(
        sender: AccountAddressResponse.fromJson(json['sender']),
        recipient: AccountAddressResponse.fromJson(json['recipient']),
        amount: json['amount'],
        comment: json['comment'],
        type: InscriptionTypeResponse.fromName(json['type']),
        ticker: json['ticker'],
        decimals: json['decimals']);
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
      'amount': amount,
      'comment': comment,
      'type': type.value,
      'ticker': ticker,
      'decimals': decimals,
    };
  }
}
