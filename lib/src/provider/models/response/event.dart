import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'action.dart';
import 'value_flow.dart';

class EventResponse with JsonSerialization {
  final String eventID;
  final BigInt timestamp;
  final List<ActionResponse> actions;
  final List<ValueFlowResponse> valueFlow;
  final bool isScam;
  final BigInt lt;
  final bool inProgress;

  const EventResponse(
      {required this.eventID,
      required this.timestamp,
      required this.actions,
      required this.valueFlow,
      required this.isScam,
      required this.lt,
      required this.inProgress});

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      eventID: json['event_id'],
      timestamp: BigintUtils.parse(json['timestamp']),
      actions: List<ActionResponse>.from(
          (json['actions'] as List).map((x) => ActionResponse.fromJson(x))),
      valueFlow: (json['value_flow'] as List?)
              ?.map((e) => ValueFlowResponse.fromJson(e))
              .toList() ??
          [],
      isScam: json['is_scam'],
      lt: BigintUtils.parse(json['lt']),
      inProgress: json['in_progress'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'event_id': eventID,
      'timestamp': timestamp.toString(),
      'actions': actions.map((x) => x.toJson()).toList(),
      'value_flow': valueFlow.map((x) => x.toJson()).toList(),
      'is_scam': isScam,
      'lt': lt.toString(),
      'in_progress': inProgress,
    };
  }
}
