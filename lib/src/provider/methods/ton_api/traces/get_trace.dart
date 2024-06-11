import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/trace.dart';

/// GetTrace invokes getTrace operation.
///
/// Get the trace by trace ID or hash of any transaction in trace.
///
class TonApiGetTrace
    extends TonApiRequestParam<TraceResponse, Map<String, dynamic>> {
  /// trace ID or transaction hash in hex (without 0x) or base64url format
  final String traceId;
  TonApiGetTrace(this.traceId);
  @override
  String get method => TonApiMethods.gettrace.url;

  @override
  List<String> get pathParameters => [traceId];

  @override
  TraceResponse onResonse(Map<String, dynamic> json) {
    return TraceResponse.fromJson(json);
  }
}
