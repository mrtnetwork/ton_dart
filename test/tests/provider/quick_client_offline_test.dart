// Offline quick-client tests (stub service, no network). Extracted from
// `test/live/live_ton_providers_test.dart` so the one-shot suite covers them;
// the live file keeps network tests only.
import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

import '../../utils.dart';

// Mainnet wallet v3 r2 fixture (has `seqno`).
const String _walletRaw =
    '0:66CD6E30625156D2D881823E6C3F50A04A52DD62CF95A633D633BA0F60F61640';

void quickClientOfflineTest() {
  group('quick client offline (always runs)', () {
    test('tonApi 404 maps to uninitialized empty state', () async {
      final stub = _StubTonService({'error': 'entity not found'});
      final quick = DefaultTonQuickClient(
        provider: TonProvider(stub, TonApiType.tonApi),
        availableProviders: const [TonApiType.tonApi],
      );
      final state = await quick.getAccountState(
        TonAddress(
          '0:0000000000000000000000000000000000000000000000000000000000000001',
        ),
      );
      expect(state.balance, BigInt.zero);
      expect(state.code, isNull);
      expect(state.data, isNull);
    });

    test('no available provider throws', () async {
      final stub = _StubTonService({});
      final quick = DefaultTonQuickClient(
        provider: TonProvider(stub, TonApiType.tonApi),
        availableProviders: const [],
      );
      expect(() => quick.getBalance(TonAddress(_walletRaw)), throwsA(anything));
    });

    test('no available provider throws', () async {
      final stub = _StubTonService({});
      final quick = DefaultTonQuickClient(
        provider: TonProvider(stub, TonApiType.tonApi),
        availableProviders: const [],
      );
      expect(() => quick.getBalance(TonAddress(_walletRaw)), throwsA(anything));
    });

    Map<String, dynamic> stubTx({
      required bool success,
      Map<String, dynamic>? action,
      Map<String, dynamic>? compute,
      Map<String, dynamic>? inMsg,
    }) {
      return {
        'aborted': false,
        'account': {'address': 'EQa', 'is_scam': false, 'is_wallet': true},
        'block': 'b',
        'destroyed': false,
        'end_balance': '0',
        'hash': 'h',
        'lt': '1',
        'utime': '1',
        'orig_status': 'active',
        'end_status': 'active',
        'out_msgs': [],
        'total_fees': '0',
        'raw': 'eQ==',
        'state_update_old': 'eQ==',
        'state_update_new': 'eQ==',
        'transaction_type': 'TransOrd',
        'success': success,
        if (action != null) 'action_phase': action,
        if (compute != null) 'compute_phase': compute,
        if (inMsg != null) 'in_msg': inMsg,
      };
    }

    TonQuickClient stubQuick(
      Map<String, Map<String, dynamic>> responses, {
      bool envelope = false,
      TonApiType api = TonApiType.tonCenter,
    }) {
      final stub = _StubTonService.paths(responses, envelope: envelope);
      return DefaultTonQuickClient(
        provider: TonProvider(stub, api),
        availableProviders: [api],
      );
    }

    test('estimateFee tonCenter sums source fees', () async {
      final quick = stubQuick({
        '/api/v2/estimateFee': {
          '@type': 'query.fees',
          'source_fees': {
            '@type': 'fees',
            'in_fwd_fee': '1',
            'storage_fee': '2',
            'gas_fee': '3',
            'fwd_fee': '4',
          },
          'destination_fees': [],
        },
      }, envelope: true);
      final fee = await quick.estimateFee(address: 'EQa', body: 'Ym9keQ==');
      expect(fee.actionPhase, BigInt.from(5));
      expect(fee.storageFee, BigInt.from(2));
      expect(fee.gasFee, BigInt.from(3));
      expect(fee.success, isTrue);
      expect(fee.internalMessages, isEmpty);
    });

    test('estimateFee tonApi flattens failing child', () async {
      final child = {
        'total_fees': '0',
        'transaction': stubTx(
          success: false,
          action: {
            'success': false,
            'fwd_fees': '1',
            'result_code': 1,
            'skipped_actions': 0,
            'total_actions': 1,
            'total_fees': '1',
            'result_code_description': 'no funds',
          },
          inMsg: {
            'bounce': true,
            'bounced': false,
            'created_at': '1',
            'created_lt': '1',
            'fwd_fee': '1',
            'hash': 'h',
            'ihr_disabled': false,
            'ihr_fee': '0',
            'import_fee': '0',
            'msg_type': 'int_msg',
            'value': '100',
            'destination': {
              'address': 'EQd',
              'is_scam': false,
              'is_wallet': true,
            },
          },
        ),
        'children': [],
        'interfaces': [],
      };
      final quick = stubQuick({
        '/v2/traces/emulate': {
          'total_fees': '0',
          'transaction': stubTx(
            success: true,
            action: {
              'success': true,
              'fwd_fees': '7',
              'result_code': 0,
              'skipped_actions': 0,
              'total_actions': 1,
              'total_fees': '7',
            },
            compute: {'success': true, 'gas_fees': '5', 'skipped': false},
          ),
          'children': [child],
          'interfaces': [],
        },
      }, api: TonApiType.tonApi);
      // NOTE: the tonApi branch rebuilds the external message cell, so it
      // parses the destination (unlike the tonCenter branch, which forwards
      // the raw string). 'EQa' is not a valid address; use the fixture.
      // NOTE: the tonApi branch rebuilds the external message cell, so it
      // needs a valid destination (unlike the tonCenter branch, which
      // forwards raw strings) and a valid body cell.
      final fee = await quick.estimateFee(
        address: _walletRaw,
        body:
            beginCell()
                .storeUint32(0)
                .storeStringTail('hi')
                .endCell()
                .toBase64(),
      );
      expect(fee.success, isFalse);
      expect(fee.actionPhase, BigInt.from(7));
      expect(fee.gasFee, BigInt.from(5));
      expect(fee.internalMessages.length, 1);
      final nested = fee.internalMessages.first;
      expect(nested.success, isFalse);
      expect(nested.resultDescription, 'no funds');
      expect(nested.destination, 'EQd');
    });

    test('getMsgForwardPrices tonCenter parses config cell', () async {
      final quick = stubQuick({
        '/api/v2/getConfigParam': {
          '@type': 'configInfo',
          'config': {
            '@type': 'tvm.cell',
            'bytes':
                'te6cckEBAQEAIwAAQuoAAAAAAJiWgAAAAAAnEAAAAAAAD0JAAAAAAYAAVVVVVX2jQy8=',
          },
        },
      }, envelope: true);
      final prices = await quick.getMsgForwardPrices();
      expect(prices.bitPrice > BigInt.zero, isTrue);
      expect(prices.lumpPrice >= BigInt.zero, isTrue);
    });

    test('getGasLimitPrices tonApi maps fields', () async {
      final quick = stubQuick({
        '/v2/blockchain/config': {
          '0': '',
          '1': '',
          '2': '',
          '4': '',
          '44': {'accounts': [], 'suspended_until': 0},
          'raw': '',
          '20': {
            'gas_limits_prices': {
              'flat_gas_limit': '1',
              'flat_gas_price': '2',
              'gas_price': '3',
              'gas_limit': '4',
              'gas_credit': '5',
              'block_gas_limit': '6',
              'freeze_due_limit': '7',
              'delete_due_limit': '8',
            },
          },
        },
      }, api: TonApiType.tonApi);
      final prices = await quick.getGasLimitPrices();
      expect(prices.gasPrice, BigInt.from(3));
      expect(prices.flatGasLimit, BigInt.one);
      expect(prices.specialGasLimit, isNull);
    });

    test('getStoragePrices tonCenter parses config cell', () async {
      final quick = stubQuick({
        '/api/v2/getConfigParam': {
          '@type': 'configInfo',
          'config': {
            '@type': 'tvm.cell',
            'bytes':
                'te6cckEBAwEAWQACAUgBAgBM3swAAAAAAAAAAAAAAAEAAAAAAAAB9AAAAAAAAAPoAAAAAAAHoSAAU71Pk/sGY0+T+wAAAAAAAAAAAAAAAAAAAAQ4AAAAAAAAH0AAAAAAAD0JBPXsekg=',
          },
        },
      }, envelope: true);
      final prices = await quick.getStoragePrices();
      expect(prices, isNotEmpty);
      expect(prices.first.utimeSince, isA<int>());
    });

    test('getTransactionStatus tonCenter matches actions', () async {
      final quick = stubQuick({
        '/api/v3/traces': {
          'traces': [
            {
              'external_hash': 'abc',
              'actions': [
                {'success': true},
              ],
            },
          ],
        },
      });
      expect(await quick.getTransactionStatus('abc'), TonTxStatus.included);
    });

    test('getTransactionStatus tonApi reads success', () async {
      final quick = stubQuick({
        '/v2/blockchain/transactions/abc': stubTx(success: false),
      }, api: TonApiType.tonApi);
      expect(await quick.getTransactionStatus('abc'), TonTxStatus.failed);
    });

    test('getAccountJettons tonCenter joins metadata', () async {
      final quick = stubQuick({
        '/api/v3/jetton/wallets': {
          'jetton_wallets': [
            {
              'address': 'EQw',
              'balance': '100',
              'jetton': 'EQm',
              'owner': 'EQo',
            },
          ],
          'metadata': {
            'EQm': {
              'token_info': [
                {'name': 'T', 'symbol': 'T', 'image': 'i'},
              ],
            },
          },
        },
      });
      final list = await quick.getAccountJettons(owner: 'EQo');
      expect(list.length, 1);
      expect(list.first.wallet, 'EQw');
      expect(list.first.minter, 'EQm');
      expect(list.first.balance, BigInt.from(100));
      expect(list.first.name, 'T');
    });

    test('getAccountJettons tonApi maps preview', () async {
      final quick = stubQuick({
        '/v2/accounts/EQo/jettons': {
          'balances': [
            {
              'balance': '5',
              'jetton': {
                'address': 'EQm',
                'decimals': 9,
                'image': 'i',
                'name': 'N',
                'symbol': 'S',
                'verification': 'whitelist',
                'score': 0,
              },
              'wallet_address': {
                'address': 'EQw',
                'is_scam': false,
                'is_wallet': true,
              },
            },
          ],
        },
      }, api: TonApiType.tonApi);
      final list = await quick.getAccountJettons(owner: 'EQo');
      expect(list.length, 1);
      expect(list.first.decimals, 9);
      expect(list.first.symbol, 'S');
    });

    test('getGlobalId tonCenter reads block header', () async {
      Map<String, dynamic> blockId() => {
        '@type': 'ton.blockIdExt',
        'workchain': -1,
        'shard': '-9223372036854775808',
        'seqno': 45245000,
        'root_hash': 'aaa',
        'file_hash': 'bbb',
      };
      final quick = stubQuick({
        '/api/v2/getMasterchainInfo': {
          '@type': 'blocks.masterchainInfo',
          'last': blockId(),
          'state_root_hash': 'ccc',
          'init': blockId(),
        },
        '/api/v2/getBlockHeader': {
          '@type': 'blocks.header',
          'id': blockId(),
          'global_id': -239,
          'version': 0,
          'after_merge': false,
          'after_split': false,
          'before_split': false,
          'want_merge': false,
          'want_split': false,
          'validator_list_hash_short': 1,
          'catchain_seqno': 1,
          'min_ref_mc_seqno': 1,
          'is_key_block': false,
          'prev_key_block_seqno': 1,
          'start_lt': '1',
          'end_lt': '2',
          'gen_utime': 1,
          'prev_blocks': [],
        },
      }, envelope: true);
      expect(await quick.getGlobalId(), -239);
    });
  });
}

class _StubTonService with TonServiceProvider {
  final Map<String, Map<String, dynamic>> responses;
  final bool envelope;

  _StubTonService(Map<String, dynamic> single)
    : responses = {'': single},
      envelope = false;

  _StubTonService.paths(this.responses, {this.envelope = false});

  @override
  Future<BaseServiceResponse> doRequest(
    TonRequestDetails params, {
    Duration? timeout,
  }) async {
    final path = params.path ?? '';
    final key = responses.keys.firstWhere(
      (k) => k.isEmpty || path == k || path.startsWith('$k?'),
      orElse: () => '',
    );
    final body = responses[key] ?? const {};
    final payload = envelope ? {'ok': true, 'result': body} : body;
    return params.toResponse(utf8.encode(jsonEncode(payload)), statusCode: 200);
  }

  @override
  final TonApiType api = TonApiType.tonApi;
}

void main() {
  TonTestApi.runTest(quickClientOfflineTest, 'Quick Client Offline');
}
