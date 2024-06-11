import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/trace_ids.dart';

/// GetAccountTraces invokes getAccountTraces operation.
///
/// Get traces for account.
///
class TonApiGetAccountTraces
    extends TonApiRequestParam<TraceIDsResponse, Map<String, dynamic>> {
  final String accountId;

  /// Default: 100
  final int? limit;

  /// omit this parameter to get last events
  final BigInt? beforeLt;
  TonApiGetAccountTraces({required this.accountId, this.limit, this.beforeLt});
  @override
  String get method => TonApiMethods.getaccounttraces.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"limit": limit, "before_lt": beforeLt};

  @override
  TraceIDsResponse onResonse(Map<String, dynamic> json) {
    return TraceIDsResponse.fromJson(json);
  }
}
