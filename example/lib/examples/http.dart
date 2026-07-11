import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:http/http.dart' as http;
import 'package:ton_dart/ton_dart.dart';

class HTTPProvider with TonServiceProvider {
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
  Future<BaseServiceResponse> doRequest(TonRequestDetails params,
      {Duration? timeout}) async {
    final Uri uri = params.api == TonApiType.tonApi
        ? params.encodeUrl(tonApiUrl!)
        : params.encodeUrl(tonCenterUrl!);
    final Map<String, String> headers = {
      ...params.headers,
      if (params.api.isTonCenter)
        "X-API-Key":
            "1babc819f547695053f4cc9bb858a553834280c3450c79633054dab3b47e755c",
    };
    if (params.requestMethod.isPost) {
      final response = await client
          .post(uri, headers: headers, body: params.encodeBody())
          .timeout(timeout ?? defaultRequestTimeout);
      return params.toResponse(response.bodyBytes,
          statusCode: response.statusCode);
    }
    final response = await client
        .get(uri, headers: headers)
        .timeout(timeout ?? defaultRequestTimeout);
    return params.toResponse(response.bodyBytes,
        statusCode: response.statusCode);
  }

  @override
  final TonApiType api;
}
