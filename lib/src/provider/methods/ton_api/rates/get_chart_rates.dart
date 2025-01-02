import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// GetChartRates invokes getChartRates operation.
///
/// Get chart by token.
///
class TonApiGetChartRates extends TonApiRequest<String, Map<String, dynamic>> {
  /// accept jetton master address
  final String token;

  /// usd
  final String? currency;
  final BigInt? startDate;
  final BigInt? endDate;

  /// Default: 200
  final int? pointsCount;
  TonApiGetChartRates(
      {required this.token,
      this.currency,
      this.startDate,
      this.endDate,
      this.pointsCount});
  @override
  String get method => TonApiMethods.getchartrates.url;

  @override
  Map<String, dynamic> get queryParameters => {
        'currency': currency,
        'token': token,
        'start_date': startDate,
        'end_date': endDate,
        'points_count': pointsCount
      };

  @override
  String onResonse(Map<String, dynamic> result) {
    return result['points'];
  }
}
