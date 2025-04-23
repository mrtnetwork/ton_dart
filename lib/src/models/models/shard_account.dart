import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/account.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L256
/// account_descr$_ account:^Account last_trans_hash:bits256
/// last_trans_lt:uint64 = ShardAccount;
class ShardAccount extends TonSerialization {
  /// The TonAccount associated with the shard account. It may be `null`.
  final TonAccount? account;

  /// The hash of the last transaction in this shard account.
  final BigInt lastTransactionHash;

  /// The logical time (LT) of the last transaction in this shard account.
  final BigInt lastTransactionLt;
  const ShardAccount(
      {this.account,
      required this.lastTransactionHash,
      required this.lastTransactionLt});
  factory ShardAccount.deserialize(Slice slice) {
    final accountRef = slice.loadRef();
    TonAccount? account;
    if (!accountRef.isExotic) {
      final accountSlice = accountRef.beginParse();
      if (accountSlice.loadBit()) {
        account = TonAccount.deserialize(accountSlice);
      }
    }
    return ShardAccount(
      account: account,
      lastTransactionHash: slice.loadUintBig(256),
      lastTransactionLt: slice.loadUintBig(64),
    );
  }
  factory ShardAccount.fromJson(Map<String, dynamic> json) {
    return ShardAccount(
      account: (json['account'] as Object?)?.convertTo<TonAccount, Map>(
          (result) => TonAccount.fromJson(result.cast())),
      lastTransactionHash: BigintUtils.parse(json['last_transaction_hash']),
      lastTransactionLt: BigintUtils.parse(json['last_transaction_lt']),
    );
  }

  @override
  void store(Builder builder) {
    final accountCell = beginCell();
    if (account != null) {
      accountCell.storeBitBolean(true);
      account?.store(accountCell);
    } else {
      accountCell.storeBitBolean(false);
    }
    builder.storeRef(accountCell.endCell());
    builder.storeUint(lastTransactionHash, 256);
    builder.storeUint(lastTransactionLt, 64);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'account': account?.toJson(),
      'last_transaction_hash': lastTransactionHash.toString(),
      'last_transaction_lt': lastTransactionLt.toString()
    };
  }
}
