import 'package:blockchain_utils/service/service.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/provider/generated/toncenter_v3/toncenter_v3_requests.dart';
import 'package:ton_dart/ton_dart.dart';
import '../../utils.dart';


/// Canned provider serving one fixed JSON response per request type.
class _CannedProvider
    implements IProvider<IServiceProvider, TonRequestDetails> {
  final Map<String, dynamic> v3Orders;
  final Map<String, dynamic> tonApiMultisig;
  _CannedProvider({required this.v3Orders, required this.tonApiMultisig});

  @override
  IServiceProvider get service => throw UnimplementedError();

  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TonRequestDetails> request, {
    Duration? timeout,
  }) async {
    final String path = request is TonCenterV3GetMultisigOrders
        ? 'v3'
        : 'tonapi';
    final canned = path == 'v3' ? v3Orders : tonApiMultisig;
    return request.onResponse(canned as SERVICERESPONSE);
  }

  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TonRequestDetails> request, {
    Duration? timeout,
  }) {
    throw UnimplementedError();
  }
}

void multisigOrdersTest() {
  group('TonQuickClientApi.getMultisigOrders', () {
    // Real testnet response for order 0 of multisig
    // 0QApDSAvCqK9ko-6xU7iYV3AuIQ1bbXifvqLpPvp816NRS70 (trimmed book).
    final v3 = {
      'orders': [
        {
          'address':
              '0:0AD27C3D43AF70BDFEF8A99B5AB35C4EA7CEAD7ABFC4B16F68B7D8F5BACB3583',
          'multisig_address':
              '0:290D202F0AA2BD928FBAC54EE2615DC0B884356DB5E27EFA8BA4FBE9F35E8D45',
          'order_seqno': '0',
          'threshold': 2,
          'sent_for_execution': true,
          'approvals_mask': '3',
          'approvals_num': 2,
          'expiration_date': 1793786388,
          'order_boc':
              'te6ccgEBAwEAQQABAdEBAQrxOB5bAQIAZkIAfXGRbM2gkxLJLLrpsqXEJWt2sqMUEeOmEn9QLVTMEcOYehIAAAAAAAAAAAAAAAAAAA==',
          'signers': [
            '0:FAE322D99B412625925975D3654B884AD6ED65462823C74C24FEA05AA9982387',
            '0:5185FA3A64DC2346B792026C4B9209ED397110E7EFFBA234770E71198B950465',
            '0:CC676B7C31B6778885708EAD98B2B3A618628B48FCF5DDB6218AC91916BCB426'
          ],
          'last_transaction_lt': '107289469000003',
        }
      ],
      'address_book': {},
    };
    final multisig =
        TonAddress('0QApDSAvCqK9ko-6xU7iYV3AuIQ1bbXifvqLpPvp816NRS70');

    test('tonCenter v3 response maps to order info', () async {
      final quick = DefaultTonQuickClient(
        provider: _CannedProvider(v3Orders: v3, tonApiMultisig: const {}),
        availableProviders: const [TonApiType.tonCenter],
      );
      final orders = await quick.getMultisigOrders(multisig: multisig);
      expect(orders, hasLength(1));
      final info = orders[0];
      expect(
          info.address.address,
          '0:0AD27C3D43AF70BDFEF8A99B5AB35C4EA7CEAD7ABFC4B16F68B7D8F5BACB3583');
      expect(info.state.orderSeqno, BigInt.zero);
      expect(info.state.threshold, 2);
      expect(info.state.executed, isTrue);
      expect(info.state.approvals, BigInt.from(3));
      expect(info.state.approvalsNum, 2);
      expect(info.state.expirationDate, BigInt.from(1793786388));
      expect(
          info.state.signers.map((e) => e.address).toList(),
          orderedEquals([
            '0:FAE322D99B412625925975D3654B884AD6ED65462823C74C24FEA05AA9982387',
            '0:5185FA3A64DC2346B792026C4B9209ED397110E7EFFBA234770E71198B950465',
            '0:CC676B7C31B6778885708EAD98B2B3A618628B48FCF5DDB6218AC91916BCB426',
          ]));
    });

    test('tonApi response maps signedBy to approvals mask', () async {
      const signerA =
          '0:FAE322D99B412625925975D3654B884AD6ED65462823C74C24FEA05AA9982387';
      const signerB =
          '0:5185FA3A64DC2346B792026C4B9209ED397110E7EFFBA234770E71198B950465';
      final tonApi = {
        'address': multisig.address,
        'seqno': '6',
        'threshold': 2,
        'signers': [signerA, signerB],
        'proposers': [signerA],
        'orders': [
          {
            'address':
                '0:0AD27C3D43AF70BDFEF8A99B5AB35C4EA7CEAD7ABFC4B16F68B7D8F5BACB3583',
            'approvals_num': 1,
            'creation_date': '1793700000000',
            'expiration_date': '1793786388',
            'multisig_address': multisig.address,
            'order_seqno': '5',
            'risk': {
              'gram': '0',
              'jettons': [],
              'nfts': [],
              'transfer_all_remaining_balance': false,
            },
            'sent_for_execution': false,
            'signed_by': [signerB],
            'signers': [signerA, signerB],
            'threshold': 2,
          }
        ],
      };
      final quick = DefaultTonQuickClient(
        provider: _CannedProvider(v3Orders: const {}, tonApiMultisig: tonApi),
        availableProviders: const [TonApiType.tonApi],
      );
      final orders = await quick.getMultisigOrders(multisig: multisig);
      expect(orders, hasLength(1));
      final info = orders[0];
      expect(info.state.orderSeqno, BigInt.from(5));
      expect(info.state.threshold, 2);
      expect(info.state.executed, isFalse);
      // signerB is index 1, so the mask is bit 1.
      expect(info.state.approvals, BigInt.two);
      expect(info.state.approvalsNum, 1);
      expect(info.state.expirationDate, BigInt.from(1793786388));
      expect(info.state.signers.map((e) => e.address).toList(),
          hasLength(2));
    });

    test('empty indexer response yields no orders', () async {
      final quick = DefaultTonQuickClient(
        provider: _CannedProvider(
            v3Orders: const {'orders': []}, tonApiMultisig: const {}),
        availableProviders: const [TonApiType.tonCenter],
      );
      expect(await quick.getMultisigOrders(multisig: multisig), isEmpty);
    });
  });
}

void main() {
  TonTestApi.runTest(multisigOrdersTest, 'Multisig Orders');
}
