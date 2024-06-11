import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'account_event.dart';

class AccountEventsResponse with JsonSerialization {
  final List<AccountEventResponse> events;
  final BigInt nextFrom;

  AccountEventsResponse({
    required this.events,
    required this.nextFrom,
  });

  factory AccountEventsResponse.fromJson(Map<String, dynamic> json) {
    return AccountEventsResponse(
      events: (json['events'] as List<dynamic>)
          .map((e) => AccountEventResponse.fromJson(e))
          .toList(),
      nextFrom: BigintUtils.parse(json['next_from']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'next_from': nextFrom.toString(),
      'events': events.map((e) => e.toJson()).toList()
    };
  }
}
