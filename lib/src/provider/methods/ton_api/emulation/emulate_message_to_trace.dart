import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/trace.dart';

/// EmulateMessageToTrace invokes emulateMessageToTrace operation.
///
/// Emulate sending message to blockchain.
///
class TonApiEmulateMessageToTrace
    extends TonApiPostRequestParam<TraceResponse, Map<String, dynamic>> {
  final String boc;
  final bool ignoreSignatureCheck;
  TonApiEmulateMessageToTrace(
      {required this.boc, required this.ignoreSignatureCheck});
  @override
  Object? get body => {"boc": boc};

  @override
  String get method => TonApiMethods.emulatemessagetotrace.url;

  @override
  Map<String, dynamic> get queryParameters =>
      {"ignore_signature_check": ignoreSignatureCheck.toString()};

  @override
  TraceResponse onResonse(Map<String, dynamic> json) {
    return TraceResponse.fromJson(json);
  }
}
