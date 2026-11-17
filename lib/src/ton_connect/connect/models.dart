import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/error/ton_error.dart';

/// Connect items a dApp may request (`spec/connect.md`).
///
/// `ton_addr` is mandatory for a connect to complete; `ton_proof`
/// (wallet-auth proof) is optional and carries the dApp server nonce.
/// `network` on `ton_addr` is the optional global_id the dApp wants.
class TonConnectItem {
  static const String tonAddr = 'ton_addr';
  static const String tonProof = 'ton_proof';
  static const List<String> names = [tonAddr, tonProof];

  final String name;
  final String? payload;
  final String? network;

  TonConnectItem._({required this.name, this.payload, this.network});

  factory TonConnectItem({
    required String name,
    String? payload,
    String? network,
  }) {
    if (!names.contains(name)) {
      throw TonConnectErrors.invalidPayload(
        'Unknown connect item "$name".',
      );
    }
    if (name == tonProof && (payload == null || payload.isEmpty)) {
      throw TonConnectErrors.invalidPayload(
        'ton_proof item requires a payload.',
      );
    }
    if (network != null && network.isEmpty) {
      throw TonConnectErrors.invalidPayload('Bad item network.');
    }
    return TonConnectItem._(name: name, payload: payload, network: network);
  }

  factory TonConnectItem.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    if (name is! String) {
      throw TonConnectErrors.invalidPayload(
        'Connect item misses "name".',
      );
    }
    final payload = json['payload'];
    if (payload != null && payload is! String) {
      throw TonConnectErrors.invalidPayload('Bad item payload.');
    }
    final network = json['network'];
    if (network != null && network is! String) {
      throw TonConnectErrors.invalidPayload('Bad item network.');
    }
    return TonConnectItem(
      name: name,
      payload: payload as String?,
      network: network as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (payload != null) 'payload': payload,
      if (network != null) 'network': network,
    };
  }
}

/// First message a dApp sends (inside the connect link, **not** encrypted —
/// the wallet is not yet connected, per `spec/connect.md`).
class TonConnectRequest {
  final String manifestUrl;
  final List<TonConnectItem> items;

  TonConnectRequest._({required this.manifestUrl, required this.items});

  factory TonConnectRequest({
    required String manifestUrl,
    required List<TonConnectItem> items,
  }) {
    _requireHttpsUrl(manifestUrl, 'manifestUrl');
    if (items.isEmpty) {
      throw TonConnectErrors.invalidPayload(
        'Connect request needs at least one item.',
      );
    }
    return TonConnectRequest._(
      manifestUrl: manifestUrl,
      items: List.unmodifiable(items),
    );
  }

  factory TonConnectRequest.fromJson(Map<String, dynamic> json) {
    final manifestUrl = json['manifestUrl'];
    final items = json['items'];
    if (manifestUrl is! String) {
      throw TonConnectErrors.invalidPayload(
        'Connect request misses "manifestUrl".',
      );
    }
    if (items is! List || items.isEmpty) {
      throw TonConnectErrors.invalidPayload(
        'Connect request misses "items".',
      );
    }
    return TonConnectRequest(
      manifestUrl: manifestUrl,
      items:
          items.map((e) {
            if (e is! Map<String, dynamic>) {
              throw TonConnectErrors.invalidPayload('Bad item entry.');
            }
            return TonConnectItem.fromJson(e);
          }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'manifestUrl': manifestUrl,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

/// dApp manifest (fetched by the wallet over HTTPS, validated here).
class TonConnectManifest {
  final String url;
  final String name;
  final String iconUrl;

  TonConnectManifest._({
    required this.url,
    required this.name,
    required this.iconUrl,
  });

  factory TonConnectManifest({
    required String url,
    required String name,
    required String iconUrl,
  }) {
    _requireHttpsUrl(url, 'url');
    if (name.isEmpty) {
      throw TonConnectErrors.invalidPayload('Manifest misses "name".');
    }
    _requireHttpsUrl(iconUrl, 'iconUrl');
    return TonConnectManifest._(url: url, name: name, iconUrl: iconUrl);
  }

  factory TonConnectManifest.fromJson(
    Map<String, dynamic> json, {
    String? url,
  }) {
    final resolvedUrl = json['url'] ?? url;
    final name = json['name'];
    final iconUrl = json['iconUrl'];
    if (resolvedUrl is! String || name is! String || iconUrl is! String) {
      throw TonConnectErrors.invalidPayload(
        'Manifest misses "url", "name" or "iconUrl".',
      );
    }
    return TonConnectManifest(url: resolvedUrl, name: name, iconUrl: iconUrl);
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'name': name, 'iconUrl': iconUrl};
  }
}

/// Stringified TON network global_id (`spec/connect.md` NETWORK_ID).
///
/// `-239` mainnet, `-3` testnet; any other valid global_id passes
/// through verbatim.
class TonNetworkId {
  static const String mainnet = '-239';
  static const String testnet = '-3';

  final String value;

  TonNetworkId._(this.value);

  factory TonNetworkId(String? raw) {
    if (raw == null ||
        raw.isEmpty ||
        IntUtils.tryParse(raw, allowHex: false) == null) {
      throw TonConnectErrors.invalidPayload('Bad network id "$raw".');
    }
    return TonNetworkId._(raw);
  }

  int get asInt => IntUtils.parse(value, allowHex: false);
  bool get isMainnet => value == mainnet;
  bool get isTestnet => value == testnet;

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is TonNetworkId && other.value == value);

  @override
  int get hashCode => value.hashCode;
}

/// `ton_addr` reply: untrusted wallet data (prove ownership via `ton_proof`).
///
/// `address` is RAW (`0:<hex>`), `publicKey` hex, `walletStateInit`
/// standard-base64 state-init cell.
class TonAddressItemReply {
  final String address;
  final TonNetworkId network;
  final String publicKey;
  final String walletStateInit;

  TonAddressItemReply._({
    required this.address,
    required this.network,
    required this.publicKey,
    required this.walletStateInit,
  });

  factory TonAddressItemReply({
    required String address,
    required String network,
    required String publicKey,
    required String walletStateInit,
  }) {
    TonNetworkId(network);
    _requireHex(publicKey, 64, 'publicKey');
    _requireBase64(walletStateInit, 'walletStateInit');
    if (address.isEmpty) {
      throw TonConnectErrors.invalidPayload('Bad reply address.');
    }
    return TonAddressItemReply._(
      address: address,
      network: TonNetworkId(network),
      publicKey: publicKey.toLowerCase(),
      walletStateInit: walletStateInit,
    );
  }

  factory TonAddressItemReply.fromJson(Map<String, dynamic> json) {
    if (json['name'] != TonConnectItem.tonAddr) {
      throw TonConnectErrors.invalidPayload('Bad reply name.');
    }
    final address = json['address'];
    final network = json['network'];
    final publicKey = json['publicKey'];
    final walletStateInit = json['walletStateInit'];
    if (address is! String ||
        network is! String ||
        publicKey is! String ||
        walletStateInit is! String) {
      throw TonConnectErrors.invalidPayload('Bad ton_addr reply.');
    }
    return TonAddressItemReply(
      address: address,
      network: network,
      publicKey: publicKey,
      walletStateInit: walletStateInit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': TonConnectItem.tonAddr,
      'address': address,
      'network': network.value,
      'publicKey': publicKey,
      'walletStateInit': walletStateInit,
    };
  }
}

/// Successful `ton_proof` reply. `timestamp` is a decimal string (u64).
class TonProofItemReplySuccess {
  final String timestamp;
  final int lengthBytes;
  final String domain;
  final String signature;
  final String payload;

  TonProofItemReplySuccess._({
    required this.timestamp,
    required this.lengthBytes,
    required this.domain,
    required this.signature,
    required this.payload,
  });

  factory TonProofItemReplySuccess({
    required String timestamp,
    required String domain,
    required String signature,
    required String payload,
  }) {
    if (BigintUtils.tryParse(timestamp) == null) {
      throw TonConnectErrors.invalidPayload('Bad proof timestamp.');
    }
    _requireBase64(signature, 'signature');
    return TonProofItemReplySuccess._(
      timestamp: timestamp,
      lengthBytes: domain.length,
      domain: domain,
      signature: signature,
      payload: payload,
    );
  }

  factory TonProofItemReplySuccess.fromJson(Map<String, dynamic> json) {
    if (json['name'] != TonConnectItem.tonProof) {
      throw TonConnectErrors.invalidPayload('Bad reply name.');
    }
    final proof = json['proof'];
    if (proof is! Map<String, dynamic>) {
      throw TonConnectErrors.invalidPayload('Bad ton_proof reply.');
    }
    final timestamp = proof['timestamp'];
    final domain = proof['domain'];
    final signature = proof['signature'];
    final payload = proof['payload'];
    if (timestamp is! String ||
        domain is! Map<String, dynamic> ||
        signature is! String ||
        payload is! String) {
      throw TonConnectErrors.invalidPayload('Bad ton_proof reply.');
    }
    final lengthBytes = domain['lengthBytes'];
    final value = domain['value'];
    if (lengthBytes is! int ||
        value is! String ||
        lengthBytes != StringUtils.encode(value).length) {
      throw TonConnectErrors.invalidPayload('Bad proof domain.');
    }
    return TonProofItemReplySuccess(
      timestamp: timestamp,
      domain: value,
      signature: signature,
      payload: payload,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': TonConnectItem.tonProof,
      'proof': {
        'timestamp': timestamp,
        'domain': {'lengthBytes': lengthBytes, 'value': domain},
        'signature': signature,
        'payload': payload,
      },
    };
  }
}

/// Per-item `ton_proof` failure (e.g. code 400 unsupported — connect
/// itself still succeeds per spec conformance rules).
class TonProofItemReplyError {
  final int code;
  final String? message;

  const TonProofItemReplyError({required this.code, this.message});

  factory TonProofItemReplyError.fromJson(Map<String, dynamic> json) {
    final error = json['error'];
    if (error is! Map<String, dynamic> || error['code'] is! int) {
      throw TonConnectErrors.invalidPayload('Bad ton_proof error.');
    }
    final message = error['message'];
    return TonProofItemReplyError(
      code: error['code'] as int,
      message: message is String ? message : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': TonConnectItem.tonProof,
      'error': {'code': code, if (message != null) 'message': message},
    };
  }
}

/// Wallet capability advertisement (`spec/connect.md` Feature).
class TonFeature {
  final String name;
  final int? maxMessages;
  final bool? extraCurrencySupported;
  final List<String>? itemTypes;
  final List<String>? types;

  TonFeature._({
    required this.name,
    this.maxMessages,
    this.extraCurrencySupported,
    this.itemTypes,
    this.types,
  });

  factory TonFeature.sendTransaction({
    required int maxMessages,
    bool? extraCurrencySupported,
    List<String>? itemTypes,
  }) {
    return TonFeature._(
      name: 'SendTransaction',
      maxMessages: maxMessages,
      extraCurrencySupported: extraCurrencySupported,
      itemTypes: itemTypes == null ? null : List.unmodifiable(itemTypes),
    );
  }

  factory TonFeature.signData({required List<String> types}) {
    return TonFeature._(name: 'SignData', types: List.unmodifiable(types));
  }

  factory TonFeature.signMessage({
    required int maxMessages,
    bool? extraCurrencySupported,
    List<String>? itemTypes,
  }) {
    return TonFeature._(
      name: 'SignMessage',
      maxMessages: maxMessages,
      extraCurrencySupported: extraCurrencySupported,
      itemTypes: itemTypes == null ? null : List.unmodifiable(itemTypes),
    );
  }

  factory TonFeature.embeddedRequest() {
    return TonFeature._(name: 'EmbeddedRequest');
  }

  factory TonFeature.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    if (name is! String) {
      throw TonConnectErrors.invalidPayload('Bad feature.');
    }
    switch (name) {
      case 'SendTransaction':
      case 'SignMessage':
        final maxMessages = json['maxMessages'];
        if (maxMessages is! int) {
          throw TonConnectErrors.invalidPayload(
            'Feature "$name" misses maxMessages.',
          );
        }
        return TonFeature._(
          name: name,
          maxMessages: maxMessages,
          extraCurrencySupported: json['extraCurrencySupported'] as bool?,
          itemTypes: (json['itemTypes'] as List?)?.cast<String>(),
        );
      case 'SignData':
        final types = json['types'];
        if (types is! List || types.isEmpty) {
          throw TonConnectErrors.invalidPayload(
            'Feature "SignData" misses types.',
          );
        }
        return TonFeature._(name: name, types: types.cast<String>());
      case 'EmbeddedRequest':
        return TonFeature._(name: name);
      default:
        throw TonConnectErrors.invalidPayload(
          'Unknown feature "$name".',
        );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (maxMessages != null) 'maxMessages': maxMessages,
      if (extraCurrencySupported != null)
        'extraCurrencySupported': extraCurrencySupported,
      if (itemTypes != null) 'itemTypes': itemTypes,
      if (types != null) 'types': types,
    };
  }
}

/// Wallet device info sent in the connect event.
class TonDeviceInfo {
  static const int maxProtocolVersion = 2;
  static const List<String> platforms = [
    'iphone',
    'ipad',
    'android',
    'windows',
    'mac',
    'linux',
    'browser',
  ];

  final String platform;
  final String appName;
  final String appVersion;
  final int protocolVersion;
  final List<TonFeature> features;

  TonDeviceInfo._({
    required this.platform,
    required this.appName,
    required this.appVersion,
    required this.protocolVersion,
    required this.features,
  });

  factory TonDeviceInfo({
    required String platform,
    required String appName,
    required String appVersion,
    int protocolVersion = maxProtocolVersion,
    required List<TonFeature> features,
  }) {
    if (!platforms.contains(platform)) {
      throw TonConnectErrors.invalidPayload('Bad platform.');
    }
    if (appName.isEmpty || appVersion.isEmpty) {
      throw TonConnectErrors.invalidPayload('Bad device info.');
    }
    return TonDeviceInfo._(
      platform: platform,
      appName: appName,
      appVersion: appVersion,
      protocolVersion: protocolVersion,
      features: List.unmodifiable(features),
    );
  }

  factory TonDeviceInfo.fromJson(Map<String, dynamic> json) {
    final features = json['features'];
    if (json['platform'] is! String ||
        json['appName'] is! String ||
        json['appVersion'] is! String ||
        json['maxProtocolVersion'] is! int ||
        features is! List) {
      throw TonConnectErrors.invalidPayload('Bad device info.');
    }
    return TonDeviceInfo(
      platform: json['platform'] as String,
      appName: json['appName'] as String,
      appVersion: json['appVersion'] as String,
      protocolVersion: json['maxProtocolVersion'] as int,
      features:
          features.map((e) {
            if (e is! Map<String, dynamic>) {
              throw TonConnectErrors.invalidPayload('Bad feature.');
            }
            return TonFeature.fromJson(e);
          }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'appName': appName,
      'appVersion': appVersion,
      'maxProtocolVersion': protocolVersion,
      'features': features.map((e) => e.toJson()).toList(),
    };
  }
}

/// Successful connect event (`response` only with embedded requests).
class TonConnectEventSuccess {
  final int id;
  final List<Map<String, dynamic>> items;
  final TonDeviceInfo device;
  final Map<String, dynamic>? response;

  TonConnectEventSuccess._({
    required this.id,
    required this.items,
    required this.device,
    required this.response,
  });

  factory TonConnectEventSuccess({
    required int id,
    required List<Map<String, dynamic>> items,
    required TonDeviceInfo device,
    Map<String, dynamic>? response,
  }) {
    return TonConnectEventSuccess._(
      id: id,
      items: List.unmodifiable(items),
      device: device,
      response: response,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': 'connect',
      'id': id,
      'payload': {'items': items, 'device': device.toJson()},
      if (response != null) 'response': response,
    };
  }
}

/// Failed connect event. Codes: connect.md connect-event-error-codes
/// (0,1,2,3,100,300,400).
class TonConnectEventError {
  final int id;
  final int code;
  final String message;

  const TonConnectEventError({
    required this.id,
    required this.code,
    required this.message,
  });

  factory TonConnectEventError.fromJson(Map<String, dynamic> json) {
    if (json['event'] != 'connect_error') {
      throw TonConnectErrors.invalidPayload('Bad connect event.');
    }
    final payload = json['payload'];
    if (json['id'] is! int ||
        payload is! Map<String, dynamic> ||
        payload['code'] is! int ||
        payload['message'] is! String) {
      throw TonConnectErrors.invalidPayload('Bad connect error.');
    }
    return TonConnectEventError(
      id: json['id'] as int,
      code: (payload['code'] as int),
      message: payload['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': 'connect_error',
      'id': id,
      'payload': {'code': code, 'message': message},
    };
  }
}

void _requireHttpsUrl(String value, String field) {
  final uri = Uri.tryParse(value);
  if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
    throw TonConnectErrors.invalidPayload(
      'Field "$field" must be an https URL.',
    );
  }
}

void _requireHex(String value, int length, String field) {
  if (value.length != length || !RegExp(r'^[0-9a-fA-F]+$').hasMatch(value)) {
    throw TonConnectErrors.invalidPayload('Bad "$field".');
  }
}

void _requireBase64(String value, String field) {
  const standard = r'^[A-Za-z0-9+/]*={0,2}$';
  if (value.isEmpty || !RegExp(standard).hasMatch(value)) {
    throw TonConnectErrors.invalidPayload('Bad "$field".');
  }
}
