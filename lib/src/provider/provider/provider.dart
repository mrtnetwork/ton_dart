import 'dart:async';
import 'package:blockchain_utils/exception/exception/rpc_error.dart';
import 'package:blockchain_utils/service/service.dart';
import 'package:blockchain_utils/utils/string/string.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/service/service.dart';

/// Facilitates communication with the tonApi by making requests using a provided [TonProvider].
class TonProvider implements BaseProvider<TonRequestDetails> {
  /// The underlying TonApi service provider used for network communication.
  final TonServiceProvider rpc;

  /// Constructs a new [TonProvider] instance with the specified [rpc] service provider.
  TonProvider(this.rpc);

  int _id = 0;

  bool get isTonCenter => rpc.api.isTonCenter;

  static SERVICERESPONSE _findError<SERVICERESPONSE>(
      BaseServiceResponse<SERVICERESPONSE> response,
      TonRequestDetails request) {
    if (response.type == ServiceResponseType.error) {
      final error = StringUtils.tryToJson<Map<String, dynamic>>(
          response.cast<ServiceErrorResponse>().error);
      if (error != null) {
        _error(error, request);
      }
    }
    final SERVICERESPONSE val = response.getResult(request);
    if (val is Map) {
      final error = val['error'] ?? val['Error'];
      if (error != null) {
        final code = val['code'] ?? val['error_code'];
        _throw(request, error.toString(), code?.toString());
      }
      if (request.apiType.isTonCenter) {
        final ok = val['ok'];
        if (ok is bool && !ok) {
          _throw(
              request,
              val['result']?.toString() ?? ServiceConst.defaultError,
              val['code']?.toString());
        }
        if (request.isJsonRpc) {
          return val['result'];
        }
      }
    }
    return val;
  }

  static _error(Map val, TonRequestDetails request) {
    final error = val['error'] ?? val['Error'];
    if (error != null) {
      final code = val['code'] ?? val['error_code'];
      _throw(request, error.toString(), code?.toString());
    }
    if (request.apiType.isTonCenter) {
      final ok = val['ok'];
      if (ok is bool && !ok) {
        _throw(request, val['result']?.toString() ?? ServiceConst.defaultError,
            val['code']?.toString());
      }
    }
  }

  static void _throw(TonRequestDetails request, String message, String? code) {
    throw RPCError(
        message: message,
        request: {...request.toJson(), 'api': request.apiType.name},
        errorCode: int.tryParse(code ?? ''));
  }

  /// Sends a request to the service using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, TonRequestDetails> request,
      {Duration? timeout}) async {
    final r = await requestDynamic(request, timeout: timeout);
    return request.onResonse(r);
  }

  /// Sends a request to the service using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
      BaseServiceRequest<RESULT, SERVICERESPONSE, TonRequestDetails> request,
      {Duration? timeout}) async {
    final params = request.buildRequest(_id++);
    final response =
        await rpc.doRequest<SERVICERESPONSE>(params, timeout: timeout);

    return _findError(response, params);
  }
}
