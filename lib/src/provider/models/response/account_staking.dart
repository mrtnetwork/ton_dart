import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_staking_info.dart';

class AccountStakingResponse with JsonSerialization {
  final List<AccountStakingInfoResponse> pools;

  AccountStakingResponse({
    required this.pools,
  });

  factory AccountStakingResponse.fromJson(Map<String, dynamic> json) {
    return AccountStakingResponse(
      pools: List<AccountStakingInfoResponse>.from(
          json['pools'].map((x) => AccountStakingInfoResponse.fromJson(x))),
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'pools': pools.map((x) => x.toJson()).toList(),
    };
  }
}
