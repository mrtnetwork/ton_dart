import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/provider/core/core.dart';

typedef TonServiceResponse = BaseServiceResponse;

/// A mixin defining the service provider contract for interacting with the Ton network.
mixin TonServiceProvider
    implements
        IServiceProvider<TonRequestDetails, BaseGRPCServiceRequestParams> {
  TonApiType get api;

  @override
  Future<TonServiceResponse> doRequest(
    TonRequestDetails params, {
    Duration? timeout,
  });

  @override
  Future<BaseServiceSubscribtionResponse> doSubscribtionRequest({
    required TonRequestDetails params,
    required BaseServiceSubscribtionRequest<
      dynamic,
      dynamic,
      BaseSubscribtionEvent<dynamic>,
      TonRequestDetails
    >
    request,
    Duration? timeout,
  }) {
    throw BuError(
      DefaultErrorType.unsupported,
      "Subscribtion requests are not supported by this service.",
    );
  }

  @override
  Future<List<int>> doGrpcRequest(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw BuError(
      DefaultErrorType.unsupported,
      "gRPC requests are not supported by this service.",
    );
  }

  @override
  Stream<List<int>> doGrpcRequestStream(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw BuError(
      DefaultErrorType.unsupported,
      "gRPC requests are not supported by this service.",
    );
  }

  @override
  Future<Stream<List<int>>> doGrpcRequestStreamAsync(
    BaseGRPCServiceRequestParams params, {
    Duration? timeout,
  }) {
    throw BuError(
      DefaultErrorType.unsupported,
      "gRPC requests are not supported by this service.",
    );
  }
}
