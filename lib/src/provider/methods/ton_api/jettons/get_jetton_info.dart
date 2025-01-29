import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/jetton_info.dart';

/// GetJettonInfo invokes getJettonInfo operation.
///
/// Get jetton metadata by jetton master address.
///
class TonApiGetJettonInfo
    extends TonApiRequest<JettonInfoResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiGetJettonInfo(this.accountId);
  @override
  String get method => TonApiMethods.getjettoninfo.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  JettonInfoResponse onResonse(Map<String, dynamic> result) {
    return JettonInfoResponse.fromJson(result);
  }
}
