import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/auctions.dart';

/// GetAllAuctions invokes getAllAuctions operation.
///
/// Get all auctions.
///
class TonApiGetAllAuctions
    extends TonApiRequest<AuctionsResponse, Map<String, dynamic>> {
  /// domain filter for current auctions "ton" or "t.me"
  final String? tld;
  TonApiGetAllAuctions({this.tld});
  @override
  String get method => TonApiMethods.getallauctions.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, dynamic> get queryParameters => {'tld': tld};

  @override
  AuctionsResponse onResonse(Map<String, dynamic> result) {
    return AuctionsResponse.fromJson(result);
  }
}
