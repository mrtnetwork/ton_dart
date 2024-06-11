import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/models/models/storage_used_short.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_status_change.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L310
/// tr_phase_action$_ success:Bool valid:Bool no_funds:Bool
///   status_change:AccStatusChange
///   total_fwd_fees:(Maybe Grams) total_action_fees:(Maybe Grams)
///   result_code:int32 result_arg:(Maybe int32) tot_actions:uint16
///   spec_actions:uint16 skipped_actions:uint16 msgs_created:uint16
///   action_list_hash:bits256 tot_msg_size:StorageUsedShort
///   = TrActionPhase;
class TransactionActionPhase extends TonSerialization {
  final bool success;
  final bool valid;
  final bool noFunds;
  final AccountStatusChange statusChange;
  final BigInt? totalFwdFees;
  final BigInt? totalActionFees;
  final int resultCode;
  final int? resultArg;
  final int totalActions;
  final int specActions;
  final int skippedActions;
  final int messagesCreated;
  final BigInt actionListHash;
  final StorageUsedShort totalMessageSize;
  const TransactionActionPhase(
      {required this.success,
      required this.valid,
      required this.noFunds,
      required this.statusChange,
      required this.totalFwdFees,
      required this.totalActionFees,
      required this.resultCode,
      required this.resultArg,
      required this.totalActions,
      required this.specActions,
      required this.skippedActions,
      required this.messagesCreated,
      required this.actionListHash,
      required this.totalMessageSize});
  factory TransactionActionPhase.deserialize(Slice slice) {
    return TransactionActionPhase(
      success: slice.loadBit(),
      valid: slice.loadBit(),
      noFunds: slice.loadBit(),
      statusChange: AccountStatusChange.deserialize(slice),
      totalFwdFees: slice.loadBit() ? slice.loadCoins() : null,
      totalActionFees: slice.loadBit() ? slice.loadCoins() : null,
      resultCode: slice.loadInt(32),
      resultArg: slice.loadBit() ? slice.loadInt(32) : null,
      totalActions: slice.loadUint(16),
      specActions: slice.loadUint(16),
      skippedActions: slice.loadUint(16),
      messagesCreated: slice.loadUint(16),
      actionListHash: slice.loadUintBig(256),
      totalMessageSize: StorageUsedShort.deserialize(slice),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeBitBolean(success);
    builder.storeBitBolean(valid);
    builder.storeBitBolean(noFunds);
    statusChange.store(builder);
    builder.storeMaybeCoins(totalFwdFees);
    builder.storeMaybeCoins(totalActionFees);
    builder.storeInt(resultCode, 32);
    builder.storeMaybeInt(resultArg, 32);
    builder.storeUint(totalActions, 16);
    builder.storeUint(specActions, 16);
    builder.storeUint(skippedActions, 16);
    builder.storeUint(messagesCreated, 16);
    builder.storeUint(actionListHash, 256);
    totalMessageSize.store(builder);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "valid": valid,
      "no_funds": noFunds,
      "status_change": statusChange.toJson(),
      "total_fwd_fees": totalFwdFees?.toString(),
      "total_action_fees": totalActionFees?.toString(),
      "result_code": resultCode,
      "result_arg": resultArg,
      "total_actions": totalActions,
      "spec_actions": specActions,
      "skipped_actions": skippedActions,
      "messages_created": messagesCreated,
      "action_list_hash": actionListHash.toString(),
      "total_message_size": totalMessageSize.toJson()
    };
  }

  factory TransactionActionPhase.fromJson(Map<String, dynamic> json) {
    return TransactionActionPhase(
      success: json["success"],
      valid: json["valid"],
      noFunds: json["no_funds"],
      statusChange: AccountStatusChange.fromJson(json["status_change"]),
      totalFwdFees: BigintUtils.tryParse(json["total_fwd_fees"]),
      totalActionFees: BigintUtils.tryParse(json["total_action_fees"]),
      resultCode: json["result_code"],
      resultArg: json["result_arg"],
      totalActions: json["total_actions"],
      specActions: json["spec_actions"],
      skippedActions: json["skipped_actions"],
      messagesCreated: json["messages_created"],
      actionListHash: BigintUtils.parse(json["action_list_hash"]),
      totalMessageSize: StorageUsedShort.fromJson(json["total_message_size"]),
    );
  }
}
