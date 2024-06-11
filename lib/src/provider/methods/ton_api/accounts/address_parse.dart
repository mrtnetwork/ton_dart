import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/address_parse.dart';

/// AddressParse invokes addressParse operation.
///
/// Parse address and display in all formats.
///
class TonApiAddressParse
    extends TonApiRequestParam<AddressParseResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiAddressParse(this.accountId);

  @override
  String get method => TonApiMethods.addressparse.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  AddressParseResponse onResonse(Map<String, dynamic> json) {
    return AddressParseResponse.fromJson(json);
  }
}
