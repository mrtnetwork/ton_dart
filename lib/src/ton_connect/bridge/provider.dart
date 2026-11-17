import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/ton_connect/bridge/details.dart';
import 'package:ton_dart/src/ton_connect/bridge/models.dart';
import 'package:ton_dart/src/ton_connect/bridge/requests.dart';
import 'package:ton_dart/src/error/ton_error.dart';

/// Provider for the TON Connect HTTP bridge.
///
/// Mirrors `TonProvider` (`provider/provider.dart`): `ton_dart` builds
/// typed requests ([TonConnectPostMessage], [TonConnectEventsRequest]),
/// the injected wallet [service] owns the sockets. No `http` import here.
///
/// The wallet service must accept [TonConnectRequestDetails] and route by
/// [TonBridgeConfig.bridgeUrl] (same way it routes [TonRequestDetails] by
/// `api`). Retry policy lives here; plaintext policy lives in the wallet.
class TonConnectBridgeProvider<SERVICE extends IServiceProvider>
    implements ISubscribtionProvider<SERVICE, TonConnectRequestDetails> {
  @override
  final SERVICE service;

  final TonBridgeConfig config;

  /// Handshake retries for retriable statuses (429/503). Single POSTs
  /// never retry (avoids double-delivery; the wallet decides).
  final int maxRetries;
  final Duration retryDelay;

  TonConnectBridgeProvider({
    required this.service,
    required this.config,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
  });

  int _id = 0;

  /// Retriable bridge statuses: 429 (stale SSE held ~1min server-side)
  /// and 503 (bridge rolling). Anything else fails fast.
  static bool isRetriableStatus(int? statusCode) {
    return statusCode == 429 || statusCode == 503;
  }

  static Never _throwError(
    BaseServiceErrorResponse response,
    TonConnectRequestDetails request,
  ) {
    if (!response.validate) throw response.defaultError();
    throw RPCError(
      message: response.findErrorMessage(),
      errorCode: response.tryFineErrorCode(),
      request: request.toJson(),
      relatedNetwork: BlockchainNetwork.ton,
      statusCode: response.statusCode,
    );
  }

  static SERVICERESPONSE _mapResponse<SERVICERESPONSE>(
    BaseServiceResponse response,
    TonConnectRequestDetails request,
  ) {
    if (response is BaseServiceErrorResponse) {
      _throwError(response, request);
    }
    final mapped = request.tryEncodingResponse<SERVICERESPONSE>(response);
    if (mapped == null) {
      throw RPCError(
        message: 'Parsing response failed.',
        request: request.toJson(),
        relatedNetwork: BlockchainNetwork.ton,
        statusCode: response.statusCode,
      );
    }
    return mapped;
  }

  /// Relays one encrypted envelope (`POST {bridge}/message`).
  Future<void> sendMessage(
    TonConnectPostMessage request, {
    Duration? timeout,
  }) async {
    final details = request.buildRequest(_id++);
    final response = await service.doRequest(
      details,
      timeout: timeout ?? config.timeout,
    );
    if (response is BaseServiceErrorResponse) {
      _throwError(response, details);
    }
  }

  /// Encrypts [plaintextJson] for [peerHex] with [crypto] and relays it.
  ///
  /// Pass [nonce] only for deterministic vectors/tests; otherwise a fresh
  /// random nonce is generated per call by `SessionCrypto`.
  Future<void> sendEncrypted({
    required SessionCrypto crypto,
    required String peerHex,
    required String plaintextJson,
    int ttl = TonPostMessageParams.maxTtl,
    String? topic,
    Duration? timeout,
    List<int>? nonce,
  }) async {
    final peer = TonConnectClientId(peerHex);
    final sealed = crypto.encryptToBase64(
      peer.toBytes(),
      plaintextJson,
      nonce: nonce,
    );
    final params = TonPostMessageParams(
      receiver: peer.value,
      message: sealed,
      ttl: ttl,
      topic: topic,
    );
    await sendMessage(TonConnectPostMessage(params), timeout: timeout);
  }

  @override
  Future<RESULT> request<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TonConnectRequestDetails> request, {
    Duration? timeout,
  }) async {
    final mapped = await requestDynamic<RESULT, SERVICERESPONSE>(
      request,
      timeout: timeout,
    );
    return request.onResponse(mapped);
  }

  @override
  Future<SERVICERESPONSE> requestDynamic<RESULT, SERVICERESPONSE>(
    IServiceRequest<RESULT, SERVICERESPONSE, TonConnectRequestDetails> request, {
    Duration? timeout,
  }) async {
    final details = await request.buildRequest(_id++);
    final response = await service.doRequest(
      details,
      timeout: timeout ?? config.timeout,
    );
    return _mapResponse<SERVICERESPONSE>(response, details);
  }

  /// Subscribes to our bridge queue (`GET {bridge}/events`).
  ///
  /// Only [TonConnectEventsRequest] is supported. The handshake retries
  /// [maxRetries] times on retriable statuses, resuming with the same
  /// `lastEventId`; per-message auth failures stay `null` downstream
  /// (see [TonBridgeEvent.hasMessage]).
  @override
  Future<BaseSubscribtionRequestResponse<IDENTIFIER, EVENT>>
  requestSubscribtion<
    IDENTIFIER,
    EVENT extends BaseSubscribtionEvent<IDENTIFIER>,
    SERVICERESPONSE
  >(
    BaseServiceSubscribtionRequest<
      IDENTIFIER,
      SERVICERESPONSE,
      EVENT,
      TonConnectRequestDetails
    >
    request, {
    Duration? timeout,
  }) async {
    if (request is! TonConnectEventsRequest) {
      throw TonConnectErrors.invalidPayload(
        'Unsupported subscription request.',
      );
    }
    final eventsRequest = request as TonConnectEventsRequest;
    int attempt = 0;
    while (true) {
      try {
        final details = eventsRequest.buildRequest(_id++);
        final sub = await service.doSubscribtionRequest(
          params: details,
          request: eventsRequest,
          timeout: timeout ?? config.timeout,
        );
        if (sub.response is BaseServiceErrorResponse) {
          _throwError(sub.response as BaseServiceErrorResponse, details);
        }
        final identifier =
            eventsRequest.toIdentifier(sub.response) ??
            eventsRequest.clientId;
        final stream = sub.stream.where((e) => e is EVENT).cast<EVENT>();
        return DefaultSubscribtionRequestResponse<IDENTIFIER, EVENT>(
          identifier: identifier as IDENTIFIER,
          stream: stream,
        );
      } on RPCError catch (e) {
        if (!isRetriableStatus(e.statusCode) || attempt >= maxRetries) {
          rethrow;
        }
        attempt++;
        await Future.delayed(retryDelay * attempt);
      }
    }
  }
}
