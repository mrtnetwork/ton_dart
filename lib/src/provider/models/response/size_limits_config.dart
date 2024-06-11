import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class SizeLimitsConfigResponse with JsonSerialization {
  final BigInt maxMsgBits;
  final BigInt maxMsgCells;
  final BigInt maxLibraryCells;
  final int maxVMDataDepth;
  final BigInt maxExtMsgSize;
  final int maxExtMsgDepth;
  final BigInt? maxAccStateCells;
  final BigInt? maxAccStateBits;

  const SizeLimitsConfigResponse(
      {required this.maxMsgBits,
      required this.maxMsgCells,
      required this.maxLibraryCells,
      required this.maxVMDataDepth,
      required this.maxExtMsgSize,
      required this.maxExtMsgDepth,
      this.maxAccStateCells,
      this.maxAccStateBits});

  factory SizeLimitsConfigResponse.fromJson(Map<String, dynamic> json) {
    return SizeLimitsConfigResponse(
      maxMsgBits: BigintUtils.parse(json['max_msg_bits']),
      maxMsgCells: BigintUtils.parse(json['max_msg_cells']),
      maxLibraryCells: BigintUtils.parse(json['max_library_cells']),
      maxVMDataDepth: json['max_vm_data_depth'],
      maxExtMsgSize: BigintUtils.parse(json['max_ext_msg_size']),
      maxExtMsgDepth: json['max_ext_msg_depth'],
      maxAccStateCells: BigintUtils.tryParse(json['max_acc_state_cells']),
      maxAccStateBits: BigintUtils.tryParse(json['max_acc_state_bits']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'max_msg_bits': maxMsgBits.toString(),
      'max_msg_cells': maxMsgCells.toString(),
      'max_library_cells': maxLibraryCells.toString(),
      'max_vm_data_depth': maxVMDataDepth,
      'max_ext_msg_size': maxExtMsgSize.toString(),
      'max_ext_msg_depth': maxExtMsgDepth,
      'max_acc_state_cells': maxAccStateCells?.toString(),
      'max_acc_state_bits': maxAccStateBits?.toString(),
    };
  }
}
