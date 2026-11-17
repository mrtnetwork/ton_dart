import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/error/ton_error.dart';

/// RPC method names (`spec/rpc.md`).
class TonRpcMethod {
  static const String sendTransaction = 'sendTransaction';
  static const String signMessage = 'signMessage';
  static const String signData = 'signData';
  static const String disconnect = 'disconnect';
  static const List<String> values = [
    sendTransaction,
    signMessage,
    signData,
    disconnect,
  ];
}

/// Central RPC error catalogue (`spec/rpc.md`).
class TonRpcErrorCode {
  static const int unknown = 0;
  static const int badRequest = 1;
  static const int unknownApp = 100;
  static const int userDeclined = 300;
  static const int methodNotSupported = 400;
}

/// Connect-event error codes (`spec/connect.md`).
class TonConnectErrorCode {
  static const int unknown = 0;
  static const int badRequest = 1;
  static const int manifestNotFound = 2;
  static const int manifestContentError = 3;
  static const int unknownApp = 100;
  static const int userDeclined = 300;
  static const int methodNotSupported = 400;
}

/// dApp -> wallet request. `id` is a string, strictly increasing per
/// session (first id is the baseline); `params` holds exactly one
/// JSON string, except `disconnect` which holds none.
class TonAppRequest {
  final String method;
  final List<String> params;
  final String id;

  TonAppRequest._({
    required this.method,
    required this.params,
    required this.id,
  });

  factory TonAppRequest({
    required String method,
    required List<String> params,
    required String id,
  }) {
    if (!TonRpcMethod.values.contains(method)) {
      throw TonConnectErrors.invalidPayload(
        'Unknown method "$method".',
      );
    }
    if (id.isEmpty) {
      throw TonConnectErrors.invalidPayload('Bad request id.');
    }
    if (method == TonRpcMethod.disconnect && params.isNotEmpty) {
      throw TonConnectErrors.invalidPayload(
        'disconnect takes no params.',
      );
    }
    if (method != TonRpcMethod.disconnect && params.length != 1) {
      throw TonConnectErrors.invalidPayload(
        'Method "$method" takes exactly one param.',
      );
    }
    return TonAppRequest._(
      method: method,
      params: List.unmodifiable(params),
      id: id,
    );
  }

  factory TonAppRequest.fromJson(Map<String, dynamic> json) {
    final method = json['method'];
    final params = json['params'];
    final id = json['id'];
    if (method is! String || id is! String || params is! List) {
      throw TonConnectErrors.invalidPayload('Bad app request.');
    }
    return TonAppRequest(
      method: method,
      params: params.map((e) {
        if (e is! String) {
          throw TonConnectErrors.invalidPayload('Bad param entry.');
        }
        return e;
      }).toList(),
      id: id,
    );
  }

  Map<String, dynamic> toJson() {
    return {'method': method, 'params': params, 'id': id};
  }
}

/// Wallet -> dApp answer. `id` MUST equal the request id.
class TonWalletResponse {
  final String id;
  final dynamic result;
  final Map<String, dynamic>? error;

  TonWalletResponse._({required this.id, this.result, this.error});

  factory TonWalletResponse.success({
    required String id,
    required dynamic result,
  }) {
    if (id.isEmpty || (result is! String && result is! Map)) {
      throw TonConnectErrors.invalidPayload('Bad wallet result.');
    }
    return TonWalletResponse._(id: id, result: result);
  }

  factory TonWalletResponse.error({
    required String id,
    required int code,
    required String message,
    dynamic data,
  }) {
    if (id.isEmpty) {
      throw TonConnectErrors.invalidPayload('Bad wallet result.');
    }
    return TonWalletResponse._(
      id: id,
      error: {
        'code': code,
        'message': message,
        if (data != null) 'data': data,
      },
    );
  }

  factory TonWalletResponse.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    if (id is! String) {
      throw TonConnectErrors.invalidPayload('Bad wallet response.');
    }
    if (json.containsKey('result')) {
      return TonWalletResponse._(id: id, result: json['result']);
    }
    final error = json['error'];
    if (error is! Map<String, dynamic>) {
      throw TonConnectErrors.invalidPayload('Bad wallet response.');
    }
    return TonWalletResponse._(id: id, error: error);
  }

  bool get isSuccess => error == null;

  Map<String, dynamic> toJson() {
    if (error != null) return {'error': error, 'id': id};
    return {'result': result, 'id': id};
  }
}

/// Wallet-initiated event. `id` is numeric, strictly increasing per
/// session (dApp takes the first as baseline).
class TonWalletEvent {
  static const String connect = 'connect';
  static const String connectError = 'connect_error';
  static const String disconnect = 'disconnect';

  final String event;
  final int id;
  final dynamic payload;

  TonWalletEvent._({
    required this.event,
    required this.id,
    required this.payload,
  });

  factory TonWalletEvent({
    required String event,
    required int id,
    required dynamic payload,
  }) {
    if (event != connect && event != connectError && event != disconnect) {
      throw TonConnectErrors.invalidPayload(
        'Unknown event "$event".',
      );
    }
    return TonWalletEvent._(event: event, id: id, payload: payload);
  }

  factory TonWalletEvent.fromJson(Map<String, dynamic> json) {
    final event = json['event'];
    final id = json['id'];
    if (event is! String || id is! int || !json.containsKey('payload')) {
      throw TonConnectErrors.invalidPayload('Bad wallet event.');
    }
    return TonWalletEvent(event: event, id: id, payload: json['payload']);
  }

  Map<String, dynamic> toJson() {
    return {'event': event, 'id': id, 'payload': payload};
  }
}

/// One raw outgoing message. `address` MUST be friendly (TEP-2);
/// `amount` decimal-string nanotons; `payload`/`stateInit` one-cell BoC.
class TonTxMessage {
  final String address;
  final String amount;
  final String? payload;
  final String? stateInit;
  final Map<String, String>? extraCurrency;

  TonTxMessage._({
    required this.address,
    required this.amount,
    this.payload,
    this.stateInit,
    this.extraCurrency,
  });

  factory TonTxMessage({
    required String address,
    required String amount,
    String? payload,
    String? stateInit,
    Map<String, String>? extraCurrency,
  }) {
    if (address.isEmpty || amount.isEmpty) {
      throw TonConnectErrors.invalidPayload('Bad tx message.');
    }
    return TonTxMessage._(
      address: address,
      amount: amount,
      payload: payload?.isEmpty ?? true ? null : payload,
      stateInit: stateInit?.isEmpty ?? true ? null : stateInit,
      extraCurrency: extraCurrency == null || extraCurrency.isEmpty
          ? null
          : Map.unmodifiable(extraCurrency),
    );
  }

  factory TonTxMessage.fromJson(Map<String, dynamic> json) {
    final address = json['address'];
    final amount = json['amount'];
    if (address is! String || amount is! String) {
      throw TonConnectErrors.invalidPayload('Bad tx message.');
    }
    final payload = json['payload'];
    final stateInit = json['stateInit'];
    final extra = json['extra_currency'];
    return TonTxMessage(
      address: address,
      amount: amount,
      payload: payload is String ? payload : null,
      stateInit: stateInit is String ? stateInit : null,
      extraCurrency: extra is Map
          ? extra.map((k, v) => MapEntry('$k', '$v'))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'amount': amount,
      if (payload != null) 'payload': payload,
      if (stateInit != null) 'stateInit': stateInit,
      if (extraCurrency != null) 'extra_currency': extraCurrency,
    };
  }
}

/// Structured items (`ton`/`jetton`/`nft`). Field rules per `spec/rpc.md`.
class TonTxItem {
  final String type;
  final Map<String, dynamic> fields;

  TonTxItem._({required this.type, required this.fields});

  factory TonTxItem(Map<String, dynamic> json) {
    final type = json['type'];
    if (type != 'ton' && type != 'jetton' && type != 'nft') {
      throw TonConnectErrors.invalidPayload('Bad item type.');
    }
    final requiredKeys = switch (type) {
      'ton' => ['address', 'amount'],
      'jetton' => ['master', 'destination', 'amount'],
      _ => ['nftAddress', 'newOwner'],
    };
    for (final key in requiredKeys) {
      if (json[key] is! String || (json[key] as String).isEmpty) {
        throw TonConnectErrors.invalidPayload(
          'Item "$type" misses "$key".',
        );
      }
    }
    return TonTxItem._(
      type: type as String,
      fields: Map.unmodifiable(
        Map<String, dynamic>.from(json)..remove('type'),
      ),
    );
  }

  Map<String, dynamic> toJson() => {'type': type, ...fields};
}

/// Transaction payload shared by `sendTransaction` and `signMessage`.
///
/// Exactly one of `messages`/`items` MUST be present. `network` is a
/// stringified global_id (`-239`/`-3`/other); `from` may be raw or
/// friendly and pins the sender account when present.
class TonTransactionPayload {
  final int? validUntil;
  final String? network;
  final String? from;
  final List<TonTxMessage>? messages;
  final List<TonTxItem>? items;

  TonTransactionPayload._({
    this.validUntil,
    this.network,
    this.from,
    this.messages,
    this.items,
  });

  factory TonTransactionPayload({
    int? validUntil,
    String? network,
    String? from,
    List<TonTxMessage>? messages,
    List<TonTxItem>? items,
  }) {
    final hasMessages = messages != null && messages.isNotEmpty;
    final hasItems = items != null && items.isNotEmpty;
    if (hasMessages == hasItems) {
      throw TonConnectErrors.invalidPayload(
        'Payload needs exactly one of messages/items.',
      );
    }
    final msgs = hasMessages ? messages : null;
    final itms = hasItems ? items : null;
    return TonTransactionPayload._(
      validUntil: validUntil,
      network: network?.isEmpty ?? true ? null : network,
      from: from?.isEmpty ?? true ? null : from,
      messages: msgs == null ? null : List.unmodifiable(msgs),
      items: itms == null ? null : List.unmodifiable(itms),
    );
  }

  factory TonTransactionPayload.fromJson(Map<String, dynamic> json) {
    final validUntil = json['valid_until'];
    if (validUntil != null && validUntil is! int) {
      throw TonConnectErrors.invalidPayload('Bad valid_until.');
    }
    List<TonTxMessage>? messages;
    List<TonTxItem>? items;
    if (json['messages'] is List) {
      messages = (json['messages'] as List).map((e) {
        if (e is! Map<String, dynamic>) {
          throw TonConnectErrors.invalidPayload('Bad message.');
        }
        return TonTxMessage.fromJson(e);
      }).toList();
    }
    if (json['items'] is List) {
      final rawItems = json['items'] as List;
      if (messages != null && rawItems.isNotEmpty) {
        throw TonConnectErrors.invalidPayload(
          'Payload needs exactly one of messages/items.',
        );
      }
      items = rawItems.map((e) {
        if (e is! Map<String, dynamic>) {
          throw TonConnectErrors.invalidPayload('Bad item.');
        }
        return TonTxItem(e);
      }).toList();
    }
    return TonTransactionPayload(
      validUntil: validUntil as int?,
      network: json['network'] is String ? json['network'] as String : null,
      from: json['from'] is String ? json['from'] as String : null,
      messages: messages,
      items: items,
    );
  }

  factory TonTransactionPayload.fromParam(String param) {
    dynamic decoded;
    try {
      decoded = StringUtils.toJson<dynamic>(param);
    } catch (_) {
      throw TonConnectErrors.invalidPayload('Bad params JSON.');
    }
    if (decoded is! Map<String, dynamic>) {
      throw TonConnectErrors.invalidPayload('Bad payload JSON.');
    }
    return TonTransactionPayload.fromJson(decoded);
  }

  Map<String, dynamic> toJson() {
    final msgs = messages;
    final itms = items;
    return {
      if (validUntil != null) 'valid_until': validUntil,
      if (network != null) 'network': network,
      if (from != null) 'from': from,
      if (msgs != null) 'messages': msgs.map((e) => e.toJson()).toList(),
      if (itms != null) 'items': itms.map((e) => e.toJson()).toList(),
    };
  }
}

/// `signData` payload variants (`spec/rpc.md`).
class TonSignDataPayload {
  static const String text = 'text';
  static const String binary = 'binary';
  static const String cell = 'cell';

  final String type;
  final String? network;
  final String? from;
  final String? textData;
  final String? bytes;
  final String? schema;
  final String? cellData;

  TonSignDataPayload._({
    required this.type,
    this.network,
    this.from,
    this.textData,
    this.bytes,
    this.schema,
    this.cellData,
  });

  factory TonSignDataPayload.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type != text && type != binary && type != cell) {
      throw TonConnectErrors.invalidPayload('Bad signData type.');
    }
    switch (type as String) {
      case text:
        if (json['text'] is! String) {
          throw TonConnectErrors.invalidPayload(
            'text payload misses "text".',
          );
        }
      case binary:
        if (json['bytes'] is! String) {
          throw TonConnectErrors.invalidPayload(
            'binary payload misses "bytes".',
          );
        }
      default:
        if (json['schema'] is! String || json['cell'] is! String) {
          throw TonConnectErrors.invalidPayload(
            'cell payload misses "schema"/"cell".',
          );
        }
    }
    return TonSignDataPayload._(
      type: type,
      network: json['network'] is String ? json['network'] as String : null,
      from: json['from'] is String ? json['from'] as String : null,
      textData: json['text'] is String ? json['text'] as String : null,
      bytes: json['bytes'] is String ? json['bytes'] as String : null,
      schema: json['schema'] is String ? json['schema'] as String : null,
      cellData: json['cell'] is String ? json['cell'] as String : null,
    );
  }

  factory TonSignDataPayload.fromParam(String param) {
    dynamic decoded;
    try {
      decoded = StringUtils.toJson<dynamic>(param);
    } catch (_) {
      throw TonConnectErrors.invalidPayload('Bad params JSON.');
    }
    if (decoded is! Map<String, dynamic>) {
      throw TonConnectErrors.invalidPayload('Bad payload JSON.');
    }
    return TonSignDataPayload.fromJson(decoded);
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      if (network != null) 'network': network,
      if (from != null) 'from': from,
      if (textData != null) 'text': textData,
      if (bytes != null) 'bytes': bytes,
      if (schema != null) 'schema': schema,
      if (cellData != null) 'cell': cellData,
    };
  }
}
