import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/nft_item.dart';

/// GetNftItemByAddress invokes getNftItemByAddress operation.
///
/// Get NFT item by its address.
///
class TonApiGetNftItemByAddress
    extends TonApiRequestParam<NftItemResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiGetNftItemByAddress(this.accountId);
  @override
  String get method => TonApiMethods.getnftitembyaddress.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  NftItemResponse onResonse(Map<String, dynamic> json) {
    return NftItemResponse.fromJson(json);
  }
}
