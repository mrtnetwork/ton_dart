import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account_events.dart';

/// GetAccountJettonHistoryByID invokes getAccountJettonHistoryByID operation.
///
/// Get the transfer jetton history for account and jetton.
///
class TonApiGetAccountJettonHistoryByID
    extends TonApiRequestParam<AccountEventsResponse, Map<String, dynamic>> {
  final String accountId;
  final String jettonId;
  final String? acceptLanguage;

  /// omit this parameter to get last events
  final BigInt? beforeLt;
  final int limit;

  final BigInt? startDate;
  final BigInt? endDate;
  TonApiGetAccountJettonHistoryByID(
      {required this.accountId,
      required this.jettonId,
      this.acceptLanguage,
      this.beforeLt,
      this.limit = 100,
      this.startDate,
      this.endDate});
  @override
  String get method => TonApiMethods.getaccountjettonhistorybyid.url;

  @override
  List<String> get pathParameters => [accountId, jettonId];

  @override
  Map<String, dynamic> get queryParameters => {
        "before_lt": beforeLt,
        "limit": limit,
        "start_date": startDate,
        "end_date": endDate
      };

  @override
  Map<String, String?> get header => {"Accept-Language": acceptLanguage};

  @override
  AccountEventsResponse onResonse(Map<String, dynamic> json) {
    return AccountEventsResponse.fromJson(json);
  }
}
