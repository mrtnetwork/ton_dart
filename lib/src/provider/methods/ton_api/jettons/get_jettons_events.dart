import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/event.dart';

/// GetJettonsEvents invokes getJettonsEvents operation.
///
/// Get only jetton transfers in the event.
///
class TonApiGetJettonsEvents
    extends TonApiRequestParam<EventResponse, Map<String, dynamic>> {
  /// event ID or transaction hash in hex (without 0x) or base64url format
  final String eventId;
  final String? acceptLanguage;
  TonApiGetJettonsEvents({required this.eventId, this.acceptLanguage});
  @override
  String get method => TonApiMethods.getjettonsevents.url;

  @override
  List<String> get pathParameters => [eventId];

  @override
  Map<String, String?> get header => {"Accept-Language": acceptLanguage};

  @override
  EventResponse onResonse(Map<String, dynamic> json) {
    return EventResponse.fromJson(json);
  }
}
