import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/event.dart';

/// EmulateMessageToEvent invokes emulateMessageToEvent operation.
///
/// Emulate sending message to blockchain.
///
class TonApiEmulateMessageToEvent
    extends TonApiPostRequest<EventResponse, Map<String, dynamic>> {
  /// Default value : en
  final String? acceptLanguage;
  final bool ignoreSignatureCheck;
  final String boc;
  TonApiEmulateMessageToEvent(
      {required this.boc,
      required this.ignoreSignatureCheck,
      this.acceptLanguage});
  @override
  Map<String, dynamic> get body => {'boc': boc};

  @override
  String get method => TonApiMethods.emulatemessagetoevent.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, dynamic> get queryParameters =>
      {'ignore_signature_check': ignoreSignatureCheck.toString()};

  @override
  Map<String, String?> get headers => {'Accept-Language': acceptLanguage};
  @override
  EventResponse onResonse(Map<String, dynamic> result) {
    return EventResponse.fromJson(result);
  }
}
