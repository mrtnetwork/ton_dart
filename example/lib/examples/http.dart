import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' as http;
import 'package:ton_dart/ton_dart.dart';

class HTTPProvider implements TonServiceProvider {
  HTTPProvider(
      {this.tonApiUrl,
      this.tonCenterUrl,
      this.api = TonApiType.tonApi,
      http.Client? client,
      this.defaultRequestTimeout = const Duration(seconds: 30)})
      : client = client ?? http.Client();

  final String? tonApiUrl;
  final String? tonCenterUrl;
  final http.Client client;
  final Duration defaultRequestTimeout;

  @override
  Future<BaseServiceResponse<T>> doRequest<T>(TonRequestDetails params,
      {Duration? timeout}) async {
    final Uri uri = params.apiType == TonApiType.tonApi
        ? params.toUri(tonApiUrl!)
        : params.toUri(tonCenterUrl!);
    final Map<String, String> headers = {
      ...params.headers,
      // if (params.apiType.isTonCenter)
      //   "X-API-Key":
      //       "d88f7f9fcc8a0a49c3da8fcea5b5dd0f4ea41db2a684fa226ff13a1d18193703",
    };
    if (params.type.isPostRequest) {
      final response = await client
          .post(uri, headers: headers, body: params.body())
          .timeout(timeout ?? defaultRequestTimeout);
      return params.parseResponse(response.bodyBytes, response.statusCode);
    }
    final response = await client
        .get(uri, headers: headers)
        .timeout(timeout ?? defaultRequestTimeout);
    return params.parseResponse(response.bodyBytes, response.statusCode);
  }

  @override
  final TonApiType api;
}
