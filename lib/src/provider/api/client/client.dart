import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/provider/api/api/api.dart';
import 'package:ton_dart/src/provider/core/core.dart';

/// Quick client: high-level provider calls with unified result types.
///
/// There is exactly one [provider]; [availableProviders] selects which
/// backend(s) each call may use (first match wins, no error fallback).
/// See [TonQuickClientApi].
abstract class TonQuickClient with TonQuickClientApi {
  const TonQuickClient();
}

class DefaultTonQuickClient extends TonQuickClient {
  @override
  final IProvider<IServiceProvider, TonRequestDetails> provider;

  /// Backend preference order (legacy-first by default).
  @override
  final List<TonApiType> availableProviders;

  const DefaultTonQuickClient({
    required this.provider,
    this.availableProviders = const [TonApiType.tonCenter, TonApiType.tonApi],
  });
}
