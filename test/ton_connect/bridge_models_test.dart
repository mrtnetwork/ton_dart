import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/ton_connect/bridge/models.dart';
import '../utils.dart';

void bridgeModelsTest() {
  const aliceHex =
      '69696ee955b62b73cd62bda875fc73d68219e0036b7a0b37c5c7a8e9f8a1b2c3';
  final payload = StringUtils.decode(
    List<int>.filled(40, 7),
    encoding: StringEncoding.base64,
  );

  group('TonConnectClientId', () {
    test('accepts 64 hex, normalizes to lowercase', () {
      final id = TonConnectClientId(aliceHex.toUpperCase());
      expect(id.value, aliceHex);
      expect(id.toBytes().length, 32);
    });
    test('rejects bad length and non-hex', () {
      expect(() => TonConnectClientId('abc'), throwsA(isA<BuError>()));
      expect(
        () => TonConnectClientId(List.filled(64, 'z').join()),
        throwsA(isA<BuError>()),
      );
      expect(() => TonConnectClientId(null), throwsA(isA<BuError>()));
    });
  });

  group('TonBridgeMessage', () {
    test('round-trips json with trace_id', () {
      final msg = TonBridgeMessage(
        from: aliceHex,
        message: payload,
        traceId: 't-1',
      );
      final back = TonBridgeMessage.fromJson(msg.toJson());
      expect(back.from.value, aliceHex);
      expect(back.message, payload);
      expect(back.traceId, 't-1');
      expect(back.decoded().length, 40);
    });
    test('drops empty trace_id, rejects truncated + bad base64', () {
      final msg = TonBridgeMessage(
        from: aliceHex,
        message: payload,
        traceId: '',
      );
      expect(msg.traceId, isNull);
      expect(
        () => TonBridgeMessage(
          from: aliceHex,
          message: StringUtils.decode([
            1,
            2,
            3,
          ], encoding: StringEncoding.base64),
        ),
        throwsA(isA<BuError>()),
      );
      expect(
        () => TonBridgeMessage(from: aliceHex, message: '!!!'),
        throwsA(isA<BuError>()),
      );
      expect(
        () => TonBridgeMessage.fromJson({'from': aliceHex}),
        throwsA(isA<BuError>()),
      );
    });
  });

  group('TonPostMessageParams', () {
    test('defaults ttl=300, builds body + query', () {
      final p = TonPostMessageParams(receiver: aliceHex, message: payload);
      expect(p.ttl, 300);
      expect(p.body(), {'message': payload});
      expect(p.queryParameters()['client_id'], aliceHex);
      expect(p.queryParameters()['ttl'], '300');
    });
    test('rejects ttl out of range', () {
      expect(
        () =>
            TonPostMessageParams(receiver: aliceHex, message: payload, ttl: 0),
        throwsA(isA<BuError>()),
      );
      expect(
        () => TonPostMessageParams(
          receiver: aliceHex,
          message: payload,
          ttl: 301,
        ),
        throwsA(isA<BuError>()),
      );
    });
  });

  group('TonBridgeConfig', () {
    test('normalizes trailing slash, builds urls', () {
      final cfg = TonBridgeConfig(
        bridgeUrl: 'https://bridge.tonapi.io/bridge/',
      );
      expect(cfg.bridgeUrl, 'https://bridge.tonapi.io/bridge');
      final p = TonPostMessageParams(receiver: aliceHex, message: payload);
      final msgUri = cfg.messageUri(p);
      expect(msgUri.path, endsWith('/message'));
      expect(msgUri.queryParameters['client_id'], aliceHex);
      final evUri = cfg.eventsUri(clientId: aliceHex, lastEventId: '42');
      expect(evUri.path, endsWith('/events'));
      expect(evUri.queryParameters['lastEventId'], '42');
    });
    test('rejects bad urls', () {
      expect(() => TonBridgeConfig(bridgeUrl: ''), throwsA(isA<BuError>()));
      expect(
        () => TonBridgeConfig(bridgeUrl: 'not-a-url'),
        throwsA(isA<BuError>()),
      );
    });
  });
}

void main() {
  TonTestApi.runTest(bridgeModelsTest, 'Bridge Models');
}
