import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/seqno.dart';

/// GetAccountSeqno invokes getAccountSeqno operation.
///
/// Get account seqno.
///
class TonApiGetAccountSeqno
    extends TonApiRequestParam<SeqnoResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiGetAccountSeqno(this.accountId);
  @override
  String get method => TonApiMethods.getaccountseqno.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  SeqnoResponse onResonse(Map<String, dynamic> json) {
    return SeqnoResponse.fromJson(json);
  }
}
