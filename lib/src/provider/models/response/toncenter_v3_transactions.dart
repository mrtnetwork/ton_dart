import 'package:blockchain_utils/blockchain_utils.dart';

class TonCenterV3GetTransactionsResponse {
  final List<Map<String, dynamic>> transactions;
  final Map<String, dynamic> addressBook;
  TonCenterV3GetTransactionsResponse(
      {required List<Map<String, dynamic>> transactions,
      required Map<String, dynamic> addressBook})
      : transactions = transactions.immutable,
        addressBook = addressBook.immutable;
  factory TonCenterV3GetTransactionsResponse.fromJson(
      Map<String, dynamic> json) {
    return TonCenterV3GetTransactionsResponse(
        transactions:
            (json["transactions"] as List).cast<Map<String, dynamic>>(),
        addressBook: json["address_book"]);
  }
}

class TonCenterTracesResponse {
  final List<Map<String, dynamic>> traces;
  final Map<String, dynamic> metadata;
  final Map<String, dynamic> addressBook;
  TonCenterTracesResponse(
      {required List<Map<String, dynamic>> traces,
      required Map<String, dynamic> addressBook,
      required Map<String, dynamic> metadata})
      : traces = traces.immutable,
        addressBook = addressBook.immutable,
        metadata = metadata.immutable;
  factory TonCenterTracesResponse.fromJson(Map<String, dynamic> json) {
    return TonCenterTracesResponse(
        traces: (json["traces"] as List).cast<Map<String, dynamic>>(),
        addressBook: json["address_book"],
        metadata: json["metadata"]);
  }
}
