import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/nft_collections.dart';

/// GetNftCollections invokes getNftCollections operation.
///
/// Get NFT collections.
///
class TonApiGetNftCollections
    extends TonApiRequest<NftCollectionsResponse, Map<String, dynamic>> {
  /// Default: 100
  final int? limit;

  /// Default: 0
  final int? offset;
  TonApiGetNftCollections({this.limit, this.offset});
  @override
  String get method => TonApiMethods.getnftcollections.url;

  @override
  Map<String, dynamic> get queryParameters =>
      {'limit': limit, 'offset': offset};

  @override
  NftCollectionsResponse onResonse(Map<String, dynamic> result) {
    return NftCollectionsResponse.fromJson(result);
  }
}
