import 'package:ton_dart/src/provider/core/core.dart';

/// A mixin defining the service provider contract for interacting with the Ton network.
mixin TonServiceProvider {
  TonApiType get api;

  /// Makes an HTTP POST request to the TonApi with the specified [params].
  ///
  /// The optional [timeout] parameter sets the maximum duration for the request.
  Future<String> post(TonRequestInfo params, {Duration? timeout});

  /// Makes an HTTP GET request to the TonApi with the specified [params].
  ///
  /// The optional [timeout] parameter sets the maximum duration for the request.
  Future<String> get(TonRequestInfo params, {Duration? timeout});
}
