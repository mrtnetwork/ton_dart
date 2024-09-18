import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class _GasLimitPricesResponseConst {
  static const List<int> internalTags = [0xde, 0xdd];
  static const int specialTag = 0xde;
  static const int tag = 0xd1;
}

class GasLimitPricesResponse with JsonSerialization {
  final BigInt flatGasLimit;
  final BigInt flatGasPrice;
  final BigInt gasPrice;
  final BigInt gasLimit;
  final BigInt gasCredit;
  final BigInt? specialGasLimit;
  final BigInt blockGasLimit;
  final BigInt freezeDueLimit;
  final BigInt deleteDueLimit;

  const GasLimitPricesResponse({
    required this.specialGasLimit,
    required this.flatGasLimit,
    required this.flatGasPrice,
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
      flatGasLimit: BigintUtils.parse(json['flat_gas_limit']),
      flatGasPrice: BigintUtils.parse(json['flat_gas_price']),
      gasPrice: BigintUtils.parse(json['gas_price']),
      gasLimit: BigintUtils.parse(json['gas_limit']),
      gasCredit: BigintUtils.parse(json['gas_credit']),
      blockGasLimit: BigintUtils.parse(json['block_gas_limit']),
      freezeDueLimit: BigintUtils.parse(json['freeze_due_limit']),
      deleteDueLimit: BigintUtils.parse(json['delete_due_limit']),
    );
  }

  factory GasLimitPricesResponse.deserialize(Slice slice) {
    final tag = slice.loadUint8();
    if (tag != _GasLimitPricesResponseConst.tag) {
      throw TonDartPluginException("Invalid gas limit price tag.",
          details: {"excepted": _GasLimitPricesResponseConst.tag, "tag": tag});
    }
    final BigInt flatGasLimit = slice.loadUint64();
    final BigInt flatGasPrice = slice.loadUint64();
    final internalTag = slice.loadUint8();
    if (!_GasLimitPricesResponseConst.internalTags.contains(internalTag)) {
      throw TonDartPluginException("Invalid gas limit price interal tag.",
          details: {
            "excepted": _GasLimitPricesResponseConst.internalTags,
            "tag": tag
          });
    }
    final bool hasSpecialGasPrice =
        internalTag == _GasLimitPricesResponseConst.specialTag;
    return GasLimitPricesResponse(
      flatGasLimit: flatGasLimit,
      flatGasPrice: flatGasPrice,
      gasPrice: slice.loadUint64(),
      gasLimit: slice.loadUint64(),
      specialGasLimit: hasSpecialGasPrice ? slice.loadUint64() : null,
      gasCredit: slice.loadUint64(),
      blockGasLimit: slice.loadUint64(),
      freezeDueLimit: slice.loadUint64(),
      deleteDueLimit: slice.loadUint64(),
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'special_gas_limit': specialGasLimit?.toString(),
      'flat_gas_limit': flatGasLimit.toString(),
      'flat_gas_price': flatGasPrice.toString(),
      'gas_price': gasPrice.toString(),
      'gas_limit': gasLimit.toString(),
      'gas_credit': gasCredit.toString(),
      'block_gas_limit': blockGasLimit.toString(),
      'freeze_due_limit': freezeDueLimit.toString(),
      'delete_due_limit': deleteDueLimit.toString(),
    };
  }
}
