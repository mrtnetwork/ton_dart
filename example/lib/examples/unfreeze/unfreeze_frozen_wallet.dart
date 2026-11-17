// Unfreeze a frozen v1r1 wallet on testnet (ports ton-blockchain/unfreezer).
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' as http;
import 'package:ton_dart/ton_dart.dart';

/// Testnet endpoint + public test key (rate-limited). Replace with your own
/// key from https://toncenter.com for real usage.
const _tonCenterUrl = 'https://testnet.toncenter.com';
const _tonCenterKey =
    'd3800f756738ac7b39599914b8a84465960ff869f555c2317664c9a62529baf3';

/// Frozen wallet v1r1 from the wallet examples (testnet).
const _frozenAddress = 'kf9serWJThPWFoZqR5ad3GSjWsGmY8I_8d3IQuKOyIlODJlh';

class _TestnetService with TonServiceProvider {
  _TestnetService({http.Client? client}) : client = client ?? http.Client();
  final http.Client client;

  @override
  final TonApiType api = TonApiType.tonCenter;

  @override
  Future<BaseServiceResponse> doRequest(
    TonRequestDetails params, {
    Duration? timeout,
  }) async {
    final uri = params.encodeUrl(_tonCenterUrl);
    final headers = {...params.headers, 'X-API-Key': _tonCenterKey};
    final response = params.requestMethod.isPost
        ? await client
            .post(uri, headers: headers, body: params.encodeBody())
            .timeout(timeout ?? const Duration(seconds: 30))
        : await client
            .get(uri, headers: headers)
            .timeout(timeout ?? const Duration(seconds: 30));
    return params.toResponse(
      response.bodyBytes,
      statusCode: response.statusCode,
    );
  }
}

/// Quick client with the unfreeze calls mixed in.
class _DemoClient extends DefaultTonQuickClient with TonUnfreezeQuickClientApi {
  _DemoClient({required super.provider});
}

Future<void> main() async {
  blockchainUtils.setDartApi();
  final provider = TonProvider(_TestnetService(), TonApiType.tonCenter);
  final client = _DemoClient(provider: provider);
  final address = TonAddress(_frozenAddress);

  // 1. The account is frozen; `frozen_hash` is the StateInit hash the
  // unfreeze message must reproduce.
  final frozen = await client.unfreezeService.fetchFrozenHash(address);
  if (frozen == null) {
    print('Account is not frozen, nothing to unfreeze.');
    return;
  }
  print(
    'frozen_hash: ${StringUtils.decode(frozen, encoding: StringEncoding.base64)}',
  );

  // 2. Binary-search the v3 transaction history for the freeze boundary.
  final found = await client.findUnfreezeBlock(
    address,
    frozen,
    onProgress: (step, [detail]) =>
        print('freeze-search: $step ${detail ?? ''}'),
  );
  if (found == null) {
    print('No usable unfreeze block found.');
    return;
  }
  print('unfreezeBlock: ${found.unfreezeBlock}');
  print('freezeTx: ${found.freezeTx.toJson()}');

  // 3. Fast path: read the pre-freeze StateInit at the unfreeze block.
  // Testnet v2 only keeps a shallow archive, so very old blocks may be
  // pruned (`LITE_SERVER_NOTREADY ... seqno not in db`). On mainnet (or a
  // recent freeze) this returns the StateInit with no error.
  try {
    final state = await client.getStateForUnfreeze(
      address: address,
      unfreezeBlock: found.unfreezeBlock,
      stateInitHashToMatch: frozen,
      freezeTx: found.freezeTx,
      onProgress: (step, [detail]) =>
          print('state-recovery: $step ${detail ?? ''}'),
    );
    print('stateInitHash: ${state.stateInitHashBase64}');
    print('sizeBytes: ${state.sizeBytes}');
    if (state.error != null) {
      print('error: ${state.error}');
      return;
    }
    print('StateInit recovered, ready to send with the unfreeze message.');
    print('stateInitBoc: ${state.stateInitBocBase64}');
  } on RPCError catch (e) {
    print('StateInit fetch failed (historical block pruned?): $e');
  }
}
