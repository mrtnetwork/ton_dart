import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class TraceIDResponse with JsonSerialization {
  final String id;
  final BigInt utime;

  const TraceIDResponse({required this.id, required this.utime});

  factory TraceIDResponse.fromJson(Map<String, dynamic> json) {
    return TraceIDResponse(
        id: json['id'] as String, utime: BigintUtils.parse(json['utime']));
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'utime': utime.toString()};
  }
}
