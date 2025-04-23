import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

import 'account_state.dart';
import 'currency_collection.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L235
/// account_storage$_ last_trans_lt:uint64 balance:CurrencyCollection state:AccountState
///   = AccountStorage;
class AccountStorage extends TonSerialization {
  /// The last transaction's logical time (LT).
  final BigInt lastTransLt;

  /// The balance of the account, represented by a collection of currencies.
  final CurrencyCollection balance;

  /// The state of the account, which could be uninitialized, active, etc.
  final AccountState state;
  const AccountStorage(
      {required this.lastTransLt, required this.balance, required this.state});
  factory AccountStorage.deserialize(Slice slice) {
    return AccountStorage(
      lastTransLt: slice.loadUintBig(64),
      balance: CurrencyCollection.deserialize(slice),
      state: AccountState.deserialize(slice),
    );
  }
  factory AccountStorage.fromJson(Map<String, dynamic> json) {
    return AccountStorage(
      lastTransLt: BigintUtils.parse(json['last_trans_lt']),
      balance: CurrencyCollection.fromJson(json['balance']),
      state: AccountState.fromJson(json['state']),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeUint(lastTransLt, 64);
    balance.store(builder);
    state.store(builder);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'last_trans_lt': lastTransLt.toString(),
      'balance': balance.toJson(),
      'state': state.toJson()
    };
  }
}
