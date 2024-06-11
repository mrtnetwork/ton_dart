import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class GasLimitPricesResponse with JsonSerialization {
  final BigInt? specialGasLimit;
  final BigInt? flatGasLimit;
  final BigInt? flatGasPrice;
  final BigInt gasPrice;
  final BigInt gasLimit;
  final BigInt gasCredit;
  final BigInt blockGasLimit;
  final BigInt freezeDueLimit;
  final BigInt deleteDueLimit;

  const GasLimitPricesResponse({
    this.specialGasLimit,
    this.flatGasLimit,
    this.flatGasPrice,
    required this.gasPrice,
    required this.gasLimit,
    required this.gasCredit,
    required this.blockGasLimit,
    required this.freezeDueLimit,
    required this.deleteDueLimit,
  });

  factory GasLimitPricesResponse.fromJson(Map<String, dynamic> json) {
    return GasLimitPricesResponse(
      specialGasLimit: BigintUtils.tryParse(json['special_gas_limit']),
      flatGasLimit: BigintUtils.tryParse(json['flat_gas_limit']),
      flatGasPrice: BigintUtils.tryParse(json['flat_gas_price']),
      gasPrice: BigintUtils.parse(json['gas_price']),
      gasLimit: BigintUtils.parse(json['gas_limit']),
      gasCredit: BigintUtils.parse(json['gas_credit']),
      blockGasLimit: BigintUtils.parse(json['block_gas_limit']),
      freezeDueLimit: BigintUtils.parse(json['freeze_due_limit']),
      deleteDueLimit: BigintUtils.parse(json['delete_due_limit']),
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'special_gas_limit': specialGasLimit?.toString(),
      'flat_gas_limit': flatGasLimit?.toString(),
      'flat_gas_price': flatGasPrice?.toString(),
      'gas_price': gasPrice.toString(),
      'gas_limit': gasLimit.toString(),
      'gas_credit': gasCredit.toString(),
      'block_gas_limit': blockGasLimit.toString(),
      'freeze_due_limit': freezeDueLimit.toString(),
      'delete_due_limit': deleteDueLimit.toString(),
    };
  }
}
