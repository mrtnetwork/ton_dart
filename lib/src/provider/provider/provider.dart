import 'dart:async';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/exception/exception.dart';
import 'package:ton_dart/src/provider/service/service.dart';

/// Facilitates communication with the tonApi by making requests using a provided [TonProvider].
class TonProvider {
  /// The underlying TonApi service provider used for network communication.
  final TonServiceProvider rpc;

  /// Constructs a new [TonProvider] instance with the specified [rpc] service provider.
  TonProvider(this.rpc);

  int _id = 0;

  bool get isTonCenter => rpc.api.isTonCenter;

  static Object? _findError(String response, TonRequestInfo request) {
    final val = StringUtils.tryToJson(response);
    if (val == null) return null;
    if (val is Map) {
      if (val.containsKey("error") || val.containsKey("Error")) {
        final String error = val["error"] ?? val["Error"];
        _throw(request, error, val["code"]?.toString());
      }
      if (request.apiType.isTonCenter) {
        final ok = val["ok"];
        if (ok is bool && !ok) {
          _throw(request, val["result"]?.toString() ?? "",
              val["code"]?.toString());
        }
        if (request.isJsonRpc) {
          return val["result"];
        }
      }
    }
    return val;
  }

  static void _throw(TonRequestInfo request, String message, String? code) {
    throw TonApiError(message,
        request: {
          "path": request.pathParams,
          "method": request.requestType.name,
          if (request.body != null) "body": request.body,
          "id": request.id,
          if (request.header.isNotEmpty) "header": request.header,
          "api": request.apiType.name
        },
        code: int.tryParse(code ?? ""));
  }

  /// Sends a request to the TonApi network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  Future<dynamic> requestDynamic(TonApiRequestParam request,
      [Duration? timeout]) async {
    final id = ++_id;
    final params = request.toRequest(id);

    String response;
    switch (params.requestType) {
      case RequestMethod.get:
        response = await rpc.get(params, timeout: timeout);
        break;
      default:
        response = await rpc.post(params, timeout: timeout);
        break;
    }
    return _findError(response, params);
  }

  /// Sends a request to the TonApi network using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  Future<T> request<T, E>(TonApiRequestParam<T, E> request,
      [Duration? timeout]) async {
    final data = await requestDynamic(request, timeout);
    final Object? result;

    if (E == List<Map<String, dynamic>>) {
      result = (data as List).map((e) => Map<String, dynamic>.from(e)).toList();
    } else {
      result = data;
    }
    return request.onResonse(result as E);
  }
}
