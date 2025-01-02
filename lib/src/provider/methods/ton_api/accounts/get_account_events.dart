import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account_events.dart';

/// GetAccountEvents invokes getAccountEvents operation.
///
/// Get events for an account. Each event is built on top of a trace which is a series of transactions
/// caused by one inbound message. TonAPI looks for known patterns inside the trace and splits the
/// trace into actions, where a single action represents a meaningful high-level operation like a
/// Jetton Transfer or an NFT Purchase. Actions are expected to be shown to users. It is advised not
/// to build any logic on top of actions because actions can be changed at any time.
///
class TonApiGetAccountEvents
    extends TonApiRequest<AccountEventsResponse, Map<String, dynamic>> {
  final String accountId;
  final String? acceptLanguage;

  /// Show only events that are initiated by this account
  /// default: false
  final bool? initiator;

  /// filter actions where requested account is not real subject (for example sender or receiver jettons)
  /// default: false
  final bool? subjectOnly;

  /// omit this parameter to get last events
  final BigInt? beforeLt;
  final int limit;

  final BigInt? startDate;
  final BigInt? endDate;
  TonApiGetAccountEvents(
      {required this.accountId,
      this.acceptLanguage,
      this.initiator,
      this.subjectOnly,
      this.beforeLt,
      this.limit = 20,
      this.startDate,
      this.endDate});

  @override
  String get method => TonApiMethods.getaccountevents.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters => {
        'initiator': initiator,
        'subject_only': subjectOnly,
        'before_lt': beforeLt,
        'limit': limit,
        'start_date': startDate,
        'end_date': endDate
      };

  @override
  Map<String, String?> get headers => {'Accept-Language': acceptLanguage};

  @override
  AccountEventsResponse onResonse(Map<String, dynamic> result) {
    return AccountEventsResponse.fromJson(result);
  }
}
