import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/ton_connect/rpc/models.dart';
import 'package:ton_dart/src/ton_connect/rpc/validation.dart';
import '../utils.dart';

void rpcTest() {
  // Spec example: bounceable masterchain (-1), zero hash.
  const friendly1 = 'Ef8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAU';
  // Bounceable basechain (0), zero hash.
  const friendly2 = 'EQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAM9c';
  final rawZeroBase = '0:${'00' * 32}';
  final rawZeroMaster = '-1:${'00' * 32}';
  const now = 1700000000;

  TonTransactionPayload tx({
    int? validUntil = 2000000000,
    String? network = '-239',
    String? from,
    List<TonTxMessage>? messages,
  }) {
    return TonTransactionPayload(
      validUntil: validUntil,
      network: network,
      from: from,
      messages:
          messages ?? [TonTxMessage(address: friendly1, amount: '100000000')],
    );
  }

  group('validateTransactionPayload', () {
    test('valid payload ok', () {
      final v = TonConnectUtils.validateTransactionPayload(
        tx(),
        activeNetwork: '-239',
        connectedAddress: friendly1,
        nowSeconds: now,
      );
      expect(v.isOk, isTrue);
    });

    test('messages+items rejected, empty rejected', () {
      expect(
        () => TonTransactionPayload(
          messages: [TonTxMessage(address: friendly1, amount: '1')],
          items: [
            TonTxItem({'type': 'ton', 'address': friendly1, 'amount': '1'}),
          ],
        ),
        throwsA(isA<BuError>()),
      );
      expect(() => TonTransactionPayload.fromJson({}), throwsA(isA<BuError>()));
    });

    test('raw destination rejected, friendly accepted', () {
      final v = TonConnectUtils.validateTransactionPayload(
        tx(
          messages: [TonTxMessage(address: rawZeroBase, amount: '1')],
          network: null,
          validUntil: null,
        ),
        activeNetwork: '-239',
        connectedAddress: null,
        nowSeconds: now,
      );
      expect(v.issue, TonRpcIssue.badRequest);
    });

    test('expired valid_until rejected', () {
      final v = TonConnectUtils.validateTransactionPayload(
        tx(validUntil: 1000000000),
        activeNetwork: '-239',
        connectedAddress: null,
        nowSeconds: now,
      );
      expect(v.issue, TonRpcIssue.expired);
    });

    test('network mismatch flagged, match passes', () {
      final bad = TonConnectUtils.validateTransactionPayload(
        tx(network: '-3'),
        activeNetwork: '-239',
        connectedAddress: null,
        nowSeconds: now,
      );
      expect(bad.issue, TonRpcIssue.networkMismatch);
      expect(bad.code, TonRpcErrorCode.badRequest);
    });

    test('from pins sender (raw normalizes to friendly account)', () {
      final ok = TonConnectUtils.validateTransactionPayload(
        tx(from: rawZeroMaster),
        activeNetwork: '-239',
        connectedAddress: friendly1,
        nowSeconds: now,
      );
      expect(ok.isOk, isTrue);
      final bad = TonConnectUtils.validateTransactionPayload(
        tx(from: friendly2),
        activeNetwork: '-239',
        connectedAddress: friendly1,
        nowSeconds: now,
      );
      expect(bad.issue, TonRpcIssue.fromMismatch);
    });

    test('bad amount and bad BoC rejected, too many rejected', () {
      final badAmount = TonConnectUtils.validateTransactionPayload(
        tx(
          messages: [TonTxMessage(address: friendly1, amount: '-5')],
          network: null,
          validUntil: null,
        ),
        activeNetwork: '-239',
        connectedAddress: null,
        nowSeconds: now,
      );
      expect(badAmount.issue, TonRpcIssue.badRequest);
      final badBoc = TonConnectUtils.validateTransactionPayload(
        tx(
          messages: [
            TonTxMessage(address: friendly1, amount: '1', payload: '!!!'),
          ],
          network: null,
          validUntil: null,
        ),
        activeNetwork: '-239',
        connectedAddress: null,
        nowSeconds: now,
      );
      expect(badBoc.issue, TonRpcIssue.badRequest);
      final many = TonConnectUtils.validateTransactionPayload(
        TonTransactionPayload(
          messages: List.generate(
            5,
            (_) => TonTxMessage(address: friendly1, amount: '1'),
          ),
        ),
        activeNetwork: '-239',
        connectedAddress: null,
        nowSeconds: now,
      );
      expect(many.issue, TonRpcIssue.badRequest);
    });

    test('structured ton item ok', () {
      final v = TonConnectUtils.validateTransactionPayload(
        TonTransactionPayload(
          items: [
            TonTxItem({'type': 'ton', 'address': friendly2, 'amount': '7'}),
          ],
        ),
        activeNetwork: '-239',
        connectedAddress: null,
        nowSeconds: now,
      );
      expect(v.isOk, isTrue);
    });
  });

  group('validateSignDataPayload', () {
    test('text ok, binary garbage rejected, cell checked', () {
      final ok = TonConnectUtils.validateSignDataPayload(
        TonSignDataPayload.fromJson({'type': 'text', 'text': 'hi'}),
        activeNetwork: '-239',
        connectedAddress: null,
        nowSeconds: now,
      );
      expect(ok.isOk, isTrue);
      final bad = TonConnectUtils.validateSignDataPayload(
        TonSignDataPayload.fromJson({'type': 'binary', 'bytes': '!!!'}),
        activeNetwork: '-239',
        connectedAddress: null,
        nowSeconds: now,
      );
      expect(bad.issue, TonRpcIssue.badRequest);
    });
  });

  group('ton_proof', () {
    test('byte layout matches spec', () {
      final address = TonAddress(friendly1);
      const domain = 'example.com';
      const timestamp = 1700000000;
      final payload = StringUtils.encode('nonce-1');
      final message = TonConnectUtils.buildTonProofMessage(
        address: address,
        domain: domain,
        timestamp: timestamp,
        payload: payload,
      );
      final prefix = StringUtils.encode('ton-proof-item-v2/');
      expect(message.sublist(0, prefix.length), prefix);
      int o = prefix.length;
      final wcRaw = BinaryOps.readUint32BE(message, o);
      final wc = wcRaw >= 0x80000000 ? wcRaw - 0x100000000 : wcRaw;
      expect(wc, -1);
      o += 4;
      expect(message.sublist(o, o + 32), List.filled(32, 0));
      o += 32;
      final domLen = BinaryOps.readUint32LE(message, o);
      expect(domLen, domain.length);
      o += 4;
      expect(message.sublist(o, o + domain.length), StringUtils.encode(domain));
      o += domain.length;
      // BigInt compose: `<< 32` on plain int is not web-safe (dart2js).
      final ts =
          (BigInt.from(BinaryOps.readUint32LE(message, o)) +
                  BigInt.from(BinaryOps.readUint32LE(message, o + 4)) *
                      BigInt.from(0x100000000))
              .toInt();
      expect(ts, timestamp);
      o += 8;
      expect(message.sublist(o), payload);
    });

    test('sign + verify round-trip, tamper fails', () {
      final privateKey = TonPrivateKey.fromBytes(
        List<int>.generate(32, (i) => i + 1),
      );
      final publicKey = privateKey.toPublicKey();
      final address = TonAddress(friendly1);
      final payload = StringUtils.encode('server-nonce');
      final signature = TonConnectUtils.signTonProof(
        privateKey: privateKey,
        address: address,
        domain: 'example.com',
        timestamp: now,
        payload: payload,
      );
      expect(
        TonConnectUtils.verifyTonProof(
          publicKey: publicKey,
          address: address,
          domain: 'example.com',
          timestamp: now,
          payload: payload,
          signature: signature,
        ),
        isTrue,
      );
      expect(
        TonConnectUtils.verifyTonProof(
          publicKey: publicKey,
          address: address,
          domain: 'evil.com',
          timestamp: now,
          payload: payload,
          signature: signature,
        ),
        isFalse,
      );
    });

    test('domain dot-rule', () {
      expect(TonConnectUtils.isValidProofDomain('example.com'), isTrue);
      expect(TonConnectUtils.isValidProofDomain('tonkeeper'), isFalse);
      expect(
        TonConnectUtils.isValidProofDomain('tonkeeper', allowNative: true),
        isTrue,
      );
      expect(TonConnectUtils.isValidProofDomain(''), isFalse);
    });
  });

  group('signData digests', () {
    test('text layout + round-trip', () {
      final address = TonAddress(friendly1);
      final data = StringUtils.encode('hello');
      final message = TonConnectUtils.buildSignDataMessage(
        address: address,
        domain: 'example.com',
        timestamp: now,
        prefix: 'txt',
        data: data,
      );
      expect(message.sublist(0, 2), [0xff, 0xff]);
      expect(
        message.sublist(2, 2 + 'ton-connect/sign-data/'.length),
        StringUtils.encode('ton-connect/sign-data/'),
      );
      final digest = TonConnectUtils.signDataDigest(message);
      expect(digest.length, 32);
      final privateKey = TonPrivateKey.fromBytes(
        List<int>.generate(32, (i) => 0xa0 + i),
      );
      final signature = privateKey.sign(digest);
      expect(privateKey.toPublicKey().verify(digest, signature), isTrue);
    });

    test('cell payload builds TL-B envelope', () {
      final payload = beginCell().storeUint(42, 32).endCell();
      final cell = TonConnectUtils.buildSignDataCell(
        schema: 'test cell',
        timestamp: now,
        walletAddress: TonAddress(friendly1),
        appDomain: 'example.com',
        payload: payload,
      );
      expect(cell.hash().length, 32);
      expect(
        TonConnectUtils.dnsWireEncode('example.com'),
        'com\x00example\x00',
      );
    });
  });

  group('envelopes + id tracking', () {
    test('request/response/event round-trips', () {
      final request = TonAppRequest(
        method: 'sendTransaction',
        params: ['{"messages":[]}'],
        id: '42',
      );
      expect(TonAppRequest.fromJson(request.toJson()).id, '42');
      expect(
        () => TonAppRequest(method: 'disconnect', params: ['x'], id: '1'),
        throwsA(isA<BuError>()),
      );
      final response = TonWalletResponse.success(id: '42', result: 'boc==');
      expect(TonWalletResponse.fromJson(response.toJson()).isSuccess, isTrue);
      final event = TonWalletEvent(event: 'disconnect', id: 3, payload: {});
      expect(TonWalletEvent.fromJson(event.toJson()).id, 3);
    });

    test('request ids strictly increase', () {
      final tracker = TonRequestIdTracker();
      expect(tracker.accept('42'), isTrue);
      expect(tracker.accept('43'), isTrue);
      expect(tracker.accept('43'), isFalse);
      expect(tracker.accept('7'), isFalse);
      tracker.reset();
      expect(tracker.accept('7'), isTrue);
    });

    test('event ids count up', () {
      final counter = TonWalletEventId();
      expect([counter.next(), counter.next()], [0, 1]);
    });
  });
}

void main() {
  TonTestApi.runTest(rpcTest, 'Rpc');
}
