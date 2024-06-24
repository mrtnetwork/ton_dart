// export type StorageInfo = {
//     used: StorageUsed;
//     lastPaid: number;
//     duePayment?: Maybe<bigint>;
// }
import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'storage_used.dart';

class StorageInfo extends TonSerialization {
  final StorageUsed used;
  final int lastPaid;
  final BigInt? duePayment;
  const StorageInfo(
      {required this.used, required this.lastPaid, this.duePayment});
  factory StorageInfo.deserialize(Slice slice) {
    return StorageInfo(
        used: StorageUsed.deserialize(slice),
        lastPaid: slice.loadUint(32),
        duePayment: slice.loadMaybeCoins());
  }
  factory StorageInfo.fromJson(Map<String, dynamic> json) {
    return StorageInfo(
        used: StorageUsed.fromJson(json["used"]),
        lastPaid: json["lastPaid"],
        duePayment: BigintUtils.tryParse(json["duePayment"]));
  }

  @override
  void store(Builder builder) {
    used.store(builder);
    builder.storeUint(lastPaid, 32);
    builder.storeMaybeCoins(duePayment);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "used": used.toJson(),
      "lastPaid": lastPaid,
      "duePayment": duePayment?.toString()
    };
  }
}
