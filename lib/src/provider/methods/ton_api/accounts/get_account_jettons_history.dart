import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account_events.dart';

/// GetAccountJettonsHistory invokes getAccountJettonsHistory operation.
///
/// Get the transfer jettons history for account.
///
class TonApiGetAccountJettonsHistory
    extends TonApiRequestParam<AccountEventsResponse, Map<String, dynamic>> {
  final String accountId;

  final String? acceptLanguage;

  /// omit this parameter to get last events
  final BigInt? beforeLt;
  final int limit;

  /// 1668436763
  final BigInt? startDate;

  /// 1668436763
  final BigInt? endDate;
  TonApiGetAccountJettonsHistory(
      {required this.accountId,
      this.acceptLanguage,
      this.beforeLt,
      this.limit = 100,
      this.startDate,
      this.endDate});
  @override
  String get method => TonApiMethods.getaccountjettonshistory.url;

  @override
  List<String> get pathParameters => [accountId];
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
