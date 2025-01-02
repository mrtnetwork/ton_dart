import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account_events.dart';

/// GetAccountInscriptionsHistory invokes getAccountInscriptionsHistory operation.
///
/// Get the transfer inscriptions history for account. It's experimental API and can be dropped in the
/// future.
///
class TonApiGetAccountInscriptionsHistory
    extends TonApiRequest<AccountEventsResponse, Map<String, dynamic>> {
  final String accountId;

  final String? acceptLanguage;

  /// omit this parameter to get last events
  final BigInt? beforeLt;

  /// default: 100
  final int? limit;

  TonApiGetAccountInscriptionsHistory(
      {required this.accountId,
      this.acceptLanguage,
      this.beforeLt,
      this.limit});

  @override
  String get method => TonApiMethods.getaccountinscriptionshistory.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters =>
      {'limit': limit, 'before_lt': beforeLt};

  @override
  Map<String, String?> get headers => {'Accept-Language': acceptLanguage};

  @override
  AccountEventsResponse onResonse(Map<String, dynamic> result) {
    return AccountEventsResponse.fromJson(result);
  }
}
