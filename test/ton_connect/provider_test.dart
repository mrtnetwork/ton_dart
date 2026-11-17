import 'dart:async';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/ton_connect/bridge/details.dart';
import 'package:ton_dart/src/ton_connect/bridge/models.dart';
import 'package:ton_dart/src/ton_connect/bridge/provider.dart';
import 'package:ton_dart/src/ton_connect/bridge/requests.dart';
import 'package:ton_dart/src/ton_connect/bridge/sse_parser.dart';
import '../utils.dart';


/// Fake wallet transport: captures requests, serves canned responses.
/// Excercises the real request/response paths (no network).
class FakeBridgeService
    implements IServiceProvider<TonConnectRequestDetails, BaseGRPCServiceRequestParams> {
  final List<TonConnectRequestDetails> requests = [];
  BaseServiceResponse Function(TonConnectRequestDetails params)? onRequest;

  int subscribeFailures = 0;
  String subscribeChunk = '';

  @override
  Future<BaseServiceResponse> doRequest(
    TonConnectRequestDetails params, {
    Duration? timeout,
  }) async {
    requests.add(params);
    final handler = onRequest;
    if (handler != null) return handler(params);
    return ServiceSuccessRespose(
      statusCode: 200,
      response: <String, dynamic>{},
      encoding: ServiceReponseEncoding.map,
    );
  }

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required TonConnectRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent,
      TonConnectRequestDetails
    >
    request,
    Duration? timeout,
  }) async {
    requests.add(params);
    if (subscribeFailures > 0) {
      subscribeFailures--;
      return DefaultServiceSubscribtionResponse(
        response: ServiceErrorResponse(
          statusCode: 429,
          error: 'too many requests',
          validate: true,
          jsonError: const {'error': 'rate limited'},
        ),
        stream: Stream<BaseSubscribtionEvent>.empty(),
      );
    }
    final sub = request as TonConnectEventsRequest;
    final frames = TonSseParser().feed(subscribeChunk);
    final events = frames
        .map((f) => sub.toEvent(sub.clientId, f))
        .whereType<TonBridgeEvent>()
        .toList();
    return DefaultServiceSubscribtionResponse(
      response: const ServiceSuccessRespose(
        statusCode: 200,
        response: '',
        encoding: ServiceReponseEncoding.string,
      ),
      stream: Stream<BaseSubscribtionEvent>.fromIterable(events),
    );
  }

  @override
  Future<List<int>> doGrpcRequest(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError('gRPC not supported by this service.');
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError('gRPC not supported by this service.');
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw UnsupportedError('gRPC not supported by this service.');
  }
}

void providerTest() {

  const aliceHex =
      '69696ee955b62b73cd62bda875fc73d68219e0036b7a0b37c5c7a8e9f8a1b2c3';
  final payload = StringUtils.decode(List<int>.filled(40, 7), encoding: StringEncoding.base64);

  TonConnectBridgeProvider<FakeBridgeService> makeProvider(
    FakeBridgeService service,
  ) {
    return TonConnectBridgeProvider(
      service: service,
      config: TonBridgeConfig(bridgeUrl: 'https://bridge.tonapi.io/bridge'),
      maxRetries: 3,
      retryDelay: const Duration(milliseconds: 1),
    );
  }

  group('TonConnectBridgeProvider POST', () {
    test('sendMessage captures golden path + body', () async {
      final service = FakeBridgeService();
      final provider = makeProvider(service);
      await provider.sendMessage(
        TonConnectPostMessage(
          TonPostMessageParams(
            receiver: aliceHex,
            message: payload,
            topic: 'sendTransaction',
          ),
        ),
      );
      expect(service.requests.length, 1);
      final captured = service.requests.single;
      expect(captured.path, contains('/message?'));
      expect(captured.path, contains('client_id=$aliceHex'));
      expect(captured.path, contains('topic=sendTransaction'));
      expect(captured.bodyString, '{"message":"$payload"}');
    });

    test('bridge 400 surfaces as RPCError', () async {
      final service = FakeBridgeService();
      service.onRequest = (_) => ServiceErrorResponse(
        statusCode: 400,
        error: 'ttl too high',
        validate: true,
        jsonError: const {'error': 'ttl too high'},
      );
      final provider = makeProvider(service);
      await expectLater(
        () => provider.sendMessage(
          TonConnectPostMessage(
            TonPostMessageParams(receiver: aliceHex, message: payload),
          ),
        ),
        throwsA(isA<RPCError>()),
      );
    });
  });

  group('TonConnectBridgeProvider sendEncrypted', () {
    test('round-trips through SessionCrypto framing', () async {
      final service = FakeBridgeService();
      final provider = makeProvider(service);
      final wallet = SessionCrypto.generate(
        secretKey: List<int>.generate(32, (i) => i + 1),
      );
      final dapp = SessionCrypto.generate(
        secretKey: List<int>.generate(32, (i) => 0xa0 + i),
      );
      const message = '{"method":"sendTransaction","id":"1"}';
      await provider.sendEncrypted(
        crypto: wallet,
        peerHex: dapp.sessionId,
        plaintextJson: message,
        nonce: List<int>.filled(24, 9),
      );
      expect(service.requests.length, 1);
      final body = StringUtils.toJson<dynamic>(service.requests.single.bodyString!);
      final sealed = (body as Map)['message'] as String;
      final raw = StringUtils.encode(sealed, encoding: StringEncoding.base64);
      expect(raw.length, 24 + 16 + message.length);
      final opened = dapp.decryptFromBase64(
        wallet.publicKey,
        sealed,
      );
      expect(opened, message);
    });
  });

  group('TonConnectBridgeProvider subscribe', () {
    String chunk() {
      final m1 = StringUtils.fromJson({'from': aliceHex, 'message': payload});
      final m2 = StringUtils.fromJson({'from': aliceHex, 'message': payload});
      return 'id: 1\nevent: message\ndata: $m1\n\nid: 2\nevent: message\ndata: $m2\n\n';
    }

    test('emits parsed events with identifier', () async {
      final service = FakeBridgeService()..subscribeChunk = chunk();
      final provider = makeProvider(service);
      final sub = await provider.requestSubscribtion(
        TonConnectEventsRequest(clientId: aliceHex),
      );
      expect(sub.identifier, aliceHex);
      final events = await sub.stream.toList();
      expect(events.length, 2);
      expect(events[0].from, aliceHex);
      expect(events[0].message, payload);
      expect(events[0].hasMessage, isTrue);
      expect(events[0].id, '1');
    });

    test('retries 429 with same lastEventId then succeeds', () async {
      final service = FakeBridgeService()
        ..subscribeFailures = 2
        ..subscribeChunk = chunk();
      final provider = makeProvider(service);
      final sub = await provider.requestSubscribtion(
        TonConnectEventsRequest(clientId: aliceHex, lastEventId: '42'),
      );
      final events = await sub.stream.toList();
      expect(events.length, 2);
      expect(service.requests.length, 3);
      for (final r in service.requests) {
        expect(r.path, contains('lastEventId=42'));
      }
    });

    test('gives up after maxRetries with RPCError 429', () async {
      final service = FakeBridgeService()..subscribeFailures = 9;
      final provider = makeProvider(service);
      await expectLater(
        () => provider.requestSubscribtion(
          TonConnectEventsRequest(clientId: aliceHex),
        ),
        throwsA(
          isA<RPCError>().having((e) => e.statusCode, 'statusCode', 429),
        ),
      );
      expect(service.requests.length, 4);
    });
  });
}

void main() {
  TonTestApi.runTest(providerTest, 'Provider');
}
