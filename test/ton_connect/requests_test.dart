import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/ton_connect/bridge/details.dart';
import 'package:ton_dart/src/ton_connect/bridge/models.dart';
import 'package:ton_dart/src/ton_connect/bridge/requests.dart';
import 'package:ton_dart/src/ton_connect/bridge/sse_parser.dart';
import '../utils.dart';

void requestsTest() {
  const aliceHex =
      '69696ee955b62b73cd62bda875fc73d68219e0036b7a0b37c5c7a8e9f8a1b2c3';
  final payload = StringUtils.decode(List<int>.filled(40, 7), encoding: StringEncoding.base64);

  group('TonConnectRequestDetails', () {
    test('encodeUrl joins bridge base + path', () {
      final request = TonConnectPostMessage(
        TonPostMessageParams(receiver: aliceHex, message: payload),
      );
      final details = request.buildRequest(0);
      final uri = details.encodeUrl('https://bridge.tonapi.io/bridge/');
      expect(uri.toString().startsWith('https://bridge.tonapi.io/bridge/message'), isTrue);
      expect(uri.queryParameters['client_id'], aliceHex);
      expect(uri.queryParameters['ttl'], '300');
      expect(details.encodeBody(), isNotNull);
    });

    test('cbor round-trip preserves path + body', () {
      final request = TonConnectPostMessage(
        TonPostMessageParams(receiver: aliceHex, message: payload, topic: 'sendTransaction'),
      );
      final details = request.buildRequest(7);
      final back = TonConnectRequestDetails.deserialize(
        bytes: details.toCbor().encode(),
      );
      expect(back.path, details.path);
      expect(back.encodeBody(), details.encodeBody());
      expect(back.requestID, 7);
      expect(back.path, contains('topic=sendTransaction'));
    });
  });

  group('TonConnectPostMessage', () {
    test('golden path + body', () {
      final request = TonConnectPostMessage(
        TonPostMessageParams(receiver: aliceHex, message: payload),
      );
      final details = request.buildRequest(0);
      expect(details.path, contains('/message?'));
      expect(details.path, contains('client_id=$aliceHex'));
      expect(details.bodyString, '{"message":"$payload"}');
    });
  });

  group('TonConnectEventsRequest', () {
    test('path without cursor omits lastEventId', () {
      final request = TonConnectEventsRequest(clientId: aliceHex);
      final details = request.buildRequest(0);
      expect(details.path, contains('/events?'));
      expect(details.path, contains('client_id=$aliceHex'));
      expect((details.path ?? '').contains('lastEventId'), isFalse);
    });

    test('path with cursor includes lastEventId', () {
      final request = TonConnectEventsRequest(clientId: aliceHex, lastEventId: '42');
      final details = request.buildRequest(0);
      expect(details.path, contains('lastEventId=42'));
    });

    test('toEvent parses bridge json, heartbeat gives null', () {
      final request = TonConnectEventsRequest(clientId: aliceHex);
      expect(request.toEvent(aliceHex, ': heartbeat\n\n'), isNull);
      final sse = TonSseEvent(
        id: '9',
        event: 'message',
        data: StringUtils.fromJson({'from': aliceHex, 'message': payload}),
      );
      final event = request.toEvent(aliceHex, sse);
      expect(event, isNotNull);
      expect(event!.from, aliceHex);
      expect(event.message, payload);
      expect(event.hasMessage, isTrue);
      expect(event.id, '9');
    });

    test('toEvent with garbage data keeps event, drops message', () {
      final request = TonConnectEventsRequest(clientId: aliceHex);
      final event = request.toEvent(
        aliceHex,
        const TonSseEvent(id: '1', event: 'message', data: 'not-json'),
      );
      expect(event, isNotNull);
      expect(event!.hasMessage, isFalse);
      expect(event.data, 'not-json');
    });

    test('event cbor round-trip', () {
      final sse = TonSseEvent(id: '3', event: 'message', data: 'x');
      final event = TonBridgeEvent.fromSse(sse);
      final back = TonBridgeEvent.deserialize(bytes: event.toCbor().encode());
      expect(back.id, '3');
      expect(back.data, 'x');
      expect(back.hasMessage, isFalse);
    });

    test('subscription cbor round-trip', () {
      final request = TonConnectEventsRequest(clientId: aliceHex, lastEventId: '5');
      final back = TonConnectEventsRequest.deserialize(
        bytes: request.toCbor().encode(),
      );
      expect(back.clientId, aliceHex);
      expect(back.lastEventId, '5');
    });
  });
}

void main() {
  TonTestApi.runTest(requestsTest, 'Requests');
}
