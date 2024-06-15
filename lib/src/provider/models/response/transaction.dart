import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'account_address.dart';
import 'account_status.dart';
import 'action_phase.dart';
import 'bounce_phase_type.dart';
import 'compute_phase.dart';
import 'credit_phase.dart';
import 'message.dart';
import 'storage_phase.dart';
import 'transaction_type.dart';

class TransactionResponse with JsonSerialization {
  final String hash;
  final BigInt lt;
  final AccountAddressResponse account;
  final bool success;
  final BigInt utime;
  final AccountStatusResponse origStatus;
  final AccountStatusResponse endStatus;
  final BigInt totalFees;
  final BigInt endBalance;
  final TransactionTypeResponse transactionType;
  final String stateUpdateOld;
  final String stateUpdateNew;
  final MessageResponse? inMsg;
  final List<MessageResponse> outMsgs;
  final String block;
  final String? prevTransHash;
  final BigInt? prevTransLt;
  final ComputePhaseResponse? computePhase;
  final StoragePhaseResponse? storagePhase;
  final CreditPhaseResponse? creditPhase;
  final ActionPhaseResponse? actionPhase;
  final BouncePhaseTypeResponse? bouncePhase;
  final bool aborted;
  final bool destroyed;

  const TransactionResponse({
    required this.hash,
    required this.lt,
    required this.account,
    required this.success,
    required this.utime,
    required this.origStatus,
    required this.endStatus,
    required this.totalFees,
    required this.endBalance,
    required this.transactionType,
    required this.stateUpdateOld,
    required this.stateUpdateNew,
    this.inMsg,
    required this.outMsgs,
    required this.block,
    this.prevTransHash,
    this.prevTransLt,
    this.computePhase,
    this.storagePhase,
    this.creditPhase,
    this.actionPhase,
    this.bouncePhase,
    required this.aborted,
    required this.destroyed,
  });

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return TransactionResponse(
      hash: json['hash'],
      lt: BigintUtils.parse(json['lt']),
      account: AccountAddressResponse.fromJson(json['account']),
      success: json['success'],
      utime: BigintUtils.parse(json['utime']),
      origStatus: AccountStatusResponse.fromName(json['orig_status']),
      endStatus: AccountStatusResponse.fromName(json['end_status']),
      totalFees: BigintUtils.parse(json['total_fees']),
      endBalance: BigintUtils.parse(json['end_balance']),
      transactionType:
          TransactionTypeResponse.fromName(json['transaction_type']),
      stateUpdateOld: json['state_update_old'],
      stateUpdateNew: json['state_update_new'],
      inMsg: json['in_msg'] != null
          ? MessageResponse.fromJson(json['in_msg'])
          : null,
      outMsgs: List<MessageResponse>.from((json['out_msgs'] as List)
          .map((msg) => MessageResponse.fromJson(msg))),
      block: json['block'],
      prevTransHash: json['prev_trans_hash'],
      prevTransLt: BigintUtils.tryParse(json['prev_trans_lt']),
      computePhase: json['compute_phase'] != null
          ? ComputePhaseResponse.fromJson(json['compute_phase'])
          : null,
      storagePhase: json['storage_phase'] != null
          ? StoragePhaseResponse.fromJson(json['storage_phase'])
          : null,
      creditPhase: json['credit_phase'] != null
          ? CreditPhaseResponse.fromJson(json['credit_phase'])
          : null,
      actionPhase: json['action_phase'] != null
          ? ActionPhaseResponse.fromJson(json['action_phase'])
          : null,
      bouncePhase: json['bounce_phase'] != null
          ? BouncePhaseTypeResponse.fromName(json['bounce_phase'])
          : null,
      aborted: json['aborted'],
      destroyed: json['destroyed'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'hash': hash,
      'lt': lt.toString(),
      'account': account.toJson(),
      'success': success,
      'utime': utime.toString(),
      'orig_status': origStatus.value,
      'end_status': endStatus.value,
      'total_fees': totalFees.toString(),
      'end_balance': endBalance.toString(),
      'transaction_type': transactionType.value,
      'state_update_old': stateUpdateOld,
      'state_update_new': stateUpdateNew,
      'in_msg': inMsg?.toJson(),
      'out_msgs': outMsgs.map((msg) => msg.toJson()).toList(),
      'block': block,
      'prev_trans_hash': prevTransHash,
      'prev_trans_lt': prevTransLt?.toString(),
      'compute_phase': computePhase?.toJson(),
      'storage_phase': storagePhase?.toJson(),
      'credit_phase': creditPhase?.toJson(),
      'action_phase': actionPhase?.toJson(),
      'bounce_phase': bouncePhase?.value,
      'aborted': aborted,
      'destroyed': destroyed,
    };
  }
}
