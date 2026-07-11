import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/core/ton_address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';

/// A class representing the different types of TON (The Open Network) addresses.
///
/// This class uses a private named constructor to create constant instances representing
/// different types of TON addresses, such as bounceable, non-bounceable, raw, and test variants.
enum TonAddressType {
  /// A bounceable address, typically used in cases where the address can receive bounced messages.
  bounceable('Bounceable'),

  /// A non-bounceable address, used when bounced messages are not allowed.
  nonBounceable('Non-Bounceable'),

  /// A raw address type, typically used in low-level interactions without the friendly representation.
  raw('Raw'),

  /// A bounceable address used in test networks.
  testBounceable('Test(Bounceable)'),

  /// A non-bounceable address used in test networks.
  testNonBounceable('Test(Non-Bounceable)');

  /// Returns `true` if the address type is bounceable.
  bool get isBounceable => this == bounceable;

  /// The name of the TON address type.
  final String name;

  /// Private constructor for defining specific instances of [TonAddressType].
  const TonAddressType(this.name);
}

sealed class TonAddressConfing with CborTagSerializable, Equality {
  final TonWorkChain workchain;
  final TonAddressType type;
  const TonAddressConfing({required this.workchain, required this.type});
  bool get isFriendly;
  bool get testOnly => false;
  bool get bounceable => false;
  bool get urlSafe => false;
  factory TonAddressConfing.raw(TonWorkChain workchain) =>
      TonAddressConfingRaw(workchain);
  factory TonAddressConfing.deserialize({
    List<int>? cborBytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValueWithInfo(
      expectedTags: [
        TonSerializationIdentifiers.tornAddressfriendly,
        TonSerializationIdentifiers.tornAddressraw,
      ],
      cborBytes: cborBytes,
      cborObject: obj,
    );
    final type = values.identifier;
    return switch (type) {
      TonSerializationIdentifiers.tornAddressfriendly =>
        TonAddressConfingFriendlyAddress.deserialize(obj: values.tag),
      TonSerializationIdentifiers.tornAddressraw =>
        TonAddressConfingRaw.deserialize(obj: values.tag),
      _ =>
        throw CborSerializableException.incorrectTagValue(tag: values.tag.tags),
    };
  }
  factory TonAddressConfing.friendly(
    TonWorkChain workchain, {
    bool bounceable = true,
    bool testOnly = false,
    bool noPadding = false,
    bool urlSafe = true,
  }) => TonAddressConfingFriendlyAddress(
    workchain: workchain,
    bounceable: bounceable,
    noPadding: noPadding,
    testOnly: testOnly,
    urlSafe: urlSafe,
  );

  String encodeAddress(List<int> hash);
}

final class TonAddressConfingFriendlyAddress extends TonAddressConfing {
  @override
  final bool testOnly;
  @override
  final bool bounceable;
  final bool noPadding;
  @override
  final bool urlSafe;

  TonAddressConfingFriendlyAddress copyWity({
    bool? testOnly,
    bool? bounceable,
    bool? noPadding,
    bool? urlSafe,
    TonWorkChain? workchain,
  }) {
    return TonAddressConfingFriendlyAddress(
      workchain: workchain ?? this.workchain,
      bounceable: bounceable ?? this.bounceable,
      noPadding: noPadding ?? this.noPadding,
      urlSafe: urlSafe ?? this.urlSafe,
      testOnly: testOnly ?? this.testOnly,
    );
  }

  const TonAddressConfingFriendlyAddress._({
    required super.workchain,
    required super.type,
    this.bounceable = true,
    this.testOnly = false,
    this.noPadding = false,
    this.urlSafe = true,
  });
  factory TonAddressConfingFriendlyAddress.deserialize({
    List<int>? cborBytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tornAddressfriendly,
      cborBytes: cborBytes,
      cborObject: obj,
    );
    return TonAddressConfingFriendlyAddress(
      workchain: TonWorkChain(values.rawValueAt(0)),
      bounceable: values.rawValueAt(1),
      urlSafe: values.rawValueAt(2),
      testOnly: values.rawValueAt(3),
      noPadding: values.rawValueAt(4),
    );
  }
  factory TonAddressConfingFriendlyAddress({
    required TonWorkChain workchain,
    bool bounceable = true,
    bool testOnly = false,
    bool noPadding = false,
    bool urlSafe = true,
  }) {
    final type = switch ((bounceable, testOnly)) {
      (true, true) => TonAddressType.testBounceable,
      (true, false) => TonAddressType.bounceable,
      (false, true) => TonAddressType.testNonBounceable,
      (false, false) => TonAddressType.nonBounceable,
    };
    return TonAddressConfingFriendlyAddress._(
      workchain: workchain,
      type: type,
      bounceable: bounceable,
      noPadding: noPadding,
      testOnly: testOnly,
      urlSafe: urlSafe,
    );
  }

  @override
  bool get isFriendly => true;

  @override
  String encodeAddress(List<int> hash) {
    return TonAddressUtils.encodeAddress(
      hash: hash,
      workChain: workchain.id,
      bounceable: bounceable,
      urlSafe: urlSafe,
      testOnly: testOnly,
      noPadding: noPadding,
    );
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      TonSerializationIdentifiers.tornAddressfriendly;

  @override
  List<CborObject?> get serializationItems => [
    workchain.id.toCbor(),
    bounceable.toCbor(),
    urlSafe.toCbor(),
    testOnly.toCbor(),
    noPadding.toCbor(),
  ];

  @override
  List<dynamic> get variables => [
    workchain,
    bounceable,
    urlSafe,
    testOnly,
    noPadding,
  ];
}

class TonAddressConfingRaw extends TonAddressConfing {
  const TonAddressConfingRaw(TonWorkChain workchain)
    : super(workchain: workchain, type: TonAddressType.raw);

  factory TonAddressConfingRaw.deserialize({
    List<int>? cborBytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tornAddressraw,
      cborBytes: cborBytes,
      cborObject: obj,
    );
    return TonAddressConfingRaw(TonWorkChain(values.rawValueAt(0)));
  }
  @override
  bool get isFriendly => false;

  @override
  String encodeAddress(List<int> hash) {
    return TonAddressUtils.encodeRawAddress(workchain.id, hash);
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      TonSerializationIdentifiers.tornAddressraw;

  @override
  List<CborObject?> get serializationItems => [workchain.id.toCbor()];

  @override
  List<dynamic> get variables => [workchain];
}

/// Represents a TON address and provides methods for handling its type.
class TonAddress
    with CborTagSerializable, Equality
    implements TonBaseAddress, IAddress {
  final TonAddressConfing config;
  final List<int> hash;
  @override
  final String address;

  TonWorkChain get workchain => config.workchain;

  bool get isBounceable => config.bounceable;

  TonAddressType get type => config.type;

  // /// Returns true if the address is in a friendly format.
  bool get isFriendly => config.isFriendly;

  // /// Returns true if the address is test-only.
  bool get isTestOnly => config.testOnly;

  /// Private constructor initializing workChain, hash, and flags.
  TonAddress._({
    required this.config,
    required List<int> hash,
    required this.address,
  }) : hash = hash.asImmutableBytes;

  /// Factory to create a TON address from raw bytes.
  factory TonAddress.fromBytes({
    required List<int> hash,
    required TonAddressConfing config,
  }) {
    final address = config.encodeAddress(hash);
    return TonAddress._(config: config, hash: hash, address: address);
  }

  factory TonAddress.deserializeIAddress({
    List<int>? bytes,
    CborObject? object,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.ton.identifier,
      cborBytes: bytes,
      cborObject: object,
    );
    final List<int> addressHash = values.rawValueAt(0);
    final confing = TonAddressConfing.deserialize(obj: values.objectAt(1));
    return TonAddress._(
      hash: addressHash,
      config: confing,
      address: confing.encodeAddress(addressHash),
    );
  }

  /// Factory to create a TON address from a state initialization.
  factory TonAddress.fromState({
    required StateInit state,
    required TonAddressConfing config,
  }) {
    final hash = beginCell().store(state).endCell().hash();
    return TonAddress.fromBytes(hash: hash, config: config);
  }

  /// Factory to create a TON address from a string.
  /// [ovverideBounceable] if provided return friendly address following [ovverideBounceable] config.
  /// [ovverideBounceableOnRawAddress] only applied if address is raw address
  /// and return friendly address following [ovverideBounceableOnRawAddress] config.
  factory TonAddress(
    String address, {
    TonWorkChain? forceWorkchain,
    bool? ovverideBounceable,
    bool? ovverideBounceableOnRawAddress,
  }) {
    final decode = TonAddrDecoder().decodeWithResult(
      address,
      workChain: forceWorkchain?.id,
    );
    TonAddressConfing config = decode.toConfing();
    switch (config) {
      case TonAddressConfingFriendlyAddress():
        if (ovverideBounceable == null ||
            config.bounceable == ovverideBounceable) {
          return TonAddress._(
            address: address,
            config: config,
            hash: decode.hash,
          );
        }
        config = config.copyWity(bounceable: ovverideBounceable);
        return TonAddress._(
          address: config.encodeAddress(decode.hash),
          config: config,
          hash: decode.hash,
        );
      case TonAddressConfingRaw():
        final bounceable = ovverideBounceableOnRawAddress ?? ovverideBounceable;
        if (bounceable != null) {
          config = TonAddressConfingFriendlyAddress(
            bounceable: bounceable,
            workchain: config.workchain,
          );
          return TonAddress._(
            address: config.encodeAddress(decode.hash),
            config: config,
            hash: decode.hash,
          );
        }
        return TonAddress._(
          config: config,
          hash: decode.hash,
          address: address,
        );
    }
  }

  /// Creates a copy of the address with optional bounceable and test-only flags.
  TonAddress copyWith(TonAddressConfing config) {
    return TonAddress.fromBytes(config: config, hash: hash);
  }

  /// Converts the address to a raw format.
  String toRawAddress() {
    if (isFriendly) {
      return TonAddressConfing.raw(workchain).encodeAddress(hash);
    }
    return address;
  }

  /// Converts the address to a byte array.
  List<int> toBytes() {
    final int chain = workchain.id & BinaryOps.mask8;
    return [...hash, ...List.generate(4, (index) => chain)];
  }

  /// Converts the address to a friendly format.
  TonAddress toFriendly({
    bool? bounceable,
    bool? testOnly,
    bool urlSafe = true,
    bool noPadding = false,
  }) {
    final config = this.config;
    switch (config) {
      case TonAddressConfingFriendlyAddress():
        final newConfing = config.copyWity(
          bounceable: bounceable,
          testOnly: testOnly,
          urlSafe: urlSafe,
          noPadding: noPadding,
        );
        if (newConfing == config) {
          return this;
        }
        return TonAddress.fromBytes(hash: hash, config: newConfing);
      case TonAddressConfingRaw():
        return TonAddress.fromBytes(
          hash: hash,
          config: TonAddressConfing.friendly(
            config.workchain,
            bounceable: bounceable ?? true,
            testOnly: testOnly ?? false,
            urlSafe: urlSafe,
            noPadding: noPadding,
          ),
        );
    }
  }

  @override
  String toString() {
    return address;
  }

  @override
  BlockchainNetwork get blockchainNetwork => BlockchainNetwork.ton;

  @override
  List<int> encodeAsIAddress() {
    return toCbor().encode();
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      blockchainNetwork.identifier;

  @override
  List<CborObject?> get serializationItems => [
    CborBytesValue(hash),
    config.toCbor(),
  ];

  @override
  List<dynamic> get variables => [hash, workchain];

  @override
  String get viewType => type.name;
}

extension _TOCONFIG on DecodeAddressResult {
  TonAddressConfing toConfing() {
    final workchain = TonWorkChain(this.workchain);
    if (!isFriendly) {
      return TonAddressConfing.raw(workchain);
    }
    return TonAddressConfing.friendly(
      workchain,
      bounceable: isBounceable,
      noPadding: !isPaded,
      testOnly: isTestOnly,
      urlSafe: isUrlSafe,
    );
  }
}
