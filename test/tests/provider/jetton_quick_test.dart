import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/provider/generated/tonapi/tonapi_models.dart';
import 'package:ton_dart/src/provider/generated/tonapi/tonapi_requests.dart';
import 'package:ton_dart/ton_dart.dart';
import '../../utils.dart';

/// Offline tests for the swap-parity quick calls (fake provider, no network).
void jettonQuickTest() {
  final owner = TonAddress('0:${'11' * 32}');
  final jettonMaster = TonAddress('0:${'22' * 32}');

  MethodExecutionResult execResult({
    required List<TvmStackRecord> stack,
    int exitCode = 0,
  }) {
    return MethodExecutionResult(
      exitCode: exitCode,
      stack: stack,
      success: exitCode == 0,
    );
  }

  TvmStackRecord numRecord(String value) {
    return TvmStackRecord(num_: value, type: TvmStackRecordType.num_);
  }

  TvmStackRecord cellRecord(String value) {
    return TvmStackRecord(cell: value, type: TvmStackRecordType.cell);
  }

  TonQuickClient quickWith(
    Map<Type, MethodExecutionResult Function()> handlers,
  ) {
    return DefaultTonQuickClient(
      provider: _CannedProvider(handlers),
      availableProviders: const [TonApiType.tonApi],
    );
  }

  test('getJettonWalletAddress reads the address cell', () async {
    final walletCell = beginCell().storeAddress(owner).endCell().toBase64();
    final quick = quickWith({
      TonApiExecGetMethodForBlockchainAccount:
          () => execResult(stack: [cellRecord(walletCell)]),
    });
    final wallet = await quick.getJettonWalletAddress(
      owner: owner,
      jettonMaster: jettonMaster,
    );
    expect(wallet, owner);
  });

  test('getJettonWalletAddress throws on non-zero exit code', () async {
    final quick = quickWith({
      TonApiExecGetMethodForBlockchainAccount:
          () => execResult(stack: const [], exitCode: 1),
    });
    await expectLater(
      quick.getJettonWalletAddress(owner: owner, jettonMaster: jettonMaster),
      throwsA(isA<BuError>()),
    );
  });

  test('getJettonBalance reads the first stack number', () async {
    final quick = quickWith({
      TonApiExecGetMethodForBlockchainAccount:
          () => execResult(stack: [numRecord('250')]),
    });
    expect(await quick.getJettonBalance(jettonWallet: owner), BigInt.from(250));
  });

  test('getWalletSeqno reads the seqno number', () async {
    final quick = quickWith({
      TonApiExecGetMethodForBlockchainAccount:
          () => execResult(stack: [numRecord('41')]),
    });
    expect(await quick.getWalletSeqno(owner), 41);
  });

  test('trackWalletSeqno completes and times out', () async {
    var seqno = 41;
    final quick = quickWith({
      TonApiExecGetMethodForBlockchainAccount: () {
        seqno += 1;
        return execResult(stack: [numRecord('$seqno')]);
      },
    });
    await quick.trackWalletSeqno(
      account: owner,
      seqno: 42,
      periodicTimeOut: const Duration(milliseconds: 1),
    );
    expect(seqno, greaterThan(42));

    final stuck = quickWith({
      TonApiExecGetMethodForBlockchainAccount:
          () => execResult(stack: [numRecord('41')]),
    });
    await expectLater(
      stuck.trackWalletSeqno(
        account: owner,
        seqno: 42,
        timeout: const Duration(milliseconds: 20),
        periodicTimeOut: const Duration(milliseconds: 1),
      ),
      throwsA(isA<BuError>()),
    );
  });
}

/// Canned provider serving one fixed execution result per request type.
class _CannedProvider
    implements IProvider<IServiceProvider, TonRequestDetails> {
  final Map<Type, MethodExecutionResult Function()> handlers;
  _CannedProvider(this.handlers);

  @override
  IServiceProvider get service => throw UnimplementedError();

  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TonRequestDetails> request, {
    Duration? timeout,
  }) async {
    final handler = handlers[request.runtimeType];
    if (handler == null) {
      throw StateError('Unexpected request ${request.runtimeType}');
    }
    return handler() as RESULT;
  }

  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TonRequestDetails> request, {
    Duration? timeout,
  }) {
    throw UnimplementedError();
  }
}

void main() {
  TonTestApi.runTest(jettonQuickTest, 'Jetton Quick');
}
