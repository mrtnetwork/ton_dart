import 'package:ton_dart/src/serialization/serialization.dart';
import 'jetton_balance.dart';

class JettonsBalancesResponse with JsonSerialization {
  final List<JettonBalanceResponse> balances;

  const JettonsBalancesResponse({required this.balances});

  factory JettonsBalancesResponse.fromJson(Map<String, dynamic> json) {
    return JettonsBalancesResponse(
        balances: (json['balances'] as List)
            .map((balanceJson) => JettonBalanceResponse.fromJson(balanceJson))
            .toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {'balances': balances.map((balance) => balance.toJson()).toList()};
  }
}
