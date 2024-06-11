import 'package:ton_dart/src/provider/core/core.dart';

/// A mixin defining the service provider contract for interacting with the Ton network.
mixin TonServiceProvider {
  /// Makes an HTTP POST request to the TonApi with the specified [params].
  ///
  /// The optional [timeout] parameter sets the maximum duration for the request.
  Future<dynamic> post(TonRequestInfo params, [Duration? timeout]);

  /// Makes an HTTP GET request to the TonApi with the specified [params].
  ///
  /// The optional [timeout] parameter sets the maximum duration for the request.
  Future<dynamic> get(TonRequestInfo params, [Duration? timeout]);
}
