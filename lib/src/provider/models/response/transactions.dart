import 'package:ton_dart/src/serialization/serialization.dart';
import 'transaction.dart';

class TransactionsResponse with JsonSerialization {
  final List<TransactionResponse> transactions;

  const TransactionsResponse({required this.transactions});

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) {
    return TransactionsResponse(
        transactions: List<TransactionResponse>.from((json['transactions']
                as List)
            .map((transaction) => TransactionResponse.fromJson(transaction))));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'transactions':
          transactions.map((transaction) => transaction.toJson()).toList()
    };
  }
}
