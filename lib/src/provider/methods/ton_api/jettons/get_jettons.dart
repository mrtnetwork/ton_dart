import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/jettons.dart';

/// GetJettons invokes getJettons operation.
///
/// Get a list of all indexed jetton masters in the blockchain.
///
class TonApiGetJettons
    extends TonApiRequestParam<JettonsResponse, Map<String, dynamic>> {
  /// Default: 1000
  final int? limit;

  /// Default: 0
  final int? offset;
  TonApiGetJettons({this.limit, this.offset});
  @override
  String get method => TonApiMethods.getjettons.url;

  @override
  Map<String, dynamic> get queryParameters =>
      {"offset": offset, "limit": limit};
  @override
  JettonsResponse onResonse(Map<String, dynamic> json) {
    return JettonsResponse.fromJson(json);
  }
}
