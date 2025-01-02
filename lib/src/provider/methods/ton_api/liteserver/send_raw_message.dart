import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// SendRawMessage invokes sendRawMessage operation.
///
/// Send raw message to blockchain.
///
class TonApiSendRawMessage
    extends TonApiPostRequest<int, Map<String, dynamic>> {
  final String rawMessage;
  TonApiSendRawMessage(this.rawMessage);
  @override
  Map<String, dynamic> get body => {'body': rawMessage};

  @override
  String get method => TonApiMethods.sendrawmessage.url;
  @override
  int onResonse(Map<String, dynamic> result) {
    return result['code'];
  }
}
