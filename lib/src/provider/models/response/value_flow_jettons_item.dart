import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'account_address.dart';
import 'jetton_preview.dart';

class ValueFlowJettonsItemResponse with JsonSerialization {
  final AccountAddressResponse account;
  final JettonPreviewResponse jetton;
  final BigInt quantity;

  const ValueFlowJettonsItemResponse(
      {required this.account, required this.jetton, required this.quantity});

  factory ValueFlowJettonsItemResponse.fromJson(Map<String, dynamic> json) {
    return ValueFlowJettonsItemResponse(
        account: AccountAddressResponse.fromJson(json['account']),
        jetton: JettonPreviewResponse.fromJson(json['jetton']),
        quantity: BigintUtils.parse(json['quantity']));
  }

  @override
  Map<String, dynamic> toJson() => {
        'account': account.toJson(),
        'jetton': jetton.toJson(),
        'quantity': quantity.toString()
      };
}
