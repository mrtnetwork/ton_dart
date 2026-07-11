import 'dart:async';
import 'package:blockchain_utils/exception/exception/rpc_error.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:blockchain_utils/service/service.dart';
import 'package:blockchain_utils/utils/json/json.dart';
import 'package:ton_dart/src/provider/core/core.dart';

abstract class BaseTonProvider {}

/// Facilitates communication with the tonApi by making requests using a provided [TonProvider].
class TonProvider<SERVICE extends IServiceProvider>
    implements IProvider<SERVICE, TonRequestDetails> {
  /// The underlying TonApi service provider used for network communication.
  @override
  final SERVICE service;

  /// Constructs a new [TonProvider] instance with the specified [service] service provider.
  TonProvider(this.service, this.api);
  final TonApiType api;

  int _id = 0;

  bool get isTonCenter => api.isTonCenter;

  static SERVICERESPONSE _findError<SERVICERESPONSE>(
    BaseServiceResponse response,
    TonRequestDetails request,
  ) {
    if (response.type == ServiceResponseType.error) {
      final details = response.cast<BaseServiceErrorResponse>();
      if (!details.validate) throw details.defaultError();
      return _throw(
        response: response,
        request: request,
        details: details.tryToJson(),
      );
    }
    final result = request.tryEncodingResponse<Map<String, dynamic>>(
      response,
      encoding: ServiceReponseEncoding.map,
    );

    if (!request.api.isTonCenter) {
      if (result != null && result.containsKey("error")) {
        return _throw(response: response, request: request, details: result);
      }
      if (result != null) {
        return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
          object: result,
          params: request,
        );
      }
      return request.toEncodingResponse(response);
    }
    if (result != null) {
      final isOk = result.valueAsBool<bool?>("ok");
      if (isOk != null && !isOk) {
        return _throw(response: response, request: request, details: result);
      }
      if (request.isJsonRpc) {
        return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
          object: result['result'],
          params: request,
        );
      }
      return ServiceProviderUtils.toResponse<SERVICERESPONSE>(
        object: result,
        params: request,
      );
    }
    return request.toEncodingResponse<SERVICERESPONSE>(response);
  }

  static SERVICERESPONSE _throw<SERVICERESPONSE>({
    required BaseServiceResponse response,
    required TonRequestDetails request,

    required Map<String, dynamic>? details,
  }) {
    if (details == null) {
      throw RPCError(
        message: ServiceConst.defaultError,
        request: {...request.toJson(), 'api': request.api.name},
        relatedNetwork: BlockchainNetwork.ton,
        jsonRpcErrpr: details,
        statusCode: response.statusCode,
      );
    }
    final String? error = details.valueAsString("error");
    throw RPCError(
      message: error ?? ServiceConst.defaultError,
      request: {...request.toJson(), 'api': request.api.name},
      errorCode:
          details.valueAsInt<int?>("error_code") ?? details.valueAsInt("code"),
      relatedNetwork: BlockchainNetwork.ton,
      jsonRpcErrpr: details,
      statusCode: response.statusCode,
    );
  }

  /// Sends a request to the service using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TonRequestDetails> request, {
    Duration? timeout,
  }) async {
    final r = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      timeout: timeout,
    );
    return request.onResonse(r);
  }

  /// Sends a request to the service using the specified [request] parameter.
  ///
  /// The [timeout] parameter, if provided, sets the maximum duration for the request.
  /// Whatever is received will be returned
  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TonRequestDetails> request, {
    Duration? timeout,
  }) async {
    final params = request.buildRequest(_id++);
    if (params.isJsonRpc) {
      final response = await service.doRequest(params, timeout: timeout);
      return _findError<SERVICERESPONSE>(response, params);
    }
    final response = await service.doRequest(params, timeout: timeout);

    return _findError<SERVICERESPONSE>(response, params);
  }
}
