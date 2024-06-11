import 'package:ton_dart/src/serialization/serialization.dart';
import 'refund_type.dart';

class RefundResponse with JsonSerialization {
  final RefundTypeResponse type;
  final String origin;

  const RefundResponse({required this.type, required this.origin});

  factory RefundResponse.fromJson(Map<String, dynamic> json) {
    return RefundResponse(
        type: RefundTypeResponse.fromName(json['type']),
        origin: json['origin']);
  }

  @override
  Map<String, dynamic> toJson() => {'type': type.value, 'origin': origin};
}
