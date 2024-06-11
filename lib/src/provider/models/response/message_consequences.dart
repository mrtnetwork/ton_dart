import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_event.dart';
import 'risk.dart';
import 'trace.dart';

class MessageConsequencesResponse with JsonSerialization {
  final TraceResponse trace;
  final RiskResponse risk;
  final AccountEventResponse event;

  const MessageConsequencesResponse({
    required this.trace,
    required this.risk,
    required this.event,
  });

  factory MessageConsequencesResponse.fromJson(Map<String, dynamic> json) {
    return MessageConsequencesResponse(
      trace: TraceResponse.fromJson(json['trace']),
      risk: RiskResponse.fromJson(json['risk']),
      event: AccountEventResponse.fromJson(json['event']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'trace': trace.toJson(),
      'risk': risk.toJson(),
      'event': event.toJson()
    };
  }
}
