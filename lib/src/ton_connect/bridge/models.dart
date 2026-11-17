import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/error/ton_error.dart';

/// TON Connect `client_id`: 32-byte public key as 64 lowercase hex chars.
///
/// Validates length + hex. Accepts uppercase input, stores lowercase
/// (bridge emits lowercase per spec).
class TonConnectClientId {
  static const int hexLength = 64;
  static const int byteLength = 32;

  final String value;

  TonConnectClientId._(this.value);

  factory TonConnectClientId(String? raw) {
    if (raw == null || raw.length != hexLength) {
      throw TonConnectErrors.invalidClientId(raw);
    }
    final lower = raw.toLowerCase();
    try {
      final bytes = BytesUtils.fromHexString(lower);
      if (bytes.length != byteLength) {
        throw TonConnectErrors.invalidClientId(raw);
      }
    } catch (_) {
      throw TonConnectErrors.invalidClientId(raw);
    }
    return TonConnectClientId._(lower);
  }

  BuBytes toBytes() => BytesUtils.fromHexString(value);

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TonConnectClientId && other.value == value);

  @override
  int get hashCode => value.hashCode;
}

/// One encrypted message delivered by the HTTP bridge over SSE.
///
/// Wire: `{"from": "<64 hex>", "message": "<base64 nonce||tag||ct>"}`
/// (`trace_id` optional, analytics only). Minimum payload length is
/// 40 bytes (24 nonce + 16 tag, empty plaintext).
class TonBridgeMessage {
  /// Minimum decoded length: 24-byte nonce + 16-byte tag.
  static const int minPayloadLength = 40;

  final TonConnectClientId from;
  final String message;
  final String? traceId;

  TonBridgeMessage._({
    required this.from,
    required this.message,
    required this.traceId,
  });

  /// Validates hex + base64 + minimum length. Throws
  /// [BuError] on contract violation.
  factory TonBridgeMessage({
    required String from,
    required String message,
    String? traceId,
  }) {
    final clientId = TonConnectClientId(from);
    final raw = _decodePayload(message);
    if (raw.length < minPayloadLength) {
      throw TonConnectErrors.invalidPayload(
        'Bridge payload truncated (${raw.length} < $minPayloadLength).',
      );
    }
    return TonBridgeMessage._(
      from: clientId,
      message: message,
      traceId: traceId?.isEmpty ?? true ? null : traceId,
    );
  }

  factory TonBridgeMessage.fromJson(Map<String, dynamic> json) {
    final from = json['from'];
    final message = json['message'];
    final traceId = json['trace_id'] ?? json['traceId'];
    if (from is! String || message is! String) {
      throw TonConnectErrors.invalidPayload('Missing "from" or "message".');
    }
    if (traceId != null && traceId is! String) {
      throw TonConnectErrors.invalidPayload('Bad "trace_id".');
    }
    return TonBridgeMessage(
      from: from,
      message: message,
      traceId: traceId as String?,
    );
  }

  static BuBytes _decodePayload(String payload) {
    try {
      return StringUtils.encode(payload, encoding: StringEncoding.base64);
    } catch (_) {
      throw TonConnectErrors.invalidPayload('Bad base64.');
    }
  }

  BuBytes decoded() => _decodePayload(message);

  Map<String, dynamic> toJson() {
    return {
      'from': from.value,
      'message': message,
      if (traceId != null) 'trace_id': traceId,
    };
  }
}

/// Parameters for `POST {bridge}/message`.
///
/// The payload is already encrypted (`SessionCrypto.encryptToBase64`):
/// this type only validates routing fields, never plaintext.
class TonPostMessageParams {
  /// Bridges must support at least TTL 300; over-limit gets HTTP 400.
  static const int maxTtl = 300;
  static const int minTtl = 1;

  final TonConnectClientId receiver;
  final String base64Payload;
  final int ttl;
  final String? topic;

  TonPostMessageParams._({
    required this.receiver,
    required this.base64Payload,
    required this.ttl,
    required this.topic,
  });

  factory TonPostMessageParams({
    required String receiver,
    required String message,
    int ttl = maxTtl,
    String? topic,
  }) {
    final receiverId = TonConnectClientId(receiver);
    if (ttl < minTtl || ttl > maxTtl) {
      throw TonConnectErrors.ttlExceeded(ttl, maxTtl);
    }
    final raw = TonBridgeMessage._decodePayload(message);
    if (raw.length < TonBridgeMessage.minPayloadLength) {
      throw TonConnectErrors.invalidPayload(
        'Bridge payload truncated (${raw.length} < ${TonBridgeMessage.minPayloadLength}).',
      );
    }
    final t = topic?.isEmpty ?? true ? null : topic;
    return TonPostMessageParams._(
      receiver: receiverId,
      base64Payload: message,
      ttl: ttl,
      topic: t,
    );
  }

  Map<String, dynamic> body() => {'message': base64Payload};

  Map<String, String> queryParameters() {
    return {
      'client_id': receiver.value,
      'ttl': '$ttl',
      if (topic != null) 'topic': topic!,
    };
  }
}

/// Bridge endpoint configuration (pure URL building, no IO).
///
/// Accepts `https://bridge.tonapi.io/bridge` or bare host;
/// normalizes trailing slashes. `http` allowed only for tests.
class TonBridgeConfig {
  final String bridgeUrl;
  final Duration timeout;

  TonBridgeConfig._({required this.bridgeUrl, required this.timeout});

  factory TonBridgeConfig({
    required String bridgeUrl,
    Duration timeout = const Duration(seconds: 30),
  }) {
    final trimmed = bridgeUrl.trim();
    if (trimmed.isEmpty) {
      throw TonConnectErrors.invalidBridgeUrl(bridgeUrl);
    }
    final uri = Uri.tryParse(trimmed);
    if (uri == null ||
        !(uri.scheme == 'https' || uri.scheme == 'http') ||
        uri.host.isEmpty) {
      throw TonConnectErrors.invalidBridgeUrl(bridgeUrl);
    }
    var normalized = trimmed;
    while (normalized.endsWith('/')) {
      normalized = normalized.substring(0, normalized.length - 1);
    }
    return TonBridgeConfig._(bridgeUrl: normalized, timeout: timeout);
  }

  Uri messageUri(TonPostMessageParams params) {
    return Uri.parse(
      '$bridgeUrl/message',
    ).replace(queryParameters: params.queryParameters());
  }

  Uri eventsUri({required String clientId, String? lastEventId}) {
    final id = TonConnectClientId(clientId);
    return Uri.parse('$bridgeUrl/events').replace(
      queryParameters: {
        'client_id': id.value,
        if (lastEventId != null && lastEventId.isNotEmpty)
          'lastEventId': lastEventId,
      },
    );
  }
}
