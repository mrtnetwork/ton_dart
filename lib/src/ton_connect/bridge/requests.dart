import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';
import 'package:ton_dart/src/ton_connect/bridge/details.dart';
import 'package:ton_dart/src/ton_connect/bridge/models.dart';
import 'package:ton_dart/src/ton_connect/bridge/sse_parser.dart';

/// One bridge delivery as a subscription event.
///
/// Carries the raw SSE frame plus the parsed bridge fields when `data`
/// holds bridge JSON. Garbage `data` yields `null` message fields —
/// never throws (fail-closed, same contract as `SessionCrypto.decrypt`).
class TonBridgeEvent extends BaseSubscribtionEvent<String> {
  final String sseId;
  final String? sseEvent;
  final String data;
  final String? from;
  final String? message;
  final String? traceId;

  TonBridgeEvent({
    required this.sseId,
    required this.sseEvent,
    required this.data,
    required this.from,
    required this.message,
    required this.traceId,
  });

  factory TonBridgeEvent.fromSse(TonSseEvent sse) {
    String? from;
    String? message;
    String? traceId;
    try {
      final decoded = StringUtils.toJson<dynamic>(sse.data);
      if (decoded is Map<String, dynamic>) {
        final bridge = TonBridgeMessage.fromJson(decoded);
        from = bridge.from.value;
        message = bridge.message;
        traceId = bridge.traceId;
      }
    } catch (_) {
      from = null;
      message = null;
      traceId = null;
    }
    return TonBridgeEvent(
      sseId: sse.id ?? '',
      sseEvent: sse.event,
      data: sse.data,
      from: from,
      message: message,
      traceId: traceId,
    );
  }

  factory TonBridgeEvent.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tonConnectEvent,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TonBridgeEvent(
      sseId: values.rawValueAt(0),
      sseEvent: values.rawValueAt(1),
      data: values.rawValueAt(2),
      from: values.rawValueAt(3),
      message: values.rawValueAt(4),
      traceId: values.rawValueAt(5),
    );
  }

  /// Subscription identifier: the SSE resume cursor (may be empty
  /// when the frame carries no `id:`).
  @override
  String get id => sseId;

  /// True when `data` parsed as bridge JSON.
  bool get hasMessage => message != null && from != null;

  @override
  TonSerializationIdentifiers get serializationIdentifier =>
      TonSerializationIdentifiers.tonConnectEvent;

  @override
  List<CborObject?> get serializationItems => [
    sseId.toCbor(),
    sseEvent?.toCbor(),
    data.toCbor(),
    from?.toCbor(),
    message?.toCbor(),
    traceId?.toCbor(),
  ];
}

/// `POST {bridge}/message` — relays one encrypted envelope.
///
/// Payload comes from Phase 1 [TonPostMessageParams] (already validated);
/// the plaintext is never visible here (see `SessionCrypto.encryptToBase64`
/// in `blockchain_utils`, wired in Phase 4).
class TonConnectPostMessage
    extends
        BaseServiceRequest<
          void,
          Map<String, dynamic>,
          TonConnectRequestDetails
        > {
  final TonPostMessageParams params;

  TonConnectPostMessage(this.params);

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  TonConnectRequestDetails buildRequest(int requestID) {
    final query = params.queryParameters();
    final path = Uri(path: '/message', queryParameters: query).toString();
    return TonConnectRequestDetails(
      requestID: requestID,
      path: path,
      headers: {...ServiceConst.defaultPostHeaders},
      requestMethod: requestMethod,
      responseEncoding: ServiceReponseEncoding.map,
      bodyString: StringUtils.fromJson(params.body()),
    );
  }

  @override
  void onResponse(Map<String, dynamic> result) {}
}

/// `GET {bridge}/events` subscription — one request per resume session.
///
/// `BaseServiceSubscribtionRequest<IDENTIFIER=String (own client_id),
/// SERVICERESPONSE=String (raw stream ack), EVENT=TonBridgeEvent, ...>`.
class TonConnectEventsRequest
    extends
        BaseServiceSubscribtionRequest<
          String,
          String,
          TonBridgeEvent,
          TonConnectRequestDetails
        > {
  final String clientId;
  final String? lastEventId;

  TonConnectEventsRequest({required this.clientId, this.lastEventId});

  factory TonConnectEventsRequest.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tonConnectSubscription,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TonConnectEventsRequest(
      clientId: values.rawValueAt(0),
      lastEventId: values.rawValueAt(1),
    );
  }

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  TonConnectRequestDetails buildRequest(int requestID) {
    final id = TonConnectClientId(clientId);
    final query = {
      'client_id': id.value,
      if (lastEventId != null && lastEventId!.isNotEmpty)
        'lastEventId': lastEventId!,
    };
    final path = Uri(path: '/events', queryParameters: query).toString();
    return TonConnectRequestDetails(
      requestID: requestID,
      path: path,
      headers: const {},
      requestMethod: requestMethod,
      responseEncoding: ServiceReponseEncoding.string,
    );
  }

  @override
  String onResponse(String result) => clientId;

  /// Converts raw stream input to an event. Accepts a pre-parsed
  /// [TonSseEvent] (provider path) or a raw chunk [String] (single
  /// frame); heartbeat-only input yields `null`.
  @override
  TonBridgeEvent? toEvent(String identifier, Object event) {
    if (event is TonSseEvent) {
      return TonBridgeEvent.fromSse(event);
    }
    if (event is String) {
      final frames = TonSseParser().feed(event);
      if (frames.isEmpty) return null;
      return TonBridgeEvent.fromSse(frames.first);
    }
    return null;
  }

  /// The subscription listens on our own queue: identifier is our client_id.
  @override
  String? toIdentifier(BaseServiceResponse response) => clientId;

  @override
  TonConnectRequestDetails buildUnsubscribeRequest(
    String identifier,
    int requestID,
  ) {
    return TonConnectRequestDetails(
      requestID: requestID,
      path:
          Uri(
            path: '/events',
            queryParameters: {'client_id': identifier},
          ).toString(),
      headers: const {},
      requestMethod: requestMethod,
      responseEncoding: ServiceReponseEncoding.string,
    );
  }

  @override
  TonBridgeEvent deserializeEvent(List<int> bytes) {
    return TonBridgeEvent.deserialize(bytes: bytes);
  }

  @override
  TonSerializationIdentifiers get serializationIdentifier =>
      TonSerializationIdentifiers.tonConnectSubscription;

  @override
  List<CborObject?> get serializationItems => [
    clientId.toCbor(),
    lastEventId?.toCbor(),
  ];
}
