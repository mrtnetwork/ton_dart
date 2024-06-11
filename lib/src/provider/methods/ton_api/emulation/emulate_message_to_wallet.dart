import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/emulate_message_to_wallet.dart';
import 'package:ton_dart/src/provider/models/response/message_consequences.dart';

/// EmulateMessageToWallet invokes emulateMessageToWallet operation.
///
/// Emulate sending message to blockchain.
///
class TonApiEmulateMessageToWallet extends TonApiPostRequestParam<
    MessageConsequencesResponse, Map<String, dynamic>> {
  final EmulateMessageToWalletReqResponse request;
  final String? acceptLanguage;
  TonApiEmulateMessageToWallet({required this.request, this.acceptLanguage});
  @override
  Object get body => request.toJson();

  @override
  String get method => TonApiMethods.emulatemessagetowallet.url;

  @override
  Map<String, String?> get header => {"Accept-Language": acceptLanguage};
  @override
  MessageConsequencesResponse onResonse(Map<String, dynamic> json) {
    return MessageConsequencesResponse.fromJson(json);
  }
}
