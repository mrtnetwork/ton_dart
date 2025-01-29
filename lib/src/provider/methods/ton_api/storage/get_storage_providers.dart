import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/storage_provider.dart';

/// GetStorageProviders invokes getStorageProviders operation.
///
/// Get TON storage providers deployed to the blockchain.
///
class TonApiGetStorageProviders
    extends TonApiRequest<List<StorageProviderResponse>, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.getstorageproviders.url;

  @override
  List<StorageProviderResponse> onResonse(Map<String, dynamic> result) {
    return (result['providers'] as List)
        .map((e) => StorageProviderResponse.fromJson(e))
        .toList();
  }
}
