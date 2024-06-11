import 'package:ton_dart/src/serialization/serialization.dart';

class ApyHistoryResponse with JsonSerialization {
  final double apy;
  final int time;

  ApyHistoryResponse({
    required this.apy,
    required this.time,
  });

  factory ApyHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ApyHistoryResponse(
      apy: json['apy'],
      time: json['time'],
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'apy': apy,
      'time': time,
    };
  }
}
