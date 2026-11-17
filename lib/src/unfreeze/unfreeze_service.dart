import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/generated/toncenter/toncenter_models.dart'
    as toncenter;
import 'package:ton_dart/src/provider/generated/toncenter/toncenter_requests.dart'
    as toncenter;
import 'package:ton_dart/src/provider/generated/toncenter_v3/toncenter_v3_models.dart'
    as v3models;
import 'package:ton_dart/src/provider/generated/toncenter_v3/toncenter_v3_requests.dart'
    as v3requests;
import 'package:ton_dart/src/unfreeze/unfreeze_emulator.dart';
import 'package:ton_dart/src/unfreeze/unfreeze_types.dart';
import 'package:ton_dart/src/utils/utils/base64.dart';

/// Unfreeze helper ported from `unfreeze/` of
/// `ton-blockchain/unfreezer`.
///
/// Only the fast path runs locally: the pre-freeze `StateInit` is read
/// directly from the `ShardAccount` at [getStateForUnfreeze]'s
/// `unfreezeBlock`. The slow path (replaying in-block predecessors in a
/// TVM emulator) is delegated to [UnfreezeEmulatorBackend] because
/// `ton_dart` ships no transaction emulator.
///
/// All byte payloads are [BuBytes]. Encoding and
/// hashing reuse `blockchain_utils` (`BytesUtils`, `StringUtils`,
/// `Base64Utils`) and `ton_dart` cell primitives — no new crypto is
/// introduced.
class UnfreezeService {
  /// Provider used for toncenter v2/v3 reads. Must serve `TonApiType.tonCenter`.
  final IProvider<IServiceProvider, TonRequestDetails> provider;

  const UnfreezeService(this.provider);

  /// Hard cap on the `StateInit` carried by the unfreeze message.
  ///
  /// The unfreeze message is broadcast as an external message, capped by
  /// config param 43 (`max_ext_msg_size` = 65535 bytes). ~1.5KB margin is
  /// kept for the wallet envelope.
  static const int maxStateInitBytes = 64000;

  static const int _freezeSearchMaxSteps = 48;
  static const int _freezeSearchMaxWalkBack = 64;

  /// Loads the parsed `ShardAccount` at [seqno] (`latest` when omitted).
  Future<ShardAccount> getShardAccount(TonAddress address, {int? seqno}) async {
    final res = await provider.request(
      toncenter.TonCenterGetShardAccountCellPost(
        address: address.toRawAddress(),
        seqno:
            seqno == null
                ? null
                : toncenter.AddressWithSeqnoRequestSeqnoInteger(seqno),
      ),
    );
    final cell = Cell.fromBase64(res.bytes);
    return ShardAccount.deserialize(cell.beginParse());
  }

  /// Returns the raw 32-byte `frozen_hash` of a frozen account, or `null`.
  Future<BuBytes?> fetchFrozenHash(TonAddress address) async {
    final info = await provider.request(
      toncenter.TonCenterGetAddressInformationPost(
        address: address.toRawAddress(),
      ),
    );
    if (info.state != toncenter.AccountStateEnum.frozen) return null;
    return _decodeHashBytes(info.frozenHash);
  }

  /// Recovers the pre-freeze `StateInit` (fast path, optional slow path).
  ///
  /// [unfreezeBlock] is the masterchain seqno from [findUnfreezeBlock].
  /// [stateInitHashToMatch] verifies the result against `frozen_hash`.
  /// [freezeTx] + [emulator] enable the emulation fallback when the fast
  /// path misses (state never existed at a masterchain block boundary).
  Future<UnfreezeState> getStateForUnfreeze({
    required TonAddress address,
    required int unfreezeBlock,
    BuBytes? stateInitHashToMatch,
    FreezeTxRef? freezeTx,
    UnfreezeEmulatorBackend? emulator,
    UnfreezeProgressCallback? onProgress,
  }) async {
    onProgress?.call(
      'Building StateInit',
      'Fetching state at block $unfreezeBlock',
    );
    final shardAccount = await getShardAccount(address, seqno: unfreezeBlock);
    final accountState = shardAccount.account?.storage.state;
    Cell? stateInitCell;
    if (accountState is AccountStateActive) {
      stateInitCell = beginCell().store(accountState.state).endCell();
    }

    final fastPathOk =
        stateInitCell != null &&
        (stateInitHashToMatch == null ||
            BytesUtils.bytesEqual(
              BytesUtils.toBytes(stateInitCell.hash()),
              stateInitHashToMatch,
            ));
    if (!fastPathOk && freezeTx != null && emulator != null) {
      onProgress?.call(
        'Building StateInit',
        'Replaying in-block transactions in emulator',
      );
      try {
        final recovered = await emulator.recoverStateInit(
          address: address,
          freezeTx: freezeTx,
        );
        if (recovered != null) stateInitCell = recovered;
      } catch (_) {
        // Keep the fast-path cell (if any); the mismatch is reported
        // through [UnfreezeState.error] below.
      }
    }

    if (stateInitCell == null) {
      return UnfreezeState(
        stateInitHash: BuBytes.empty(),
        stateInitBoc: BuBytes.empty(),
        stateInitCell: Cell(),
        sizeBytes: 0,
        error: 'Account is not active at specified block',
      );
    }

    final stateInitHash = BytesUtils.toBytes(stateInitCell.hash());
    final stateInitBoc = BytesUtils.toBytes(stateInitCell.toBoc());
    final sizeBytes = stateInitBoc.length;
    String? error;
    if (stateInitHashToMatch != null &&
        !BytesUtils.bytesEqual(stateInitHash, stateInitHashToMatch)) {
      error =
          'Hash mismatch: expected ${StringUtils.decode(stateInitHashToMatch, encoding: StringEncoding.base64)}, got ${StringUtils.decode(stateInitHash, encoding: StringEncoding.base64)}';
    }
    if (sizeBytes > maxStateInitBytes) {
      error =
          'State init too big to send from a wallet: ${(sizeBytes / 1024).toStringAsFixed(1)} KB, external message limit is 64 KB';
    }
    return UnfreezeState(
      stateInitHash: stateInitHash,
      stateInitBoc: stateInitBoc,
      stateInitCell: stateInitCell,
      sizeBytes: sizeBytes,
      error: error,
    );
  }

  /// Finds the unfreeze block via toncenter v3 binary search over tx time.
  ///
  /// Ports `findUnfreezeBlock` from `unfreeze/freeze-search.ts`. Returns
  /// `null` when no usable boundary exists.
  Future<FreezeSearchResult?> findUnfreezeBlock(
    TonAddress address,
    BuBytes frozenHash, {
    UnfreezeProgressCallback? onProgress,
  }) async {
    bool isTarget(v3models.Transaction tx) =>
        tx.endStatus == 'frozen' &&
        _hashEquals(
          _decodeHashBytes(tx.accountStateAfter?.frozenHash),
          frozenHash,
        );
    bool isTargetOrNull(v3models.Transaction tx) {
      if (tx.endStatus != 'frozen') return false;
      final hash = _decodeHashBytes(tx.accountStateAfter?.frozenHash);
      return hash == null || BytesUtils.bytesEqual(hash, frozenHash);
    }

    onProgress?.call(
      'Searching for freeze transaction',
      'Fetching transaction bounds',
    );
    final rawAddress = address.toRawAddress();
    final first = await _v3Transaction(rawAddress, sort: 'asc');
    final last = await _v3Transaction(rawAddress, sort: 'desc');
    if (first == null || last == null || !isTargetOrNull(last)) return null;
    final firstNow = first.now;
    final lastNow = last.now;
    if (firstNow == null || lastNow == null) return null;

    var lo = firstNow - 1;
    var hi = lastNow;
    var candidate = last;

    for (var step = 1; lo < hi - 1; step++) {
      if (step > _freezeSearchMaxSteps) return null;
      onProgress?.call(
        'Searching for freeze transaction',
        'Binary search step $step',
      );
      final mid = (lo + hi) ~/ 2;
      final tx = await _v3Transaction(
        rawAddress,
        sort: 'desc',
        endUtime: mid.toString(),
      );
      if (tx == null) {
        lo = mid;
        continue;
      }
      if (isTarget(tx)) {
        candidate = tx;
        final now = tx.now;
        if (now == null) return null;
        hi = now;
        continue;
      }
      final txLt = BigintUtils.tryParse(tx.lt);
      if (txLt == null) return null;
      final next = await _v3Transaction(
        rawAddress,
        sort: 'asc',
        startLt: (txLt + BigInt.one).toString(),
      );
      if (next == null) return null;
      if (isTarget(next)) {
        candidate = next;
        if (next.origStatus != 'frozen') break;
        final now = next.now;
        if (now == null) return null;
        hi = now;
        continue;
      }
      final nextNow = next.now;
      if (nextNow == null) return null;
      lo = mid > nextNow ? mid : nextNow;
    }

    var freezeTx = candidate;
    for (var hops = 0; freezeTx.origStatus == 'frozen'; hops++) {
      if (hops > _freezeSearchMaxWalkBack) return null;
      onProgress?.call(
        'Searching for freeze transaction',
        'Walking back to the freeze transaction',
      );
      final prevLt = freezeTx.prevTransLt;
      if (prevLt == null || prevLt == '0') return null;
      final prevTx = await _v3Transaction(rawAddress, lt: prevLt);
      if (prevTx == null) return null;
      freezeTx = prevTx;
    }
    if (!isTargetOrNull(freezeTx) ||
        freezeTx.prevTransLt == null ||
        freezeTx.prevTransLt == '0') {
      return null;
    }

    onProgress?.call(
      'Searching for freeze transaction',
      'Locating last active block',
    );
    final prev = await _v3Transaction(rawAddress, lt: freezeTx.prevTransLt!);
    if (prev == null) return null;
    final prevMc = prev.mcBlockSeqno;
    final freezeMc = freezeTx.mcBlockSeqno;
    final freezeLt = BigintUtils.tryParse(freezeTx.lt);
    final freezeHash = _decodeHashBytes(freezeTx.hash);
    if (prevMc == null ||
        freezeMc == null ||
        freezeLt == null ||
        freezeHash == null) {
      return null;
    }
    final unfreezeBlock = prevMc >= freezeMc ? freezeMc - 1 : prevMc;
    return FreezeSearchResult(
      unfreezeBlock: unfreezeBlock,
      freezeTx: FreezeTxRef(lt: freezeLt, hash: freezeHash),
    );
  }

  Future<v3models.Transaction?> _v3Transaction(
    String rawAddress, {
    String? sort,
    String? endUtime,
    String? startLt,
    String? lt,
  }) async {
    final res = await provider.request(
      v3requests.TonCenterV3GetTransactions(
        account: rawAddress,
        sort: sort,
        limit: '1',
        endUtime: endUtime,
        startLt: startLt,
        lt: lt,
      ),
    );
    final txs = res.transactions;
    if (txs == null || txs.isEmpty) return null;
    return txs.first;
  }

  static bool _hashEquals(BuBytes? actual, BuBytes expected) {
    if (actual == null) return false;
    return BytesUtils.bytesEqual(actual, expected);
  }

  /// Decodes a toncenter hash spelling (base64, hex fallback) to raw bytes.
  static BuBytes? _decodeHashBytes(String? value) {
    if (value == null || value.isEmpty) return null;
    final fromB64 = BytesUtils.tryToBytes(
      _tryBase64(value),
      unmodifiable: false,
    );
    if (fromB64 != null && fromB64.length == 32) return fromB64;
    final fromHex = BytesUtils.tryFromHexString(value);
    if (fromHex != null && fromHex.length == 32) return fromHex;
    return fromB64;
  }

  static List<int>? _tryBase64(String value) {
    try {
      return Base64Utils.decodeBase64(value);
    } catch (_) {
      return null;
    }
  }
}
