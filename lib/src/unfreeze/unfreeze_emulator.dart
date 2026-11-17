import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/unfreeze/unfreeze_types.dart';

/// Slow path for [UnfreezeService.getStateForUnfreeze].
///
/// The fast path reads the pre-freeze `StateInit` directly from the
/// `ShardAccount` at `unfreezeBlock`. That snapshot only exists at
/// masterchain block boundaries, so it misses when the freeze transaction
/// shares a shard block with the account's previous transaction. In that
/// case the state must be rebuilt by replaying the in-block predecessors
/// in a TVM transaction emulator (see `recoverStateInitViaEmulation` in
/// `unfreeze/state-recovery.ts`, backed by `prepareEmulator` from
/// `retracer-core` / `@ton/sandbox`).
///
/// There is no pure-Dart emulator; implement this backend against a
/// self-hosted `retracer-core` replay server (or equivalent). The public
/// Toncenter emulate API and TonAPI emulation endpoints only simulate new
/// messages on current state and cannot replay historical chains, so they
/// cannot implement this interface.
abstract class UnfreezeEmulatorBackend {
  /// Replays the in-block predecessors of [freezeTx] and returns the
  /// `StateInit` cell active right before the freeze, or `null` when the
  /// state cannot be rebuilt.
  Future<Cell?> recoverStateInit({
    required TonAddress address,
    required FreezeTxRef freezeTx,
  });
}
