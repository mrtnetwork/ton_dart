import 'package:blockchain_utils/blockchain_utils.dart';

/// TON-specific error types. Phase 2: taxonomy only, no serialization.
enum TonErrorType implements BuErrorType {
  plugin(13000),
  boc(13001),
  dict(13002),
  key(13003),
  contract(13004),
  tokenMetadata(13005),
  tuple(13006),
  contractInactive(13007),
  contractFrozen(13008),
  unknownBody(13009),
  invalidJson(13010),
  invalidOperationId(13011),
  incorrectOperation(13012),
  connectClientId(13013),
  connectPayload(13014),
  connectTtl(13015),
  connectBridgeUrl(13016);

  @override
  String get domain => 'ton';

  @override
  String get errName => name;

  @override
  final int id;
  const TonErrorType(this.id);

  @override
  bool isValid(int? tag) {
    return values.any((e) => e.id == tag);
  }
}

/// Same-signature helpers replacing TonContractErrors.
/// All state lives in [BuError]; no exception types remain.
abstract final class TonContractErrors {
  static const stateIsInactive = BuError(
    TonErrorType.contractInactive,
    'Unable to read contract data. The contract is not active.',
  );
  static const stateIsFrozen = BuError(
    TonErrorType.contractFrozen,
    'Unable to read contract data. The contract is frozen.',
  );

  static BuError unknownBody(String name, {String? message, String? trace}) =>
      BuError(
        TonErrorType.unknownBody,
        'Unknown $name operation body',
        details: {'message': message, 'trace': trace}
          ..removeWhere((k, v) => v == null),
      );

  static BuError invalidJson(
    String name, {
    String? message,
    String? trace,
    // ignore: avoid_annotating_with_dynamic (kept for call-site compat)
    Map? data,
  }) => BuError(
    TonErrorType.invalidJson,
    'Provided json is not valid for $name',
    details: {'message': message, 'trace': trace}
      ..removeWhere((k, v) => v == null),
  );

  static BuError invalidOperationId({Object? tag}) => BuError(
    TonErrorType.invalidOperationId,
    'Unknow or unsupported operation.',
    details: {'tag': tag?.toString()},
  );

  static BuError incorrectOperation({
    required String expected,
    required String got,
  }) => BuError(
    TonErrorType.incorrectOperation,
    'Incorrect operation.',
    details: {'expected': expected, 'got': got},
  );
}

/// Same-signature helpers replacing TonConnectBridgeException factories.
abstract final class TonConnectErrors {
  static BuError invalidClientId(String? value) => BuError(
    TonErrorType.connectClientId,
    'Invalid TON Connect client_id (expected 64 lowercase hex chars).',
    details: {'client_id': value},
  );

  static BuError invalidPayload([String? reason]) => BuError(
    TonErrorType.connectPayload,
    'Invalid TON Connect bridge payload.',
    details: reason == null ? null : {'reason': reason},
  );

  static BuError ttlExceeded(int ttl, int maxTtl) => BuError(
    TonErrorType.connectTtl,
    'Bridge message TTL exceeds the hard limit.',
    details: {'ttl': '$ttl', 'maxTtl': '$maxTtl'},
  );

  static BuError invalidBridgeUrl(String? value) => BuError(
    TonErrorType.connectBridgeUrl,
    'Invalid TON Connect bridge URL.',
    details: {'bridgeUrl': value},
  );
}
