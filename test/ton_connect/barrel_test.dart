import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';
import '../utils.dart';

/// Public-surface gate: every ton_connect layer reachable from the
/// package barrel (catches export drift after refactors).
void barrelTest() {
  test('barrel exposes ton_connect layers', () {
    // Phase 1: models + exception.
    expect(TonPostMessageParams.maxTtl, 300);
    // Phase 2: SSE parser.
    expect(TonSseParser().lastId, isNull);
    // Phase 3: requests.
    expect(
      TonConnectEventsRequest(clientId: TonConnectClientId('00' * 32).value)
          .clientId,
      '00' * 32,
    );
    // Phase 4: provider types.
    expect(TonConnectBridgeProvider.isRetriableStatus(429), isTrue);
    // Phase 5: connect + link.
    expect(TonDeviceInfo.maxProtocolVersion, 2);
    expect(TonConnectLink.protocolVersion, 2);
    // Phase 6: RPC.
    expect(TonRpcMethod.sendTransaction, 'sendTransaction');
    expect(TonRequestIdTracker().accept('1'), isTrue);
  });
}

void main() {
  TonTestApi.runTest(barrelTest, 'Barrel');
}
