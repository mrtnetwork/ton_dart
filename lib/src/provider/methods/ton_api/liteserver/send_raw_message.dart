import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// SendRawMessage invokes sendRawMessage operation.
///
/// Send raw message to blockchain.
///
class TonApiSendRawMessage
    extends TonApiPostRequestParam<int, Map<String, dynamic>> {
  final String rawMessage;
  TonApiSendRawMessage(this.rawMessage);
  @override
  Object get body => {"body": rawMessage};

  @override
  String get method => TonApiMethods.sendrawmessage.url;
  @override
  int onResonse(Map<String, dynamic> json) {
    return json["code"];
  }
}
