import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/crypto/keypair/public_key.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/ton_connect/connect/models.dart';
import 'package:ton_dart/src/ton_connect/rpc/models.dart';

/// Wallet-side verdict for one RPC payload.
///
/// All mismatches map to catalogue code 1 (`BAD_REQUEST` — "violates
/// method constraints"); [issue] lets the wallet UI branch (alert copy
/// differs for network vs sender vs expiry) without new codes.
enum TonRpcIssue { ok, badRequest, expired, networkMismatch, fromMismatch }

class TonRpcValidation {
  final TonRpcIssue issue;
  final int code;
  final String message;

  const TonRpcValidation._({
    required this.issue,
    required this.code,
    required this.message,
  });

  factory TonRpcValidation.ok() {
    return const TonRpcValidation._(
      issue: TonRpcIssue.ok,
      code: TonRpcErrorCode.unknown,
      message: 'ok',
    );
  }

  factory TonRpcValidation.badRequest(String message) {
    return TonRpcValidation._(
      issue: TonRpcIssue.badRequest,
      code: TonRpcErrorCode.badRequest,
      message: message,
    );
  }

  factory TonRpcValidation.expired() {
    return const TonRpcValidation._(
      issue: TonRpcIssue.expired,
      code: TonRpcErrorCode.badRequest,
      message: 'Request expired (valid_until passed).',
    );
  }

  factory TonRpcValidation.networkMismatch(String expected, String got) {
    return TonRpcValidation._(
      issue: TonRpcIssue.networkMismatch,
      code: TonRpcErrorCode.badRequest,
      message: 'Network mismatch: wallet is $expected, dApp wants $got.',
    );
  }

  factory TonRpcValidation.fromMismatch() {
    return const TonRpcValidation._(
      issue: TonRpcIssue.fromMismatch,
      code: TonRpcErrorCode.badRequest,
      message: 'Sender account mismatch.',
    );
  }

  bool get isOk => issue == TonRpcIssue.ok;
}

/// TON Connect RPC helpers (validation, proof/sign-data builders).
///
class TonConnectUtils {
  static TonAddress? _parseAddress(String raw) {
    try {
      return TonAddress(raw);
    } catch (_) {
      return null;
    }
  }

  static bool _sameAccount(TonAddress a, TonAddress b) {
    return a.workchain.id == b.workchain.id &&
        BytesUtils.bytesEqual(a.hash, b.hash);
  }

  static bool _validAmount(String amount) {
    final value = BigintUtils.tryParse(amount, allowHex: false);
    return value != null && value >= BigInt.zero;
  }

  static TonRpcValidation? _checkCommon({
    required int? validUntil,
    required String? network,
    required String? from,
    required String activeNetwork,
    required String? connectedAddress,
    required int nowSeconds,
  }) {
    if (validUntil != null) {
      if (validUntil <= 0) {
        return TonRpcValidation.badRequest('Bad valid_until.');
      }
      if (nowSeconds > validUntil) return TonRpcValidation.expired();
    }
    if (network != null) {
      TonNetworkId id;
      try {
        id = TonNetworkId(network);
      } catch (_) {
        return TonRpcValidation.badRequest('Bad network id.');
      }
      if (id.value != activeNetwork) {
        return TonRpcValidation.networkMismatch(activeNetwork, id.value);
      }
    }
    if (from != null) {
      final want = _parseAddress(from);
      if (want == null) return TonRpcValidation.badRequest('Bad from address.');
      if (connectedAddress != null) {
        final have = _parseAddress(connectedAddress);
        if (have == null || !_sameAccount(want, have)) {
          return TonRpcValidation.fromMismatch();
        }
      }
    }
    return null;
  }

  static TonRpcValidation? _checkMessage(TonTxMessage message) {
    final address = _parseAddress(message.address);
    if (address == null) {
      return TonRpcValidation.badRequest('Bad message address.');
    }
    if (!address.isFriendly) {
      return TonRpcValidation.badRequest(
        'Message address must be friendly (TEP-2).',
      );
    }
    if (!_validAmount(message.amount)) {
      return TonRpcValidation.badRequest('Bad message amount.');
    }
    if (message.payload != null &&
        TonHelper.tryToCell(message.payload) == null) {
      return TonRpcValidation.badRequest('Bad message payload BoC.');
    }
    if (message.stateInit != null &&
        TonHelper.tryToCell(message.stateInit) == null) {
      return TonRpcValidation.badRequest('Bad message stateInit BoC.');
    }
    if (message.extraCurrency != null) {
      for (final entry in message.extraCurrency!.entries) {
        if (entry.key.isEmpty || !_validAmount(entry.value)) {
          return TonRpcValidation.badRequest('Bad extra_currency.');
        }
      }
    }
    return null;
  }

  static TonRpcValidation? _checkItem(TonTxItem item) {
    const addressKeys = [
      'address',
      'master',
      'destination',
      'responseDestination',
      'nftAddress',
      'newOwner',
    ];
    for (final entry in item.fields.entries) {
      final value = entry.value;
      if (value is! String) continue;
      if (addressKeys.contains(entry.key)) {
        final address = _parseAddress(value);
        if (address == null || !address.isFriendly) {
          return TonRpcValidation.badRequest(
            'Item address "${entry.key}" must be friendly.',
          );
        }
      }
      if (entry.key == 'amount' ||
          entry.key == 'attachAmount' ||
          entry.key == 'forwardAmount') {
        if (!_validAmount(value)) {
          return TonRpcValidation.badRequest('Bad item amount.');
        }
      }
      if (entry.key == 'payload' ||
          entry.key == 'stateInit' ||
          entry.key == 'customPayload' ||
          entry.key == 'forwardPayload') {
        if (TonHelper.tryToCell(value) == null) {
          return TonRpcValidation.badRequest('Bad item BoC field.');
        }
      }
    }
    final amount = item.fields['amount'];
    if (amount is String && !_validAmount(amount)) {
      return TonRpcValidation.badRequest('Bad item amount.');
    }
    return null;
  }

  /// Validates a `sendTransaction`/`signMessage` payload (wallet MUSTs).
  ///
  /// [activeNetwork] is the wallet's stringified global_id (`-239`/`-3`);
  /// [connectedAddress] the bound session account (null = user may pick);
  /// [nowSeconds] injected clock; [maxMessages] wallet policy knob.
  static TonRpcValidation validateTransactionPayload(
    TonTransactionPayload payload, {
    required String activeNetwork,
    required String? connectedAddress,
    required int nowSeconds,
    int maxMessages = 4,
  }) {
    final common = _checkCommon(
      validUntil: payload.validUntil,
      network: payload.network,
      from: payload.from,
      activeNetwork: activeNetwork,
      connectedAddress: connectedAddress,
      nowSeconds: nowSeconds,
    );
    if (common != null) return common;
    if (payload.messages != null) {
      if (payload.messages!.length > maxMessages) {
        return TonRpcValidation.badRequest('Too many messages.');
      }
      for (final message in payload.messages!) {
        final failure = _checkMessage(message);
        if (failure != null) return failure;
      }
      return TonRpcValidation.ok();
    }
    if (payload.items!.length > maxMessages) {
      return TonRpcValidation.badRequest('Too many items.');
    }
    for (final item in payload.items!) {
      final failure = _checkItem(item);
      if (failure != null) return failure;
    }
    return TonRpcValidation.ok();
  }

  /// Validates a `signData` payload (same network/from rules as tx).
  static TonRpcValidation validateSignDataPayload(
    TonSignDataPayload payload, {
    required String activeNetwork,
    required String? connectedAddress,
    required int nowSeconds,
  }) {
    final common = _checkCommon(
      validUntil: null,
      network: payload.network,
      from: payload.from,
      activeNetwork: activeNetwork,
      connectedAddress: connectedAddress,
      nowSeconds: nowSeconds,
    );
    if (common != null) return common;
    switch (payload.type) {
      case TonSignDataPayload.binary:
        final bytes = StringUtils.tryEncode(
          payload.bytes,
          encoding: StringEncoding.base64,
        );
        if (bytes == null) {
          return TonRpcValidation.badRequest('Bad binary bytes.');
        }
      case TonSignDataPayload.cell:
        if (payload.schema!.isEmpty ||
            TonHelper.tryToCell(payload.cellData) == null) {
          return TonRpcValidation.badRequest('Bad cell payload.');
        }
      default:
        break;
    }
    return TonRpcValidation.ok();
  }

  /// Encodes a 32-bit integer via [BinaryOps] (two's complement for
  /// negatives, so signed workchains round-trip).
  static BuBytes _encodeUint32(int value, {required bool littleEndian}) {
    final bytes = List<int>.filled(4, 0);
    if (littleEndian) {
      BinaryOps.writeUint32LE(value, bytes);
    } else {
      BinaryOps.writeUint32BE(value, bytes);
    }
    return BuBytes(bytes);
  }

  static BuBytes _encodeAddress(TonAddress address) {
    if (address.hash.length != 32) {
      throw TonConnectErrors.invalidPayload('Bad address hash.');
    }
    final out = BuBytes.empty();
    out.addAll(_encodeUint32(address.workchain.id, littleEndian: false));
    out.addAll(address.hash);
    return out;
  }

  static BuBytes _encodeDomain(String domain) {
    final bytes = StringUtils.encode(domain);
    final out = BuBytes.empty();
    out.addAll(_encodeUint32(bytes.length, littleEndian: true));
    out.addAll(bytes);
    return out;
  }

  /// Builds the `ton_proof` message bytes (`spec/connect.md` byte layout).
  ///
  /// `utf8("ton-proof-item-v2/") ++ workchain(i32 BE) ++ hash ++
  /// domainLen(u32 LE) ++ domain ++ timestamp(u64 LE) ++ payload`.
  static BuBytes buildTonProofMessage({
    required TonAddress address,
    required String domain,
    required int timestamp,
    required List<int> payload,
  }) {
    if (domain.isEmpty) {
      throw TonConnectErrors.invalidPayload('Empty proof domain.');
    }
    final out = BuBytes.empty();
    out.addAll(StringUtils.encode('ton-proof-item-v2/'));
    out.addAll(_encodeAddress(address));
    out.addAll(_encodeDomain(domain));
    out.addAll(BinaryOps.writeUint64LE(timestamp));
    out.addAll(payload);
    return out;
  }

  /// `sha256(0xffff ++ utf8("ton-connect") ++ sha256(message))`.
  static BuBytes tonProofSigningHash(List<int> message) {
    final inner = QuickCrypto.sha256Hash(message);
    try {
      final outer = BuBytes.empty();
      outer.addAll(const [0xff, 0xff]);
      outer.addAll(StringUtils.encode('ton-connect'));
      outer.addAll(inner);
      return QuickCrypto.sha256Hash(outer);
    } finally {
      inner.forceZero();
    }
  }

  /// Signs a `ton_proof` message with the wallet key.
  static BuBytes signTonProof({
    required TonPrivateKey privateKey,
    required TonAddress address,
    required String domain,
    required int timestamp,
    required List<int> payload,
  }) {
    final message = buildTonProofMessage(
      address: address,
      domain: domain,
      timestamp: timestamp,
      payload: payload,
    );
    final digest = tonProofSigningHash(message);
    try {
      return privateKey.sign(digest);
    } finally {
      digest.forceZero();
    }
  }

  /// Verifies a `ton_proof` signature (dApp/backend path).
  static bool verifyTonProof({
    required TonPublicKey publicKey,
    required TonAddress address,
    required String domain,
    required int timestamp,
    required List<int> payload,
    required List<int> signature,
  }) {
    final message = buildTonProofMessage(
      address: address,
      domain: domain,
      timestamp: timestamp,
      payload: payload,
    );
    final digest = tonProofSigningHash(message);
    try {
      return publicKey.verify(digest, signature);
    } finally {
      digest.forceZero();
    }
  }

  /// Domain-binding rule (`spec/connect.md`): external dApp domains MUST
  /// contain a dot with valid chars on both sides (`tonkeeper`-style bare
  /// names are reserved for native integrations; pass `allowNative`).
  static bool isValidProofDomain(String domain, {bool allowNative = false}) {
    if (domain.isEmpty) return false;
    if (allowNative) return true;
    return RegExp(r'^[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)+$').hasMatch(domain);
  }

  /// Builds the `signData` text/binary message bytes (`spec/rpc.md`).
  ///
  /// `0xffff ++ utf8("ton-connect/sign-data/") ++ workchain(i32 BE) ++
  /// hash ++ domainLen ++ domain ++ timestamp ++ prefix ++ dataLen ++ data`.
  ///
  /// REVIEW(ton-connect): `spec/rpc.md` pins BE only for the Address
  /// subfields and stays silent on Length/Timestamp endianness. LE is used
  /// here to match `spec/connect.md` ton_proof ("matching connect
  /// semantics" per rpc.md AppDomain text). If interop testing against
  /// `@tonconnect/protocol` disagrees, flip the `littleEndian` flags below —
  /// the layout tests pin exact bytes so the change stays one line per field.
  static BuBytes buildSignDataMessage({
    required TonAddress address,
    required String domain,
    required int timestamp,
    required String prefix,
    required List<int> data,
  }) {
    if (prefix != 'txt' && prefix != 'bin') {
      throw TonConnectErrors.invalidPayload('Bad sign prefix.');
    }
    final out = BuBytes.empty();
    out.addAll(const [0xff, 0xff]);
    out.addAll(StringUtils.encode('ton-connect/sign-data/'));
    out.addAll(_encodeAddress(address));
    out.addAll(_encodeDomain(domain));
    out.addAll(BinaryOps.writeUint64LE(timestamp));
    out.addAll(StringUtils.encode(prefix));
    out.addAll(_encodeUint32(data.length, littleEndian: true));
    out.addAll(data);
    return out;
  }

  /// `sha256(message)` for text/binary `signData`.
  static BuBytes signDataDigest(List<int> message) {
    return QuickCrypto.sha256Hash(message);
  }

  /// TEP-81 DNS wire encoding for `signData` cell payloads: reversed
  /// labels joined + terminated by `\0` (`stonfi.com` -> `com\0stonfi\0`
  /// per the spec example).
  static String dnsWireEncode(String domain) {
    final labels = domain.split('.');
    if (labels.any((e) => e.isEmpty)) {
      throw TonConnectErrors.invalidPayload('Bad domain labels.');
    }
    return '${labels.reversed.join('\x00')}\x00';
  }

  /// Builds the `signData` cell payload (`spec/rpc.md` TL-B `message#75569022`).
  static Cell buildSignDataCell({
    required String schema,
    required int timestamp,
    required TonAddress walletAddress,
    required String appDomain,
    required Cell payload,
  }) {
    if (schema.isEmpty) {
      throw TonConnectErrors.invalidPayload('Empty cell schema.');
    }
    final schemaHash = Crc32().quickIntDigest(StringUtils.encode(schema));
    return beginCell()
        .storeUint(0x75569022, 32)
        .storeUint(schemaHash, 32)
        .storeUint(timestamp, 64)
        .storeAddress(walletAddress)
        .storeStringRefTail(dnsWireEncode(appDomain))
        .storeRef(payload)
        .endCell();
  }
}

/// Tracks bridge `AppRequest.id` monotonicity per session.
///
/// The wallet MUST accept the first id as baseline and reject any later
/// id that is not strictly greater. Numeric when both sides parse,
/// lexicographic otherwise.
class TonRequestIdTracker {
  String? _last;
  BigInt? _lastNum;

  bool accept(String id) {
    if (id.isEmpty) return false;
    final last = _last;
    if (last == null) {
      _last = id;
      _lastNum = BigintUtils.tryParse(id, allowHex: false);
      return true;
    }
    final lastNum = _lastNum;
    final nextNum = BigintUtils.tryParse(id, allowHex: false);
    final ok =
        lastNum != null && nextNum != null
            ? nextNum > lastNum
            : id.compareTo(last) > 0;
    if (!ok) return false;
    _last = id;
    _lastNum = nextNum;
    return true;
  }

  void reset() {
    _last = null;
    _lastNum = null;
  }
}

/// Wallet-side `WalletEvent.id` counter (starts at 0; dApp takes the
/// first id it sees as its baseline).
class TonWalletEventId {
  int _next = 0;
  int next() => _next++;
  void reset() => _next = 0;
}
