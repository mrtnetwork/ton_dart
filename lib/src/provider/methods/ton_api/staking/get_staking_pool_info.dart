import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/staking_pool.dart';

/// GetStakingPoolInfo invokes getStakingPoolInfo operation.
///
/// Stacking pool info.
///
class TonApiGetStakingPoolInfo
    extends TonApiRequest<StakingPoolResponse, Map<String, dynamic>> {
  final String accountId;
  final String? acceptLanguage;
  TonApiGetStakingPoolInfo({required this.accountId, this.acceptLanguage});
  @override
  String get method => TonApiMethods.getstakingpoolinfo.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, String?> get headers => {'Accept-Language': acceptLanguage};
  @override
  StakingPoolResponse onResonse(Map<String, dynamic> result) {
    return StakingPoolResponse.fromJson(result);
  }
}
