import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'account_address.dart';
import 'action.dart';

/// An event is built on top of a trace which is a series of transactions caused by one inbound
/// message. TonAPI looks for known patterns inside the trace and splits the trace into actions, where
/// a single action represents a meaningful high-level operation like a Jetton Transfer or an NFT
/// Purchase. Actions are expected to be shown to users. It is advised not to build any logic on top
/// of actions because actions can be changed at any time.
class AccountEventResponse with JsonSerialization {
  final String eventID;
  final AccountAddressResponse account;
  final BigInt timestamp;
  final List<ActionResponse> actions;
  final bool isScam;
  final BigInt lt;
  final bool inProgress;
  final BigInt extra;

  const AccountEventResponse({
    required this.eventID,
    required this.account,
    required this.timestamp,
    required this.actions,
    required this.isScam,
    required this.lt,
    required this.inProgress,
    required this.extra,
  });

  factory AccountEventResponse.fromJson(Map<String, dynamic> json) {
    return AccountEventResponse(
      eventID: json['event_id'] as String,
      account: AccountAddressResponse.fromJson(json['account']),
      timestamp: BigintUtils.parse(json['timestamp']),
      actions: (json['actions'] as List<dynamic>)
          .map((e) => ActionResponse.fromJson(e))
          .toList(),
      isScam: json['is_scam'],
      lt: BigintUtils.parse(json['lt']),
      inProgress: json['in_progress'],
      extra: BigintUtils.parse(json['extra']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'event_id': eventID,
      'account': account.toJson(),
      'timestamp': timestamp.toString(),
      'is_scam': isScam,
      'lt': lt.toString(),
      'in_progress': inProgress,
      'extra': extra.toString(),
      'actions': actions.map((e) => e.toJson()).toList()
    };
  }
}
