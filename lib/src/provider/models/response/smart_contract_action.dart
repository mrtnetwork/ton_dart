import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'account_address.dart';
import 'refund.dart';

class SmartContractActionResponse with JsonSerialization {
  final AccountAddressResponse executor;
  final AccountAddressResponse contract;
  final BigInt tonAttached;
  final String operation;
  final String? payload;
  final RefundResponse? refund;

  const SmartContractActionResponse({
    required this.executor,
    required this.contract,
    required this.tonAttached,
    required this.operation,
    this.payload,
    this.refund,
  });

  factory SmartContractActionResponse.fromJson(Map<String, dynamic> json) {
    return SmartContractActionResponse(
      executor: AccountAddressResponse.fromJson(json['executor']),
      contract: AccountAddressResponse.fromJson(json['contract']),
      tonAttached: BigintUtils.parse(json['ton_attached']),
      operation: json['operation'],
      payload: json['payload'],
      refund: json['refund'] != null
          ? RefundResponse.fromJson(json['refund'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'executor': executor.toJson(),
      'contract': contract.toJson(),
      'ton_attached': tonAttached.toString(),
      'operation': operation,
      'payload': payload,
      'refund': refund?.toJson(),
    };
  }
}
