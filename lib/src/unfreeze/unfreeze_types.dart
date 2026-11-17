import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/base64.dart';

/// Progress reporting for long unfreeze lookups.
///
/// Mirrors `ProgressCallback` in `unfreeze/types.ts`.
typedef UnfreezeProgressCallback = void Function(String step, [String? detail]);

/// Reference to the transaction that froze the account (toncenter v3 ids).
///
/// `hash` is the raw 32-byte transaction hash. Use [hashBase64] for the
/// base64 spelling used by the toncenter APIs.
class FreezeTxRef with JsonSerialization {
  /// Logical time of the freeze transaction, as a decimal integer.
  final BigInt lt;

  /// Raw 32-byte transaction hash.
  final BuBytes hash;

  const FreezeTxRef({required this.lt, required this.hash});

  /// Builds a ref from the toncenter v3 spellings (decimal `lt`, base64 `hash`).
  factory FreezeTxRef.fromV3({required String lt, required String hash}) {
    return FreezeTxRef(
      lt: BigintUtils.parse(lt),
      hash: BytesUtils.toBytes(Base64Utils.decodeBase64(hash)),
    );
  }

  /// Base64 spelling of [hash] (toncenter v3 format).
  String get hashBase64 =>
      StringUtils.decode(hash, encoding: StringEncoding.base64);

  /// Decimal spelling of [lt].
  String get ltString => lt.toString();

  @override
  Map<String, dynamic> toJson() {
    return {'lt': lt.toString(), 'hash': hashBase64};
  }
}

/// Result of [UnfreezeService.findUnfreezeBlock].
class FreezeSearchResult with JsonSerialization {
  /// Masterchain seqno whose state holds the pre-freeze `StateInit`.
  final int unfreezeBlock;

  /// The transaction that froze the account.
  final FreezeTxRef freezeTx;

  const FreezeSearchResult({
    required this.unfreezeBlock,
    required this.freezeTx,
  });

  @override
  Map<String, dynamic> toJson() {
    return {'unfreeze_block': unfreezeBlock, 'freeze_tx': freezeTx.toJson()};
  }
}

/// Recovered pre-freeze `StateInit`, ready to send with the unfreeze message.
///
/// Mirrors `StateForUnfreeze` in `unfreeze/types.ts`. Byte payloads are
/// [BuBytes]; [stateInitHashBase64] / [stateInitBocBase64] expose the
/// base64 spellings without using `toString()` for display.
class UnfreezeState with JsonSerialization {
  /// Raw 32-byte `StateInit` hash (`stateInitCell.hash()`).
  final BuBytes stateInitHash;

  /// Raw BoC bytes of the `StateInit` cell.
  final BuBytes stateInitBoc;

  /// The `StateInit` cell itself.
  final Cell stateInitCell;

  /// BoC size in bytes.
  final int sizeBytes;

  /// When non-null, the recovered state must NOT be used as-is.
  final String? error;

  const UnfreezeState({
    required this.stateInitHash,
    required this.stateInitBoc,
    required this.stateInitCell,
    required this.sizeBytes,
    this.error,
  });

  /// BoC size in bits.
  int get sizeBits => sizeBytes * 8;

  /// Whether the state passed hash and size checks.
  bool get isOk => error == null;

  /// Base64 spelling of [stateInitHash].
  String get stateInitHashBase64 =>
      StringUtils.decode(stateInitHash, encoding: StringEncoding.base64);

  /// Base64 spelling of [stateInitBoc].
  String get stateInitBocBase64 =>
      StringUtils.decode(stateInitBoc, encoding: StringEncoding.base64);

  @override
  Map<String, dynamic> toJson() {
    return {
      'state_init_hash': stateInitHashBase64,
      'state_init_boc': stateInitBocBase64,
      'size_bits': sizeBits,
      'size_bytes': sizeBytes,
      'error': error,
    };
  }
}
