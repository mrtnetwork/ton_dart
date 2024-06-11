import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/models/models/account_storage.dart';
import 'package:ton_dart/src/models/models/storage_info.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L231
/// account_none$0 = Account;
/// account$1 addr:MsgAddressInt storage_stat:StorageInfo storage:AccountStorage = Account;
class TonAccount extends TonSerialization {
  final TonAddress addr;
  final StorageInfo storageStats;
  final AccountStorage storage;
  const TonAccount(
      {required this.addr, required this.storageStats, required this.storage});

  factory TonAccount.deserialize(Slice slice) {
    return TonAccount(
      addr: slice.loadAddress(),
      storageStats: StorageInfo.deserialize(slice),
      storage: AccountStorage.deserialize(slice),
    );
  }
  factory TonAccount.fromJson(Map<String, dynamic> json) {
    return TonAccount(
      addr: TonAddress(json["addr"]),
      storageStats: StorageInfo.fromJson(json["storage_stats"]),
      storage: AccountStorage.fromJson(json["storage"]),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeAddress(addr);
    storageStats.store(builder);
    storage.store(builder);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "storage_stats": storageStats.toJson(),
      "addr": addr.toRawAddress(),
      "storage": storage.toJson()
    };
  }
}
