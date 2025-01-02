import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/markets.dart';

/// GetMarketsRates invokes getMarketsRates operation.
///
/// Get the TON price from markets.
///
class TonApiGetMarketsRates
    extends TonApiRequest<MarketsResponse, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.getmarketsrates.url;

  @override
  MarketsResponse onResonse(Map<String, dynamic> result) {
    return MarketsResponse.fromJson(result);
  }
}
