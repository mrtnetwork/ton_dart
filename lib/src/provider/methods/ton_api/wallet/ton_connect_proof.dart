import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// TonConnectProof invokes tonConnectProof operation.
///
/// AccountResponse verification and token issuance.
///
class TonApiTonConnectProof
    extends TonApiPostRequestParam<String, Map<String, dynamic>> {
  @override
  Object get body => data;

  /// Data that is expected from TON Connect
  final Map<String, dynamic> data;
  TonApiTonConnectProof({required this.data});

  @override
  String get method => TonApiMethods.tonconnectproof.url;

  @override
  String onResonse(Map<String, dynamic> json) {
    return json["token"];
  }
}
