import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'compute_skip_reason.dart';

class TransactionComputePhaseType {
  final String name;
  const TransactionComputePhaseType._(this.name);

  static const TransactionComputePhaseType skipped =
      TransactionComputePhaseType._("skipped");
  static const TransactionComputePhaseType vm =
      TransactionComputePhaseType._("vm");
  static const List<TransactionComputePhaseType> values = [skipped, vm];
  factory TransactionComputePhaseType.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw TonDartPluginException(
          "Cannot find TransactionComputePhaseType from provided name",
          details: {"name": name}),
    );
  }
  @override
  String toString() {
    return "TransactionComputePhaseType.$name";
  }
}

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L296
/// tr_phase_compute_skipped$0 reason:ComputeSkipReason
///   = TrComputePhase;
/// tr_phase_compute_vm$1 success:Bool msg_state_used:Bool
///   account_activated:Bool gas_fees:Grams
///   ^[ gas_used:(VarUInteger 7)
///      gas_limit:(VarUInteger 7) gas_credit:(Maybe (VarUInteger 3))
///      mode:int8 exit_code:int32 exit_arg:(Maybe int32)
///      vm_steps:uint32
///      vm_init_state_hash:bits256 vm_final_state_hash:bits256 ]
///   = TrComputePhase;
abstract class TransactionComputePhase extends TonSerialization {
  abstract final TransactionComputePhaseType type;
  const TransactionComputePhase();

  factory TransactionComputePhase.deserialize(Slice slice) {
    if (!slice.loadBit()) {
      return TransactionComputeSkipped.deserialize(slice);
    }
    return TransactionComputeVm.deserialize(slice);
  }
  factory TransactionComputePhase.fromJson(Map<String, dynamic> json) {
    final type = TransactionComputePhaseType.fromValue(json["type"]);
    switch (type) {
      case TransactionComputePhaseType.vm:
        return TransactionComputeVm.fromJson(json);
      default:
        return TransactionComputeSkipped.fromJson(json);
    }
  }
}

class TransactionComputeVm extends TransactionComputePhase {
  final bool success;
  final bool messageStateUsed;
  final bool accountActivated;
  final BigInt gasFees;
  final BigInt gasUsed;
  final BigInt gasLimit;
  final BigInt? gasCredit;
  final int mode;
  final int exitCode;
  final int? exitArg;
  final int vmSteps;
  final BigInt vmInitStateHash;
  final BigInt vmFinalStateHash;
  const TransactionComputeVm(
      {required this.success,
      required this.messageStateUsed,
      required this.accountActivated,
      required this.gasFees,
      required this.gasUsed,
      required this.gasLimit,
      required this.gasCredit,
      required this.mode,
      required this.exitCode,
      required this.exitArg,
      required this.vmSteps,
      required this.vmInitStateHash,
      required this.vmFinalStateHash});
  factory TransactionComputeVm.deserialize(Slice slice) {
    final success = slice.loadBit();
    final messageStateUsed = slice.loadBit();
    final accountActivated = slice.loadBit();
    final gasFees = slice.loadCoins();

    final vmState = slice.loadRef().beginParse();
    final gasUsed = vmState.loadVarUintBig(3);
    final gasLimit = vmState.loadVarUintBig(3);
    final gasCredit = vmState.loadBit() ? vmState.loadVarUintBig(2) : null;
    final mode = vmState.loadUint(8);
    final exitCode = vmState.loadInt(32);
    final exitArg = vmState.loadBit() ? vmState.loadInt(32) : null;
    final vmSteps = vmState.loadUint(32);
    final vmInitStateHash = vmState.loadUintBig(256);
    final vmFinalStateHash = vmState.loadUintBig(256);
    return TransactionComputeVm(
        success: success,
        messageStateUsed: messageStateUsed,
        accountActivated: accountActivated,
        gasFees: gasFees,
        gasUsed: gasUsed,
        gasLimit: gasLimit,
        gasCredit: gasCredit,
        mode: mode,
        exitCode: exitCode,
        exitArg: exitArg,
        vmSteps: vmSteps,
        vmInitStateHash: vmInitStateHash,
        vmFinalStateHash: vmFinalStateHash);
  }
  factory TransactionComputeVm.fromJson(Map<String, dynamic> json) {
    return TransactionComputeVm(
        success: json["success"],
        messageStateUsed: json["message_state_used"],
        accountActivated: json["account_activated"],
        gasFees: BigintUtils.parse(json["gas_fees"]),
        gasUsed: BigintUtils.parse(json["gas_used"]),
        gasLimit: BigintUtils.parse(json["gas_limit"]),
        gasCredit: BigintUtils.tryParse(json["gas_credit"]),
        mode: json["mode"],
        exitCode: json["exit_code"],
        exitArg: json["exit_arg"],
        vmSteps: json["vm_steps"],
        vmInitStateHash: BigintUtils.parse(json["vm_init_state_hash"]),
        vmFinalStateHash: BigintUtils.parse(json["vm_final_state_hash"]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message_state_used": messageStateUsed,
      "account_activated": accountActivated,
      "gas_fees": gasFees.toString(),
      "gas_used": gasUsed.toString(),
      "gas_limit": gasLimit.toString(),
      "gas_credit": gasCredit?.toString(),
      "mode": mode,
      "exit_code": exitCode,
      "exit_arg": exitArg,
      "vm_steps": vmSteps,
      "vm_init_state_hash": vmInitStateHash.toString(),
      "vm_final_state_hash": vmFinalStateHash.toString(),
      "type": type.name
    };
  }

  @override
  void store(Builder builder) {
    builder.storeBit(1);
    builder.storeBitBolean(success);
    builder.storeBitBolean(messageStateUsed);
    builder.storeBitBolean(accountActivated);
    builder.storeCoins(gasFees);

    ///
    final ref = beginCell();
    ref.storeVarUint(gasUsed, 3);
    ref.storeVarUint(gasLimit, 3);
    if (gasCredit != null) {
      ref.storeBit(1);
      ref.storeVarUint(gasCredit, 2);
    } else {
      ref.storeBit(0);
    }
    ref.storeUint(mode, 8);
    ref.storeInt(exitCode, 32);
    if (exitArg != null) {
      ref.storeBit(1);
      ref.storeInt(exitArg, 32);
    } else {
      ref.storeBit(0);
    }
    ref.storeUint(vmSteps, 32);
    ref.storeUint(vmInitStateHash, 256);
    ref.storeUint(vmFinalStateHash, 256);
    builder.storeRef(ref.endCell());
  }

  @override
  TransactionComputePhaseType get type => TransactionComputePhaseType.vm;
}

class TransactionComputeSkipped extends TransactionComputePhase {
  final ComputeSkipReason reason;
  const TransactionComputeSkipped(this.reason);
  factory TransactionComputeSkipped.deserialize(Slice slice) {
    return TransactionComputeSkipped(ComputeSkipReason.deserialize(slice));
  }
  factory TransactionComputeSkipped.fromJson(Map<String, dynamic> json) {
    return TransactionComputeSkipped(
        ComputeSkipReason.fromJson(json["reason"]));
  }

  @override
  void store(Builder builder) {
    builder.storeBit(0);
    reason.store(builder);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"reason": reason.toJson(), "type": type.name};
  }

  @override
  TransactionComputePhaseType get type => TransactionComputePhaseType.skipped;
}
