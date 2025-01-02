import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'currency_collection.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L259
/// depth_balance$_ split_depth:(#<= 30) balance:CurrencyCollection = DepthBalanceInfo;
class DepthBalanceInfo extends TonSerialization {
  final int splitDepth;
  final CurrencyCollection balance;
  const DepthBalanceInfo({required this.splitDepth, required this.balance});
  factory DepthBalanceInfo.deserialize(Slice slice) {
    return DepthBalanceInfo(
        splitDepth: slice.loadUint(5),
        balance: CurrencyCollection.deserialize(slice));
  }
  factory DepthBalanceInfo.fromJson(Map<String, dynamic> json) {
    return DepthBalanceInfo(
      splitDepth: json['split_depth'],
      balance: CurrencyCollection.fromJson(json['balance']),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeUint(splitDepth, 5);
    balance.store(builder);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'split_depth': splitDepth, 'balance': balance.toJson()};
  }
}
