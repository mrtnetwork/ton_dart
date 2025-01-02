import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/event.dart';

/// GetEvent invokes getEvent operation.
///
/// Get an event either by event ID or a hash of any transaction in a trace. An event is built on top
/// of a trace which is a series of transactions caused by one inbound message. TonAPI looks for known
/// patterns inside the trace and splits the trace into actions, where a single action represents a
/// meaningful high-level operation like a Jetton Transfer or an NFT Purchase. Actions are expected to
/// be shown to users. It is advised not to build any logic on top of actions because actions can be
/// changed at any time.
///
class TonApiGetEvent
    extends TonApiRequest<EventResponse, Map<String, dynamic>> {
  /// event ID or transaction hash in hex (without 0x) or base64url format
  final String eventId;
  final String? acceptLanguage;
  TonApiGetEvent({required this.eventId, this.acceptLanguage});
  @override
  String get method => TonApiMethods.getevent.url;

  @override
  List<String> get pathParameters => [eventId];

  @override
  Map<String, String?> get headers => {'Accept-Language': acceptLanguage};

  @override
  EventResponse onResonse(Map<String, dynamic> result) {
    return EventResponse.fromJson(result);
  }
}
