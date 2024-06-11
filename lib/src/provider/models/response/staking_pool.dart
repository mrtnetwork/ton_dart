import 'package:ton_dart/src/serialization/serialization.dart';
import 'pool_impiementation.dart';
import 'pool_info.dart';

class StakingPoolResponse with JsonSerialization {
  final PoolInfoResponse pool;
  final PoolImplementationResponse implementation;

  const StakingPoolResponse({
    required this.pool,
    required this.implementation,
  });

  factory StakingPoolResponse.fromJson(Map<String, dynamic> json) {
    return StakingPoolResponse(
      pool: PoolInfoResponse.fromJson(json["pool"]),
      implementation:
          PoolImplementationResponse.fromJson(json["implementation"]),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'pool': pool.toJson(),
        'implementation': implementation.toJson(),
      };
}
