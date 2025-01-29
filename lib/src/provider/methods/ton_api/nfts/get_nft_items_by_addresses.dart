import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/nft_items.dart';

/// GetNftItemsByAddresses invokes getNftItemsByAddresses operation.
///
/// Get NFT items by their addresses.
///
class TonApiGetNftItemsByAddresses
    extends TonApiPostRequest<NftItemsResponse, Map<String, dynamic>> {
  final List<String> accountIds;
  TonApiGetNftItemsByAddresses(this.accountIds);
  @override
  Map<String, dynamic> get body => {'account_ids': accountIds};

  @override
  String get method => TonApiMethods.getnftitemsbyaddresses.url;

  @override
  NftItemsResponse onResonse(Map<String, dynamic> result) {
    return NftItemsResponse.fromJson(result);
  }
}
