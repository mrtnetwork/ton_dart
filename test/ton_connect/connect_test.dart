import 'package:test/test.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/ton_connect/connect/link.dart';
import 'package:ton_dart/src/ton_connect/connect/models.dart';
import '../utils.dart';

void connectTest() {
  const aliceHex =
      '69696ee955b62b73cd62bda875fc73d68219e0036b7a0b37c5c7a8e9f8a1b2c3';

  TonConnectRequest sampleRequest() {
    return TonConnectRequest(
      manifestUrl: 'https://example.com/tonconnect-manifest.json',
      items: [
        TonConnectItem(name: 'ton_addr'),
        TonConnectItem(name: 'ton_proof', payload: 'server-nonce-1'),
      ],
    );
  }

  group('TonConnectLink', () {
    test('build -> parse round-trip (tonconnect scheme)', () {
      final link = TonConnectLink.build(
        dappId: aliceHex,
        request: sampleRequest(),
        ret: 'back',
      );
      expect(link.startsWith('tonconnect://'), isTrue);
      final parsed = TonConnectLink.parse(link);
      expect(parsed.version, 2);
      expect(parsed.dappId.value, aliceHex);
      expect(parsed.request.manifestUrl, sampleRequest().manifestUrl);
      expect(parsed.request.items.length, 2);
      expect(parsed.request.items[1].payload, 'server-nonce-1');
      expect(parsed.ret, 'back');
    });

    test('parses universal https link', () {
      final link = TonConnectLink.build(
        scheme: 'https',
        host: 'wallet.example.com',
        dappId: aliceHex,
        request: sampleRequest(),
      );
      final parsed = TonConnectLink.parse(link);
      expect(parsed.dappId.value, aliceHex);
      expect(parsed.ret, isNull);
    });

    test('rejects bad version, id and r', () {
      final good = TonConnectLink.build(
        dappId: aliceHex,
        request: sampleRequest(),
      );
      expect(
        () => TonConnectLink.parse(good.replaceFirst('v=2', 'v=1')),
        throwsA(isA<BuError>()),
      );
      expect(
        () => TonConnectLink.parse('tonconnect://connect?v=2&id=abc&r=e30%3D'),
        throwsA(isA<BuError>()),
      );
      expect(
        () => TonConnectLink.parse(
          'tonconnect://connect?v=2&id=$aliceHex&r=!!!&ret=back',
        ),
        throwsA(isA<BuError>()),
      );
      expect(
        () => TonConnectLink.parse(
          'tonconnect://connect?v=2&id=$aliceHex&ret=back',
        ),
        throwsA(isA<BuError>()),
      );
    });

    test('rejects non-request r payload', () {
      final link =
          'tonconnect://connect?v=2&id=$aliceHex&r=WzFd&ret=back'; // "[1]"
      expect(() => TonConnectLink.parse(link), throwsA(isA<BuError>()));
    });

    test('rejects http manifestUrl inside r', () {
      expect(
        () => TonConnectLink.build(
          dappId: aliceHex,
          request: TonConnectRequest(
            manifestUrl: 'http://example.com/m.json',
            items: [TonConnectItem(name: 'ton_addr')],
          ),
        ),
        throwsA(isA<BuError>()),
      );
    });
  });

  group('TonConnectItem', () {
    test('ton_proof requires payload, unknown names rejected', () {
      expect(() => TonConnectItem(name: 'ton_proof'), throwsA(isA<BuError>()));
      expect(() => TonConnectItem(name: 'nope'), throwsA(isA<BuError>()));
      expect(TonConnectItem(name: 'ton_addr').payload, isNull);
    });
  });

  group('TonConnectManifest', () {
    test('round-trips, rejects http icon + empty name', () {
      const manifest = {
        'url': 'https://example.com/tonconnect-manifest.json',
        'name': 'Demo',
        'iconUrl': 'https://example.com/icon.png',
      };
      final parsed = TonConnectManifest.fromJson(manifest);
      expect(parsed.toJson(), manifest);
      expect(
        () => TonConnectManifest.fromJson({...manifest, 'name': ''}),
        throwsA(isA<BuError>()),
      );
      expect(
        () => TonConnectManifest.fromJson({
          ...manifest,
          'iconUrl': 'http://example.com/icon.png',
        }),
        throwsA(isA<BuError>()),
      );
    });
  });

  group('TonNetworkId', () {
    test('parses baseline ids, rejects garbage', () {
      expect(TonNetworkId('-239').isMainnet, isTrue);
      expect(TonNetworkId('-3').isTestnet, isTrue);
      expect(TonNetworkId('100').value, '100');
      expect(() => TonNetworkId('mainnet'), throwsA(isA<BuError>()));
    });
  });

  group('TonConnectEvent/Error', () {
    test('success and error round-trips', () {
      final device = TonDeviceInfo(
        platform: 'android',
        appName: 'demo',
        appVersion: '1.0',
        features: [TonFeature.sendTransaction(maxMessages: 4)],
      );
      final event = TonConnectEventSuccess(
        id: 0,
        items: [
          {'name': 'ton_addr', 'address': '0:00'},
        ],
        device: device,
      );
      final json = event.toJson();
      expect(json['event'], 'connect');
      expect((json['payload'] as Map)['device'], device.toJson());
      final error = TonConnectEventError(id: 1, code: 300, message: 'no');
      expect(TonConnectEventError.fromJson(error.toJson()).code, 300);
    });
  });

  group('TonDeviceInfo', () {
    test('advertises v2 + parsed features', () {
      final device = TonDeviceInfo(
        platform: 'browser',
        appName: 'demo',
        appVersion: '1.0',
        features: [
          TonFeature.signData(types: ['text', 'binary', 'cell']),
          TonFeature.embeddedRequest(),
        ],
      );
      final back = TonDeviceInfo.fromJson(device.toJson());
      expect(back.protocolVersion, 2);
      expect(back.features.length, 2);
      expect(back.features[0].types, ['text', 'binary', 'cell']);
      expect(
        () => TonDeviceInfo(
          platform: 'watch',
          appName: 'd',
          appVersion: '1',
          features: const [],
        ),
        throwsA(isA<BuError>()),
      );
    });
  });

  group('TonAddressItemReply/ProofReply', () {
    test('reply round-trips, proof domain length enforced', () {
      final reply = TonAddressItemReply(
        address: '0:$aliceHex',
        network: '-239',
        publicKey: aliceHex,
        walletStateInit: 'dGVzdA==',
      );
      expect(
        TonAddressItemReply.fromJson(reply.toJson()).address,
        '0:$aliceHex',
      );
      final proof = TonProofItemReplySuccess(
        timestamp: '1700000000',
        domain: 'example.com',
        signature: 'c2ln',
        payload: 'nonce',
      );
      final back = TonProofItemReplySuccess.fromJson(proof.toJson());
      expect(back.lengthBytes, 'example.com'.length);
      const err = TonProofItemReplyError(code: 400, message: 'no proof');
      expect(TonProofItemReplyError.fromJson(err.toJson()).code, 400);
    });
  });
}

void main() {
  TonTestApi.runTest(connectTest, 'Connect');
}
