// BlockRawResponse

import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class AccountStateResponse with JsonSerialization {
  final BigInt balance;
  final Cell? code;
  final Cell? data;
  final AccountStatusResponse state;
  const AccountStateResponse({
    required this.balance,
    required this.code,
    required this.data,
    required this.state,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      "balance": balance.toString(),
      "code": code,
      "data": data,
      "state": state.value,
    };
  }
}
