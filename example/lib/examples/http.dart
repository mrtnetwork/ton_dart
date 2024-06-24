import 'package:http/http.dart' as http;
import 'package:ton_dart/ton_dart.dart';

class HTTPProvider implements TonServiceProvider {
  HTTPProvider(
      {required this.tonApiUrl,
      required this.tonCenterUrl,
      this.api = TonApiType.tonApi,
      http.Client? client,
      this.defaultRequestTimeout = const Duration(seconds: 30)})
      : client = client ?? http.Client();

  final String? tonApiUrl;
  final String? tonCenterUrl;
  final http.Client client;
  final Duration defaultRequestTimeout;

  @override
  Future<String> get(TonRequestInfo params, {Duration? timeout}) async {
    final String stringUrl =
        params.url(tonApiUrl: tonApiUrl, tonCenterUrl: tonCenterUrl);
    final url = Uri.parse(stringUrl);
    final response = await client.get(url, headers: {
      "Accept": "application/json",
      // make sure to append the header to the request. some method has specific header parameters
      ...params.header
    }).timeout(timeout ?? defaultRequestTimeout);
    return response.body;
  }

  @override
  Future<String> post(TonRequestInfo params, {Duration? timeout}) async {
    final String stringUrl =
        params.url(tonApiUrl: tonApiUrl, tonCenterUrl: tonCenterUrl);
    final url = Uri.parse(stringUrl);
    http.Response response;
    if (params.requestType == RequestMethod.put) {
      response = await client
          .put(url,

              /// make sure to append the header to the request. some method has specific header parameters
              headers: {"Accept": "application/json", ...params.header},
              body: params.body)
          .timeout(timeout ?? defaultRequestTimeout);
    } else {
      response = await client
          .post(
            url,

            /// make sure to append the header to the request. some method has specific header parameters
            headers: {
              if (params.apiType.isTonCenter && stringUrl.contains("testnet"))
                "X-API-Key":
                    "d3800f756738ac7b39599914b8a84465960ff869f555c2317664c9a62529baf3",
              "Accept": "application/json",
              "Content-Type": "application/json",
              ...params.header
            },
            body: params.body,
          )
          .timeout(timeout ?? defaultRequestTimeout);
    }
    return response.body;
  }

  @override
  final TonApiType api;
}
