import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account_event.dart';

/// GetAccountEvent invokes getAccountEvent operation.
///
/// Get event for an account by event_id.
///
class TonApiGetAccountEvent
    extends TonApiRequestParam<AccountEventResponse, Map<String, dynamic>> {
  final String accountId;

  /// event ID or transaction hash in hex (without 0x) or base64url format
  final String eventId;
  final String? acceptLanguage;

  /// filter actions where requested account is not real subject (for example sender or receiver jettons)
  /// default: false
  final bool? subjectOnly;
  TonApiGetAccountEvent(
      {required this.accountId,
      required this.eventId,
      this.acceptLanguage,
      this.subjectOnly});
  @override
  String get method => TonApiMethods.getaccountevent.url;

  @override
  List<String> get pathParameters => [accountId, eventId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"subject_only": subjectOnly?.toString()};

  @override
  Map<String, String?> get header => {"Accept-Language": acceptLanguage};

  @override
  AccountEventResponse onResonse(Map<String, dynamic> json) {
    return AccountEventResponse.fromJson(json);
  }
}
