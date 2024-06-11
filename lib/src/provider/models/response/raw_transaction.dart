import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_raw.dart';

class RawTransactionResponse with JsonSerialization {
  final List<BlockRawResponse> ids;
  final String transactions;
  const RawTransactionResponse({required this.ids, required this.transactions});
  factory RawTransactionResponse.fromJson(Map<String, dynamic> json) {
    return RawTransactionResponse(
        ids: (json["ids"] as List)
            .map((e) => BlockRawResponse.fromJson(e))
            .toList(),
        transactions: json["transactions"]);
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      "transactions": transactions,
      "ids": ids.map((e) => e.toJson()).toList()
    };
  }
}
