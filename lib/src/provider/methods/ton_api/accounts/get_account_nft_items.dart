import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/nft_items.dart';

/// GetAccountNftItems invokes getAccountNftItems operation.
///
/// Get all NFT items by owner address.
///
class TonApiGetAccountNftItems
    extends TonApiRequest<NftItemsResponse, Map<String, dynamic>> {
  final String accountId;

  /// collection
  final String? collection;

  /// default: 1000
  final int? limit;

  /// default: 0
  final int? offset;

  /// Selling nft items in ton implemented usually via transfer items to special selling account.
  /// This option enables including items which owned not directly.
  /// Default: false
  final bool? indirectOwnership;

  TonApiGetAccountNftItems(
      {required this.accountId,
      this.collection,
      this.limit,
      this.offset,
      this.indirectOwnership});

  @override
  String get method => TonApiMethods.getaccountnftitems.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters => {
        'collection': collection,
        'limit': limit,
        'offset': offset,
        'indirect_ownership': indirectOwnership
      };

  @override
  NftItemsResponse onResonse(Map<String, dynamic> result) {
    return NftItemsResponse.fromJson(result);
  }
}
