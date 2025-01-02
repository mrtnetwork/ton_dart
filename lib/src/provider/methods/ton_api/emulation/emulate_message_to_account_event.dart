import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/account_event.dart';

/// EmulateMessageToAccountEvent invokes emulateMessageToAccountEvent operation.
///
/// Emulate sending message to blockchain.
///
class TonApiEmulateMessageToAccountEvent
    extends TonApiPostRequest<AccountEventResponse, Map<String, dynamic>> {
  final String? appLanguage;
  final String accountId;
  final bool ignoreSignatureCheck;
  final String boc;
  TonApiEmulateMessageToAccountEvent(
      {required this.accountId,
      required this.ignoreSignatureCheck,
      required this.boc,
      this.appLanguage});
  @override
  Map<String, dynamic> get body => {'boc': boc};

  @override
  String get method => TonApiMethods.emulatemessagetoaccountevent.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters =>
      {'ignore_signature_check': ignoreSignatureCheck.toString()};

  @override
  Map<String, String?> get headers => {'Accept-Language': appLanguage};

  @override
  AccountEventResponse onResonse(Map<String, dynamic> result) {
    return AccountEventResponse.fromJson(result);
  }
}
