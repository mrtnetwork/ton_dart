import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'incription_balance_type.dart';

class InscriptionMintActionResponse with JsonSerialization {
  final AccountAddressResponse recipient;
  final String amount;
  final InscriptionTypeResponse type;
  final String ticker;
  final int decimals;

  const InscriptionMintActionResponse({
    required this.recipient,
    required this.amount,
    required this.type,
    required this.ticker,
    required this.decimals,
  });

  factory InscriptionMintActionResponse.fromJson(Map<String, dynamic> json) {
    return InscriptionMintActionResponse(
      recipient: AccountAddressResponse.fromJson(json['recipient']),
      amount: json['amount'],
      type: InscriptionTypeResponse.fromName(json['type']),
      ticker: json['ticker'],
      decimals: json['decimals'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'recipient': recipient.toJson(),
      'amount': amount,
      'type': type.value,
      'ticker': ticker,
      'decimals': decimals
    };
  }
}
