import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/ton_connect/bridge/models.dart';
import 'package:ton_dart/src/ton_connect/connect/models.dart';
import 'package:ton_dart/src/error/ton_error.dart';

/// Connect link Dynasty: `tonconnect://` deep link and universal (https)
/// links carry the same query. Only the cleartext [TonConnectRequest]
/// travels here — everything after is bridge-encrypted.
///
/// ```
/// ?v=2&id=<64hex dApp pubkey>&r=<base64url(ConnectRequest json)>&ret=back
/// ```
class TonConnectLink {
  static const int protocolVersion = 2;

  final int version;
  final TonConnectClientId dappId;
  final TonConnectRequest request;
  final String? ret;

  TonConnectLink._({
    required this.version,
    required this.dappId,
    required this.request,
    required this.ret,
  });

  /// Parses a `tonconnect://...` or universal `https://...` connect link.
  /// Throws [BuError] on contract violation.
  factory TonConnectLink.parse(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || uri.queryParameters.isEmpty) {
      throw TonConnectErrors.invalidPayload('Bad connect link.');
    }
    final query = uri.queryParameters;
    final version = IntUtils.tryParse(query['v'] ?? '');
    if (version != protocolVersion) {
      throw TonConnectErrors.invalidPayload(
        'Unsupported connect version "${query['v']}".',
      );
    }
    final dappId = TonConnectClientId(query['id']);
    final r = query['r'];
    if (r == null || r.isEmpty) {
      throw TonConnectErrors.invalidPayload('Connect link misses "r".');
    }
    final ret = query['ret'];
    return TonConnectLink._(
      version: version!,
      dappId: dappId,
      request: _decodeRequest(r),
      ret: (ret == null || ret.isEmpty) ? null : ret,
    );
  }

  /// Builds a link (wallet QR/echo + deterministic tests).
  static String build({
    String scheme = 'tonconnect',
    String host = 'connect',
    required String dappId,
    required TonConnectRequest request,
    String? ret,
  }) {
    final id = TonConnectClientId(dappId);
    final json = StringUtils.fromJson(request.toJson());
    final r = StringUtils.decode(
      StringUtils.encode(json),
      encoding: StringEncoding.base64UrlSafe,
      b64NoPadding: true,
    );
    final uri = Uri(
      scheme: scheme,
      host: host,
      queryParameters: {
        'v': '$protocolVersion',
        'id': id.value,
        'r': r,
        if (ret != null && ret.isNotEmpty) 'ret': ret,
      },
    );
    return uri.toString();
  }

  static TonConnectRequest _decodeRequest(String r) {
    Map<String, dynamic> json;
    try {
      final decoded = StringUtils.encode(
        r,
        encoding: StringEncoding.base64,
        validateB64Padding: false,
      );
      final parsed = StringUtils.decodeJson<Map>(decoded);
      if (parsed is! Map<String, dynamic>) {
        throw TonConnectErrors.invalidPayload('Bad "r" JSON.');
      }
      json = parsed;
    } catch (e) {
      if (e is BuError) rethrow;
      throw TonConnectErrors.invalidPayload('Bad "r" encoding.');
    }
    return TonConnectRequest.fromJson(json);
  }
}
