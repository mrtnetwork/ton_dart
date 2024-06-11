import 'package:ton_dart/src/serialization/serialization.dart';
import 'pool_impiementation.dart';
import 'pool_info.dart';

class StakingPoolsResponse with JsonSerialization {
  final List<PoolInfoResponse> pools;
  final Map<String, PoolImplementationResponse> implementations;

  const StakingPoolsResponse({
    required this.pools,
    required this.implementations,
  });

  factory StakingPoolsResponse.fromJson(Map<String, dynamic> json) {
    return StakingPoolsResponse(
      pools: (json['pools'] as List<dynamic>)
          .map((pool) => PoolInfoResponse.fromJson(pool))
          .toList(),
      implementations: (json["implementations"] as Map)
          .map<String, PoolImplementationResponse>((key, value) => MapEntry(
              key, PoolImplementationResponse.fromJson((value as Map).cast()))),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'pools': pools.map((pool) => pool.toJson()).toList(),
        'implementations':
            implementations.map((key, value) => MapEntry(key, value.toJson())),
      };
}
