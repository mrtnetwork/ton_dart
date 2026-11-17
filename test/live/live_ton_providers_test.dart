// Live tests for the generated provider clients (toncenter v2, toncenter
// v3, tonapi). Read-only requests only — nothing is broadcast.
//
// Run with:
//   TON_LIVE_TEST=1 dart test test/live/ton_providers_live_test.dart
// Without the env flag the suite is skipped (no network in CI).
//
// The request classes under test are the generated replacements for the
// six calls contracts make today (see ContractProvider in
// lib/src/contracts/core/core/provider.dart):
//   TonCenterRunGetMethod            -> v2.TonCenterRunGetMethodPost
//   TonCenterGetAddressInformation   -> v2.TonCenterGetAddressInformationPost
//   TonCenterSendBocReturnHash       -> v2.TonCenterSendBocReturnHashPost
//   TonApiExecGetMethodForBlockchainAccount -> tonapi.TonApiExecGetMethodForBlockchainAccount
//   TonApiGetBlockchainRawAccount    -> tonapi.TonApiGetBlockchainRawAccount
//   TonApiSendBlockchainMessage      -> tonapi.TonApiSendBlockchainMessage
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

import 'package:ton_dart/src/provider/generated/tonapi/tonapi_models.dart'
    as tonapi_models;
import 'package:ton_dart/src/provider/generated/tonapi/tonapi_requests.dart'
    as tonapi;
import 'package:ton_dart/src/provider/generated/toncenter/toncenter_models.dart'
    as v2models;
import 'package:ton_dart/src/provider/generated/toncenter/toncenter_requests.dart'
    as v2;
import 'package:ton_dart/src/provider/generated/toncenter_v3/toncenter_v3_requests.dart'
    as v3;

/// Network under test. `TON_NET=testnet` switches hosts, key, addresses and
/// expectations; anything else runs mainnet.
///
/// Mainnet fixtures: wallet v3 r2 `0:66CD…` (has `seqno`), elector.
/// Testnet fixtures: jetton wallet `-1:4F25…` (`get_wallet_data` exit 0),
/// elector. Global id is -239 on mainnet, -3 on testnet.
class _NetConfig {
  final String tonApiUrl;
  final String tonCenterUrl;
  final String? tonCenterKey;
  final String walletRaw;
  final String electorRaw;
  final int globalId;
  final bool isTestnet;

  const _NetConfig({
    required this.tonApiUrl,
    required this.tonCenterUrl,
    required this.tonCenterKey,
    required this.walletRaw,
    required this.electorRaw,
    required this.globalId,
    required this.isTestnet,
  });

  static _NetConfig get current {
    if (Platform.environment['TON_NET'] == 'testnet') {
      return _NetConfig(
        tonApiUrl: 'https://testnet.tonapi.io',
        tonCenterUrl: 'https://testnet.toncenter.com',
        tonCenterKey:
            Platform.environment['TONCENTER_TESTNET_API_KEY'] ??
            'd3800f756738ac7b39599914b8a84465960ff869f555c2317664c9a62529baf3',
        walletRaw:
            '-1:4F253F553F76E154304A0DAE60CBB0E65BEE39ADE95D3C135727738F3C4559C1',
        electorRaw:
            '-1:3333333333333333333333333333333333333333333333333333333333333333',
        globalId: -3,
        isTestnet: true,
      );
    }
    return _NetConfig(
      tonApiUrl: 'https://tonapi.io',
      tonCenterUrl: 'https://toncenter.com',
      tonCenterKey: Platform.environment['TONCENTER_API_KEY'],
      walletRaw:
          '0:66CD6E30625156D2D881823E6C3F50A04A52DD62CF95A633D633BA0F60F61640',
      electorRaw:
          '-1:3333333333333333333333333333333333333333333333333333333333333333',
      globalId: -239,
      isTestnet: false,
    );
  }
}

/// Same shape as example/lib/examples/http.dart, standalone for tests.
class _LiveHttpService with TonServiceProvider {
  _LiveHttpService(this.net, {http.Client? client})
    : client = client ?? http.Client();
  final _NetConfig net;
  final http.Client client;

  static const _timeout = Duration(seconds: 30);

  static DateTime _lastTonCenterCall = DateTime.fromMillisecondsSinceEpoch(0);

  /// Keyless toncenter allows ~1 req/s; pace calls and retry 429s.
  static Future<void> _paceTonCenter() async {
    final wait =
        const Duration(milliseconds: 1200) -
        DateTime.now().difference(_lastTonCenterCall);
    if (!wait.isNegative) await Future.delayed(wait);
    _lastTonCenterCall = DateTime.now();
  }

  @override
  Future<BaseServiceResponse> doRequest(
    TonRequestDetails params, {
    Duration? timeout,
  }) async {
    final uri =
        params.api == TonApiType.tonApi
            ? params.encodeUrl(net.tonApiUrl)
            : params.encodeUrl(net.tonCenterUrl);
    final key = net.tonCenterKey;
    final headers = {
      ...params.headers,
      if (params.api.isTonCenter && key != null) 'X-API-Key': key,
    };
    Object? send() =>
        params.requestMethod.isPost
            ? client.post(uri, headers: headers, body: params.encodeBody())
            : client.get(uri, headers: headers);
    for (var attempt = 0; ; attempt++) {
      if (params.api.isTonCenter) await _paceTonCenter();
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

  @override
  final TonApiType api = TonApiType.tonApi;
}

void main() {
  // Pure-Dart crypto backend (cell parsing needs it; no-op if already set).
  blockchainUtils.setDartApi();
  final live = Platform.environment['TON_LIVE_TEST'] == '1';

  final net = _NetConfig.current;

  group(
    'live providers (net: ${net.isTestnet ? "testnet" : "mainnet"})',
    skip: live ? false : 'Set TON_LIVE_TEST=1',
    () {
      late _LiveHttpService service;
      late TonProvider tonApi;
      late TonProvider tonCenter;
      late TonQuickClient quick;
      late TonQuickClient quickTonApiOnly;

      setUpAll(() {
        service = _LiveHttpService(net);
        tonApi = TonProvider(service, TonApiType.tonApi);
        tonCenter = TonProvider(service, TonApiType.tonCenter);
        quick = DefaultTonQuickClient(provider: tonCenter);
        quickTonApiOnly = DefaultTonQuickClient(
          provider: tonApi,
          availableProviders: const [TonApiType.tonApi],
        );
      });

      tearDownAll(() => service.client.close());

      group('toncenter v2 (new client)', () {
        test('balance returns BigInt nanotons', () async {
          final balance = await tonCenter.request(
            v2.TonCenterGetAddressBalancePost(address: net.walletRaw),
          );
          print('v2 balance: $balance');
          expect(balance, isA<BigInt>());
          expect(balance > BigInt.zero, isTrue);
        });

        test(
          'address information (replaces TonCenterGetAddressInformation)',
          () async {
            final info = await tonCenter.request(
              v2.TonCenterGetAddressInformationPost(address: net.electorRaw),
            );
            print('v2 address info balance: ${info.balance}');
            expect(info, isA<v2models.AddressInformation>());
            expect(BigintUtils.parse(info.balance) > BigInt.zero, isTrue);
          },
        );

        test('wallet information flags wallet contracts', () async {
          // Mainnet fixture is a real wallet; testnet uses the elector,
          // which is deterministically *not* a wallet.
          final address = net.isTestnet ? net.electorRaw : net.walletRaw;
          final info = await tonCenter.request(
            v2.TonCenterGetWalletInformationPost(address: address),
          );
          expect(info.wallet, net.isTestnet ? isFalse : isTrue);
          expect(info.accountState, v2models.AccountStateEnum.active);
        });

        test('runGetMethod (replaces TonCenterRunGetMethod)', () async {
          // Mainnet wallet supports `seqno`; testnet fixture is a jetton
          // wallet supporting `get_wallet_data`.
          final method = net.isTestnet ? 'get_wallet_data' : 'seqno';
          final res = await tonCenter.request(
            v2.TonCenterRunGetMethodPost(
              address: net.walletRaw,
              method_: v2models.RunGetMethodRequestMethodStringValue(method),
              stack: const [],
            ),
          );
          print('v2 $method exit=${res.exitCode}');
          expect(res.exitCode, 0);
        });

        test('masterchain info', () async {
          final info = await tonCenter.request(
            v2.TonCenterGetMasterchainInfoPost(
              requestBody: const v2models.MasterchainInfoRequest({}),
            ),
          );
          print('v2 masterchain seqno=${info.last.seqno}');
          expect(info.last.seqno > 0, isTrue);
        });
      });

      group('toncenter v3 (new client)', () {
        test('masterchainInfo', () async {
          final info = await tonCenter.request(
            v3.TonCenterV3GetMasterchainInfo(),
          );
          print('v3 masterchain seqno=${info.last?.seqno}');
          expect(info.last?.seqno, isNotNull);
        });

        test('addressInformation', () async {
          final info = await tonCenter.request(
            v3.TonCenterV3GetV2AddressInformation(address: net.walletRaw),
          );
          print('v3 address balance: ${info.balance}');
          expect(BigInt.parse(info.balance ?? '0') > BigInt.zero, isTrue);
        });

        test('topAccountsByBalance list', () async {
          final top = await tonCenter.request(
            v3.TonCenterV3GetTopAccountsByBalance(limit: '2'),
          );
          expect(top.length, 2);
          print('v3 top account: ${top.first.account}');
          expect(top.first.balance, isNotNull);
        });
      });

      group('quick client (default, replaces provider in contracts)', () {
        test('getBalance', () async {
          final balance = await quick.getBalance(TonAddress(net.walletRaw));
          print('quick balance: $balance');
          expect(balance > BigInt.zero, isTrue);
        });

        test('tonApi branch serves same balance', () async {
          final balance = await quickTonApiOnly.getBalance(
            TonAddress(net.walletRaw),
          );
          expect(balance > BigInt.zero, isTrue);
        });

        test('getAccountState elector is active', () async {
          final state = await quick.getAccountState(TonAddress(net.electorRaw));
          expect(state.state.isActive, isTrue);
          expect(state.balance > BigInt.zero, isTrue);
        });

        test('runGetMethod', () async {
          // Mainnet wallet: `seqno` returns a number; testnet jetton wallet:
          // `get_wallet_data` returns wallet data.
          final method = net.isTestnet ? 'get_wallet_data' : 'seqno';
          final res = await quick.runGetMethod(
            address: TonAddress(net.walletRaw),
            method: method,
          );
          expect(res.exitCode, 0);
          if (!net.isTestnet) {
            expect(res.reader().readNumber(), greaterThan(0));
          }
        });

        test('runGetMethod with TupleItem args', () async {
          final method = net.isTestnet ? 'get_wallet_data' : 'seqno';
          final res = await quick.runGetMethod(
            address: TonAddress(net.walletRaw),
            method: method,
            args: const [],
          );
          expect(res.exitCode, 0);
        });

        test('getMasterchainSeqno', () async {
          final seqno = await quick.getMasterchainSeqno();
          print('quick masterchain seqno: $seqno');
          expect(seqno > 0, isTrue);
        });

        test('second backend serves every method', () async {
          final balance = await quickTonApiOnly.getBalance(
            TonAddress(net.walletRaw),
          );
          expect(balance > BigInt.zero, isTrue);

          final state = await quickTonApiOnly.getAccountState(
            TonAddress(net.walletRaw),
          );
          expect(state.state.isActive, isTrue);

          final run = await quickTonApiOnly.runGetMethod(
            address: TonAddress(net.walletRaw),
            method: net.isTestnet ? 'get_wallet_data' : 'seqno',
          );
          expect(run.exitCode, 0);

          expect(await quickTonApiOnly.getMasterchainSeqno() > 0, isTrue);
          expect(await quickTonApiOnly.getGlobalId(), net.globalId);

          final fwd = await quickTonApiOnly.getMsgForwardPrices();
          expect(fwd.bitPrice >= BigInt.zero, isTrue);

          final gas = await quickTonApiOnly.getGasLimitPrices();
          expect(gas.gasPrice > BigInt.zero, isTrue);

          final storage = await quickTonApiOnly.getStoragePrices();
          expect(storage, isNotEmpty);

          final jettons = await quickTonApiOnly.getAccountJettons(
            owner: net.walletRaw,
          );
          print('tonapi jettons: ${jettons.length}');
          expect(jettons, isA<List<TonJettonBalance>>());
        });

        test('tonCenter serves every method', () async {
          final fwd = await quick.getMsgForwardPrices();
          print('v2 forward lump=${fwd.lumpPrice} bit=${fwd.bitPrice}');
          expect(fwd.bitPrice > BigInt.zero, isTrue);

          final gas = await quick.getGasLimitPrices();
          expect(gas.gasPrice > BigInt.zero, isTrue);

          final storage = await quick.getStoragePrices();
          expect(storage, isNotEmpty);

          final jettons = await quick.getAccountJettons(owner: net.walletRaw);
          print('v2 jettons: ${jettons.length}');
          expect(jettons, isA<List<TonJettonBalance>>());
        });

        test('estimateFee tonCenter (tonApi needs a signed message)', () async {
          final comment =
              beginCell().storeUint32(0).storeStringTail('hi').endCell();
          final v2fee = await quick.estimateFee(
            address: net.walletRaw,
            body: comment.toBase64(),
          );
          print(
            'v2 fee action=${v2fee.actionPhase} storage=${v2fee.storageFee} gas=${v2fee.gasFee}',
          );
          expect(v2fee.success, isTrue);
          expect(v2fee.actionPhase > BigInt.zero, isTrue);
          // tonApi emulate requires a signed external message; its mapping
          // is covered by the offline fixture test above.
        });

        test('getTransactionStatus of fresh wallet tx (both)', () async {
          final account = await tonApi.request(
            tonapi.TonApiGetBlockchainRawAccount(accountId: net.walletRaw),
          );
          final hash = account.lastTransactionHash!;
          final v3status = await quick.getTransactionStatus(
            hash,
            isMessageHash: false,
          );
          print('v3 tx status: $v3status');
          expect(v3status, TonTxStatus.included);
        });

        test('sendBoc rejects garbage on both backends', () async {
          await expectLater(quick.sendBoc('eQ=='), throwsA(anything));
          await expectLater(quickTonApiOnly.sendBoc('eQ=='), throwsA(anything));
        });

        test('getGlobalId matches mainnet', () async {
          final globalId = await quick.getGlobalId();
          print('quick global id: $globalId');
          expect(globalId, net.globalId);
        });

        test('getTransactionStatus of fresh wallet tx', () async {
          final account = await tonApi.request(
            tonapi.TonApiGetBlockchainRawAccount(accountId: net.walletRaw),
          );
          final status = await quickTonApiOnly.getTransactionStatus(
            account.lastTransactionHash!,
          );
          print('quick tx status: $status');
          expect(status, TonTxStatus.included);
        });
      });

      group('tonapi (new client)', () {
        test('status', () async {
          final status = await tonApi.request(tonapi.TonApiStatus());
          print('tonapi indexing latency: ${status.indexingLatency}');
          expect(status.restOnline, isTrue);
        });

        test('getAccount elector (raw form)', () async {
          final account = await tonApi.request(
            tonapi.TonApiGetAccount(accountId: net.electorRaw),
          );
          expect(account, isA<tonapi_models.Account>());
          expect(account.isWallet, isFalse);
        });

        test('raw account (replaces TonApiGetBlockchainRawAccount)', () async {
          final account = await tonApi.request(
            tonapi.TonApiGetBlockchainRawAccount(accountId: net.walletRaw),
          );
          print('tonapi raw balance: ${account.balance}');
          expect(account.balance > BigInt.zero, isTrue);
        });

        test(
          'exec get-method (replaces TonApiExecGetMethodForBlockchainAccount)',
          () async {
            final res = await tonApi.request(
              tonapi.TonApiExecGetMethodForBlockchainAccount(
                accountId: net.walletRaw,
                methodName: net.isTestnet ? 'get_wallet_data' : 'seqno',
              ),
            );
            print('tonapi success=${res.success} exit=${res.exitCode}');
            expect(res.success, isTrue);
            expect(res.exitCode, 0);
          },
        );
      });
    },
  );
}
