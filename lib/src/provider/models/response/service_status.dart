import 'package:ton_dart/src/serialization/serialization.dart';

class ServiceStatusResponse with JsonSerialization {
  final bool restOnline;
  final int indexingLatency;

  const ServiceStatusResponse(
      {required this.restOnline, required this.indexingLatency});

  factory ServiceStatusResponse.fromJson(Map<String, dynamic> json) {
    return ServiceStatusResponse(
      restOnline: json['rest_online'],
      indexingLatency: json['indexing_latency'],
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {'rest_online': restOnline, 'indexing_latency': indexingLatency};
  }
}
