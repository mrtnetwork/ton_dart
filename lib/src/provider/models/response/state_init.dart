import 'package:ton_dart/src/serialization/serialization.dart';

class StateInitResponse with JsonSerialization {
  final String boc;

  const StateInitResponse({required this.boc});

  factory StateInitResponse.fromJson(Map<String, dynamic> json) {
    return StateInitResponse(boc: json['boc']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'boc': boc};
  }
}
