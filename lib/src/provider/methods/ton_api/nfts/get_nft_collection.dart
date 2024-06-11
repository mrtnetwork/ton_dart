import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/nft_collection.dart';

/// GetNftCollection invokes getNftCollection operation.
///
/// Get NFT collection by collection address.
///
class TonApiGetNftCollection
    extends TonApiRequestParam<NftCollectionResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiGetNftCollection(this.accountId);
  @override
  String get method => TonApiMethods.getnftcollection.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  NftCollectionResponse onResonse(Map<String, dynamic> json) {
    return NftCollectionResponse.fromJson(json);
  }
}
