import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/unfreeze/unfreeze_emulator.dart';
import 'package:ton_dart/src/unfreeze/unfreeze_service.dart';
import 'package:ton_dart/src/unfreeze/unfreeze_types.dart';

/// Quick client over [UnfreezeService] for toncenter-backed providers.
///
/// Requires a toncenter provider: unfreeze reads need v2
/// `getShardAccountCell` / `getAddressInformation` and v3 `transactions`.
/// Compose with [TonQuickClientApi] (which already exposes [provider]):
/// ```dart
/// class MyClient with TonQuickClientApi, TonUnfreezeQuickClientApi { ... }
/// ```
mixin TonUnfreezeQuickClientApi {
  /// Single provider serving every call (tonCenter required).
  IProvider<IServiceProvider, TonRequestDetails> get provider;

  /// Service bound to [provider].
  UnfreezeService get unfreezeService => UnfreezeService(provider);

  /// Loads the parsed `ShardAccount` at [seqno] (`latest` when omitted).
  Future<ShardAccountResponse> getUnfreezeShardAccount(
    TonAddress address, {
    int? seqno,
  }) async {
    final account = await unfreezeService.getShardAccount(
      address,
      seqno: seqno,
    );
    return ShardAccountResponse(account);
  }

  /// Finds the unfreeze block for a frozen account.
  Future<FreezeSearchResult?> findUnfreezeBlock(
    TonAddress address,
    BuBytes frozenHash, {
    UnfreezeProgressCallback? onProgress,
  }) {
    return unfreezeService.findUnfreezeBlock(
      address,
      frozenHash,
      onProgress: onProgress,
    );
  }

  /// Recovers the pre-freeze `StateInit` (fast path, optional slow path).
  Future<UnfreezeState> getStateForUnfreeze({
    required TonAddress address,
    required int unfreezeBlock,
    BuBytes? stateInitHashToMatch,
    FreezeTxRef? freezeTx,
    UnfreezeEmulatorBackend? emulator,
    UnfreezeProgressCallback? onProgress,
  }) {
    return unfreezeService.getStateForUnfreeze(
      address: address,
      unfreezeBlock: unfreezeBlock,
      stateInitHashToMatch: stateInitHashToMatch,
      freezeTx: freezeTx,
      emulator: emulator,
      onProgress: onProgress,
    );
  }
}

/// Minimal `ShardAccount` carrier for the quick client.
class ShardAccountResponse {
  final ShardAccount account;
  const ShardAccountResponse(this.account);
}
