import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/token_rates.dart';

/// GetRates invokes getRates operation.
///
/// Get the token price to the currency.
///
class TonApiGetRates extends TonApiRequestParam<Map<String, TokenRatesResponse>,
    Map<String, dynamic>> {
  /// accept ton and jetton master addresses.
  final List<String> tokens;

  /// accept ton and all possible fiat currencies
  final List<String> currencies;

  TonApiGetRates({required this.tokens, required this.currencies});

  @override
  String get method => TonApiMethods.getrates.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, dynamic> get queryParameters =>
      {"tokens": tokens.join(","), "currencies": currencies.join(",")};

  @override
  Map<String, TokenRatesResponse> onResonse(Map<String, dynamic> json) {
    return Map<String, TokenRatesResponse>.fromEntries((json["rates"] as Map)
        .entries
        .map((e) => MapEntry<String, TokenRatesResponse>(
            e.key, TokenRatesResponse.fromJson(e.value))));
  }
}
