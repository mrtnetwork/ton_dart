import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/core/ton_address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

/// A class representing the different types of TON (The Open Network) addresses.
///
/// This class uses a private named constructor to create constant instances representing
/// different types of TON addresses, such as bounceable, non-bounceable, raw, and test variants.
class TonAddressType {
  /// The name of the TON address type.
  final String name;

  /// Private constructor for defining specific instances of [TonAddressType].
  const TonAddressType._(this.name);

  /// A bounceable address, typically used in cases where the address can receive bounced messages.
  static const TonAddressType bounceable = TonAddressType._('Bounceable');

  /// A non-bounceable address, used when bounced messages are not allowed.
  static const TonAddressType nonBounceable =
      TonAddressType._('Non-Bounceable');

  /// A raw address type, typically used in low-level interactions without the friendly representation.
  static const TonAddressType raw = TonAddressType._('Raw');

  /// A bounceable address used in test networks.
  static const TonAddressType testBounceable =
      TonAddressType._('Test(Bounceable)');

  /// A non-bounceable address used in test networks.
  static const TonAddressType testNonBounceable =
      TonAddressType._('Test(Non-Bounceable)');

  /// Returns `true` if the address type is bounceable.
  bool get isBounceable => this == bounceable;

  /// Factory constructor that creates a [TonAddressType] from a [TonAddress].
  ///
  /// If the address is not in a friendly format, it will return [TonAddressType.raw].
  /// If the address is bounceable, it returns [TonAddressType.bounceable] or [TonAddressType.testBounceable]
  /// based on whether the address is test-only.
  /// If not bounceable, it returns [TonAddressType.nonBounceable] or [TonAddressType.testNonBounceable].
  factory TonAddressType.fromAddress(TonAddress address) {
    if (!address.isFriendly) {
      return TonAddressType.raw;
    }
    if (address.isBounceable) {
      if (address.isTestOnly) return TonAddressType.testBounceable;
      return TonAddressType.bounceable;
    }
    if (address.isTestOnly) return TonAddressType.testNonBounceable;
    return TonAddressType.nonBounceable;
  }
}

/// Represents a TON address and provides methods for handling its type.
class TonAddress implements TonBaseAddress {
  static final _decoder = TonAddrDecoder();
  final int workChain;
  final List<int> hash;
  final List<FriendlyAddressFlags> defaultFlags;

  /// Determines the address type based on flags.
  late final TonAddressType type = TonAddressType.fromAddress(this);

  /// Returns true if the address is in a friendly format.
  bool get isFriendly => defaultFlags.isNotEmpty;

  /// Returns true if the address is test-only.
  bool get isTestOnly => defaultFlags.contains(FriendlyAddressFlags.test);

  /// Returns true if the address is bounceable.
  bool get isBounceable =>
      defaultFlags.contains(FriendlyAddressFlags.bounceable);

  /// Private constructor initializing workChain, hash, and flags.
  TonAddress._(this.workChain, this.hash, List<FriendlyAddressFlags> flags)
      : defaultFlags = List<FriendlyAddressFlags>.unmodifiable(flags);

  /// Factory to create a TON address from raw bytes.
  factory TonAddress.fromBytes(int workChain, List<int> hash,
      {bool bounceable = true, bool testNet = false}) {
    final flags = [
      if (bounceable)
        FriendlyAddressFlags.bounceable
      else
        FriendlyAddressFlags.nonBounceable,
      if (testNet) FriendlyAddressFlags.test
    ];
    return TonAddress._(workChain, hash, flags);
  }

  /// Factory to create a TON address from a state initialization.
  factory TonAddress.fromState(
      {required StateInit state,
      required int workChain,
      bool bounceable = true,
      bool testNet = false}) {
    final hash = beginCell().store(state).endCell().hash();
    return TonAddress.fromBytes(workChain, hash,
        bounceable: bounceable, testNet: testNet);
  }

  /// Factory to create a TON address from a string.
  factory TonAddress(String address, {int? forceWorkchain, bool? bounceable}) {
    final decode =
        _decoder.decodeWithResult(address, {'workchain': forceWorkchain});
    List<FriendlyAddressFlags> flags = List.from(decode.flags);
    if (bounceable != null) {
      flags = [
        if (flags.contains(FriendlyAddressFlags.test))
          FriendlyAddressFlags.test,
        if (bounceable)
          FriendlyAddressFlags.bounceable
        else
          FriendlyAddressFlags.nonBounceable
      ];
    }
    return TonAddress._(decode.workchain, decode.hash, flags);
  }

  /// Creates a copy of the address with optional bounceable and test-only flags.
  TonAddress copyWith({bool? bounceable, bool? testOnly}) {
    return TonAddress(
        toFriendlyAddress(bounceable: bounceable, testOnly: testOnly));
  }

  /// Converts the address to a raw format.
  String toRawAddress() {
    return BytesUtils.toHexString(hash, prefix: '$workChain:');
  }

  /// Converts the address to a byte array.
  List<int> toBytes() {
    final int chain = workChain & mask8;
    return [...hash, ...List.generate(4, (index) => chain)];
  }

  /// Converts the address to a friendly format.
  String toFriendlyAddress(
      {bool? bounceable, bool? testOnly, bool urlSafe = true}) {
    return TonAddressUtils.encodeAddress(
        hash: hash,
        workChain: workChain,
        bounceable: bounceable ?? (isFriendly ? isBounceable : true),
        urlSafe: urlSafe,
        testOnly: testOnly ?? isTestOnly);
  }

  /// Returns the string representation of the address.
  @override
  String toString() {
    if (!isFriendly) return toRawAddress();
    return toFriendlyAddress();
  }

  /// Compares two addresses for equality.
  @override
  bool operator ==(other) {
    if (other is! TonAddress) return false;
    return BytesUtils.bytesEqual(other.hash, hash) &&
        other.workChain == workChain;
  }

  /// Returns the hash code of the address.
  @override
  int get hashCode => Object.hash(hash, workChain);
}
