import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/staking_pools.dart';

/// GetStakingPools invokes getStakingPools operation.
///
/// All pools available in network.
///
class TonApiGetStakingPools
    extends TonApiRequestParam<StakingPoolsResponse, Map<String, dynamic>> {
  final String? availableFor;

  /// return also pools not from white list - just compatible by interfaces (maybe dangerous!)
  final bool? includeUnverified;
  final String? acceptLanguage;

  TonApiGetStakingPools(
      {this.availableFor, this.includeUnverified, this.acceptLanguage});

  @override
  String get method => TonApiMethods.getstakingpools.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, dynamic> get queryParameters => {
        "available_for": availableFor,
        "include_unverified": includeUnverified,
      };

  @override
  Map<String, String?> get header => {"Accept-Language": acceptLanguage};

  @override
  StakingPoolsResponse onResonse(Map<String, dynamic> json) {
    return StakingPoolsResponse.fromJson(json);
  }
}
