import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extentions.dart';

import 'currency_collection.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L293
/// tr_phase_credit$_ due_fees_collected:(Maybe Grams)
/// credit:CurrencyCollection = TrCreditPhase;
class TransactionCreditPhase extends TonSerialization {
  final BigInt? dueFeesColelcted;
  final CurrencyCollection credit;
  const TransactionCreditPhase({this.dueFeesColelcted, required this.credit});
  factory TransactionCreditPhase.fromJson(Map<String, dynamic> json) {
    return TransactionCreditPhase(
      dueFeesColelcted: BigintUtils.tryParse(json["due_fees_colelcted"]),
      credit: CurrencyCollection.fromJson(json["credit"]),
    );
  }
  factory TransactionCreditPhase.deserialize(Slice slice) {
    final dueFeesColelcted = slice.loadBit().onTrue(() => slice.loadCoins());
    return TransactionCreditPhase(
      dueFeesColelcted: dueFeesColelcted,
      credit: CurrencyCollection.deserialize(slice),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeBitBolean(dueFeesColelcted != null);
    if (dueFeesColelcted != null) {
      builder.storeCoins(dueFeesColelcted);
    }
    credit.store(builder);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "due_fees_colelcted": dueFeesColelcted?.toString(),
      "credit": credit.toJson()
    };
  }
}
