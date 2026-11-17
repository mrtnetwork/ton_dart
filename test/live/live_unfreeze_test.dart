// Live unfreeze test on testnet (read-only).
//
// Run with:
//   TON_LIVE_TEST=1 TON_NET=testnet dart test test/live/unfreeze_live_test.dart
// Without the env flags the suite is skipped (no network in CI).
//
// Fixture: wallet v1r1 from the examples, frozen on testnet since 2024:
//   kf9serWJThPWFoZqR5ad3GSjWsGmY8I_8d3IQuKOyIlODJlh
//   frozen_hash: ifRwqgo1eRZjw9x3wlE9oUkdIxIX/NIfc+mw7D7TjQI=
//   freezeTx: lt=28619885000011
//   unfreezeBlock: 23146364
//
// Note: testnet v2 keeps only a shallow archive, so `getStateForUnfreeze`
// at the 2024 unfreeze block is pruned (`seqno not in db`). The test
// asserts the deterministic parts (frozen hash, freeze boundary) and the
// documented archive behavior; it passes fully wherever the block is
// available (mainnet / recent freezes).
// ignore_for_file: avoid_print
import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

const _addressStr = 'kf9serWJThPWFoZqR5ad3GSjWsGmY8I_8d3IQuKOyIlODJlh';
const _frozenHashBase64 = 'ifRwqgo1eRZjw9x3wlE9oUkdIxIX/NIfc+mw7D7TjQI=';
const _freezeTxLt = '28619885000011';
const _freezeTxHashBase64 = 'PePB7X89B/QagIqQfPgsiTHhNsJt/ruZkf9HvpSoP8w=';
const _unfreezeBlock = 23146364;

class _LiveHttpService with TonServiceProvider {
  _LiveHttpService({http.Client? client}) : client = client ?? http.Client();
  final http.Client client;

  static const _timeout = Duration(seconds: 30);
  static DateTime _lastCall = DateTime.fromMillisecondsSinceEpoch(0);

  static Future<void> _pace() async {
    final wait =
        const Duration(milliseconds: 1200) -
        DateTime.now().difference(_lastCall);
    if (!wait.isNegative) await Future.delayed(wait);
    _lastCall = DateTime.now();
  }

  @override
  final TonApiType api = TonApiType.tonCenter;

  @override
  Future<BaseServiceResponse> doRequest(
    TonRequestDetails params, {
    Duration? timeout,
  }) async {
    final key =
        Platform.environment['TONCENTER_TESTNET_API_KEY'] ??
        'd3800f756738ac7b39599914b8a84465960ff869f555c2317664c9a62529baf3';
    final headers = {...params.headers, 'X-API-Key': key};
    Object? send() =>
        params.requestMethod.isPost
            ? client.post(
              params.encodeUrl('https://testnet.toncenter.com'),
              headers: headers,
              body: params.encodeBody(),
            )
            : client.get(
              params.encodeUrl('https://testnet.toncenter.com'),
              headers: headers,
            );
    for (var attempt = 0; ; attempt++) {
      await _pace();
      final response = await (send() as Future<http.Response>).timeout(
        timeout ?? _timeout,
      );
      if (response.statusCode != 429 || attempt >= 3) {
        return params.toResponse(
          response.bodyBytes,
          statusCode: response.statusCode,
        );
      }
      await Future.delayed(Duration(seconds: 2 * (attempt + 1)));
    }
  }
}

void main() {
  blockchainUtils.setDartApi();
  final live = Platform.environment['TON_LIVE_TEST'] == '1';
  final testnet = Platform.environment['TON_NET'] == 'testnet';

  group(
    'unfreeze live (testnet)',
    skip: live && testnet ? false : 'Set TON_LIVE_TEST=1 TON_NET=testnet',
    () {
      late UnfreezeService unfreeze;
      late TonAddress address;
      late BuBytes frozen;

      setUpAll(() {
        final provider = TonProvider(_LiveHttpService(), TonApiType.tonCenter);
        unfreeze = UnfreezeService(provider);
        address = TonAddress(_addressStr);
      });

      test('frozen hash matches fixture', () async {
        final hash = await unfreeze.fetchFrozenHash(address);
        expect(hash, isNotNull);
        frozen = hash!;
        expect(
          StringUtils.decode(frozen, encoding: StringEncoding.base64),
          _frozenHashBase64,
        );
        print('frozen_hash OK: $_frozenHashBase64');
      });

      test('finds the freeze boundary', () async {
        final found = await unfreeze.findUnfreezeBlock(address, frozen);
        expect(found, isNotNull);
        expect(found!.unfreezeBlock, _unfreezeBlock);
        expect(found.freezeTx.ltString, _freezeTxLt);
        expect(found.freezeTx.hashBase64, _freezeTxHashBase64);
        print(
          'boundary OK: block=${found.unfreezeBlock} tx=${found.freezeTx.toJson()}',
        );
      });

      test('latest shard account parses as frozen', () async {
        final shard = await unfreeze.getShardAccount(address);
        final state = shard.account?.storage.state;
        expect(state, isNotNull);
        expect(state, isA<AccountStateFrozen>());
        print('shard account OK: frozen state present');
      });

      test('state recovery honors the testnet archive window', () async {
        try {
          final state = await unfreeze.getStateForUnfreeze(
            address: address,
            unfreezeBlock: _unfreezeBlock,
            stateInitHashToMatch: frozen,
          );
          // Archive available: must verify cleanly.
          expect(state.error, isNull, reason: state.error);
          expect(state.stateInitHashBase64, _frozenHashBase64);
          print('StateInit OK: ${state.sizeBytes} bytes');
        } on RPCError catch (e) {
          // Testnet v2 prunes the 2024 block: documented behavior.
          print('Archive pruned (expected on testnet): $e');
          expect(
            e.message.contains('seqno not in db') ||
                e.message.contains('NOTREADY'),
            isTrue,
            reason: 'unexpected RPCError: $e',
          );
        }
      });
    },
  );
}
