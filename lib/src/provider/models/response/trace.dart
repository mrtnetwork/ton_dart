import 'package:ton_dart/src/serialization/serialization.dart';
import 'transaction.dart';

class TraceResponse with JsonSerialization {
  final TransactionResponse transaction;
  final List<String> interfaces;
  final List<TraceResponse> children;
  final bool? emulated;

  const TraceResponse(
      {required this.transaction,
      required this.interfaces,
      required this.children,
      this.emulated});

  factory TraceResponse.fromJson(Map<String, dynamic> json) {
    return TraceResponse(
      transaction: TransactionResponse.fromJson(json['transaction']),
      interfaces: List<String>.from(json['interfaces']),
      children: List<TraceResponse>.from(
          (json['children'] as List?)?.map((x) => TraceResponse.fromJson(x)) ??
              []),
      emulated: json['emulated'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'transaction': transaction.toJson(),
      'interfaces': interfaces,
      'children': children.map((x) => x.toJson()).toList(),
      'emulated': emulated,
    };
  }
}
