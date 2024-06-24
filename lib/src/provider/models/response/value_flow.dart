import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'account_address.dart';
import 'value_flow_jettons_item.dart';

class ValueFlowResponse with JsonSerialization {
  final AccountAddressResponse account;
  final BigInt ton;
  final BigInt fees;
  final List<ValueFlowJettonsItemResponse> jettons;

  const ValueFlowResponse(
      {required this.account,
      required this.ton,
      required this.fees,
      required this.jettons});

  factory ValueFlowResponse.fromJson(Map<String, dynamic> json) {
    return ValueFlowResponse(
      account: AccountAddressResponse.fromJson(json['account']),
      ton: BigintUtils.parse(json['ton']),
      fees: BigintUtils.parse(json['fees']),
      jettons: (json['jettons'] as List?)
              ?.map((item) => ValueFlowJettonsItemResponse.fromJson(item))
              .toList() ??
          [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'account': account.toJson(),
      'ton': ton.toString(),
      'fees': fees.toString(),
      'jettons': jettons.map((item) => item.toJson()).toList()
    };
  }
}
