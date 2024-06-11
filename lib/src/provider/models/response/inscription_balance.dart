import 'package:ton_dart/src/serialization/serialization.dart';
import 'incription_balance_type.dart';

class InscriptionBalanceResponse with JsonSerialization {
  final InscriptionTypeResponse type;
  final String ticker;
  final String balance;
  final int decimals;

  const InscriptionBalanceResponse({
    required this.type,
    required this.ticker,
    required this.balance,
    required this.decimals,
  });

  factory InscriptionBalanceResponse.fromJson(Map<String, dynamic> json) {
    return InscriptionBalanceResponse(
        type: InscriptionTypeResponse.fromName(json['type']),
        ticker: json['ticker'],
        balance: json['balance'],
        decimals: json['decimals']);
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.value,
      'ticker': ticker,
      'balance': balance,
      'decimals': decimals
    };
  }
}
