import 'package:blockchain_utils/service/models/params.dart';
import 'package:ton_dart/src/provider/core/core.dart';

typedef TonServiceResponse<T> = BaseServiceResponse<T>;

/// A mixin defining the service provider contract for interacting with the Ton network.
mixin TonServiceProvider implements BaseServiceProvider<TonRequestDetails> {
  TonApiType get api;

  /// Example:
  /// @override
  /// Future<`BaseServiceResponse<T>`> doRequest`<T>`(TonRequestDetails params,
  ///     {Duration? timeout}) async {
  ///   final Uri uri = params.apiType == TonApiType.tonApi
  ///       ? params.toUri(tonApiUrl!)
  ///       : params.toUri(tonCenterUrl!);
  ///   final `Map<String, String>` headers = {
  ///     ...params.headers,
  ///     if (params.apiType.isTonCenter)
  ///       "X-API-Key":
  ///           "MyAPIKEY",
  ///   };
  ///   if (params.type.isPostRequest) {
  ///     final response = await client
  ///         .post(uri, headers: headers, body: params.body())
  ///         .timeout(timeout ?? defaultRequestTimeout);
  ///     return params.toResponse(response.bodyBytes, response.statusCode);
  ///   }
  ///   final response = await client
  ///       .get(uri, headers: headers)
  ///       .timeout(timeout ?? defaultRequestTimeout);
  ///   return params.toResponse(response.bodyBytes, response.statusCode);
  /// }
  @override
  Future<TonServiceResponse<T>> doRequest<T>(TonRequestDetails params,
      {Duration? timeout});
}
