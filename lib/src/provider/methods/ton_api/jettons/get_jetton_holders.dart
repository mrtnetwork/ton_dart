import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/jetton_holders.dart';

/// GetJettonHolders invokes getJettonHolders operation.
///
/// Get jetton's holders.
///
class TonApiGetJettonHolders
    extends TonApiRequestParam<JettonHoldersResponse, Map<String, dynamic>> {
  final String accountId;

  /// Default: 1000
  final int? limit;

  /// Default: 0
  final int? offset;
  TonApiGetJettonHolders({required this.accountId, this.limit, this.offset});
  @override
  String get method => TonApiMethods.getjettonholders.url;
  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"limit": limit, "offset": offset};

  @override
  JettonHoldersResponse onResonse(Map<String, dynamic> json) {
    return JettonHoldersResponse.fromJson(json);
  }
}
