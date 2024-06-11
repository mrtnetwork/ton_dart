import 'package:ton_dart/src/serialization/serialization.dart';
import 'trace_id.dart';

class TraceIDsResponse with JsonSerialization {
  final List<TraceIDResponse> traces;

  const TraceIDsResponse({required this.traces});

  factory TraceIDsResponse.fromJson(Map<String, dynamic> json) {
    return TraceIDsResponse(
        traces: (json['traces'] as List<dynamic>)
            .map((e) => TraceIDResponse.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {'traces': traces.map((e) => e.toJson()).toList()};
  }
}
