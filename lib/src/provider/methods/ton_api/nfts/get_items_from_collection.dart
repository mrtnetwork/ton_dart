import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/nft_items.dart';

/// GetItemsFromCollection invokes getItemsFromCollection operation.
///
/// Get NFT items from collection by collection address.
///
class TonApiGetItemsFromCollection
    extends TonApiRequestParam<NftItemsResponse, Map<String, dynamic>> {
  final String accountId;

  /// Default: 1000
  final int? limit;

  /// Default: 0
  final int? offset;
  TonApiGetItemsFromCollection(
      {required this.accountId, this.limit, this.offset});
  @override
  String get method => TonApiMethods.getitemsfromcollection.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"limit": limit, "offset": offset};

  @override
  NftItemsResponse onResonse(Map<String, dynamic> json) {
    return NftItemsResponse.fromJson(json);
  }
}
