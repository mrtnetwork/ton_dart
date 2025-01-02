import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/models/models/account_status_change.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L284
/// tr_phase_storage$_ storage_fees_collected:Grams
///   storage_fees_due:(Maybe Grams)
///   status_change:AccStatusChange
///   = TrStoragePhase;
class TransactionStoragePhase extends TonSerialization {
  final BigInt storageFeesCollected;
  final BigInt? storageFeesDue;
  final AccountStatusChange statusChange;
  const TransactionStoragePhase(
      {required this.storageFeesCollected,
      required this.storageFeesDue,
      required this.statusChange});
  factory TransactionStoragePhase.deserialize(Slice slice) {
    return TransactionStoragePhase(
        storageFeesCollected: slice.loadCoins(),
        storageFeesDue: slice.loadBit().onTrue(() => slice.loadCoins()),
        statusChange: AccountStatusChange.deserialize(slice));
  }
  factory TransactionStoragePhase.fromJson(Map<String, dynamic> json) {
    return TransactionStoragePhase(
        storageFeesCollected: BigintUtils.parse(json['storage_fees_collected']),
        storageFeesDue: BigintUtils.tryParse(json['storage_fees_due']),
        statusChange: AccountStatusChange.fromJson(json['status_change']));
  }

  @override
  void store(Builder builder) {
    builder.storeCoins(storageFeesCollected);
    builder.storeBitBolean(storageFeesDue != null);
    if (storageFeesDue != null) {
      builder.storeCoins(storageFeesDue);
    }
    statusChange.store(builder);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'status_change': statusChange.toJson(),
      'storage_fees_due': storageFeesDue?.toString(),
      'storage_fees_collected': storageFeesCollected.toString()
    };
  }
}
