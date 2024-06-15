import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/core/ton_address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class TonAddressType {
  final String name;
  const TonAddressType._(this.name);
  static const TonAddressType bounceable = TonAddressType._("Bounceable");
  static const TonAddressType nonBounceable =
      TonAddressType._("Non-Bounceable");
  static const TonAddressType raw = TonAddressType._("Raw");
  static const TonAddressType testBounceable =
      TonAddressType._("Test(Bounceable)");
  static const TonAddressType testNonBounceable =
      TonAddressType._("Test(Non-Bounceable)");
  bool get isBounceable => this == bounceable;
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

class TonAddress implements TonBaseAddress {
  final int workChain;
  final List<int> hash;
  final List<FriendlyAddressFlags> defaultFlags;
  late final TonAddressType type = TonAddressType.fromAddress(this);
  bool get isFriendly => defaultFlags.isNotEmpty;
  bool get isTestOnly => defaultFlags.contains(FriendlyAddressFlags.test);
  bool get isBounceable =>
      defaultFlags.contains(FriendlyAddressFlags.bounceable);
  TonAddress._(this.workChain, this.hash, List<FriendlyAddressFlags> flags)
      : defaultFlags = List<FriendlyAddressFlags>.unmodifiable(flags);
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

  factory TonAddress.fromState(
      {required StateInit state,
      required int workChain,
      bool bounceable = true,
      bool testNet = false}) {
    final hash = beginCell().store(state).endCell().hash();
    return TonAddress.fromBytes(workChain, hash,
        bounceable: bounceable, testNet: testNet);
  }

  factory TonAddress(String address) {
    final decode = TonAddressUtils.decodeAddress(address);
    return TonAddress._(decode.workchain, decode.hash, decode.flags);
  }

  String toRawAddress() {
    return BytesUtils.toHexString(hash, prefix: "$workChain:");
  }

  List<int> toBytes() {
    final int chain = workChain & mask8;
    return [...hash, ...List.generate(4, (index) => chain)];
  }

  String toFriendlyAddress(
      {bool? bounceable, bool? testOnly, bool urlSafe = true}) {
    return TonAddressUtils.encodeAddress(
        hash: hash,
        workChain: workChain,
        bounceable: bounceable ?? (isFriendly ? isBounceable : true),
        urlSafe: urlSafe,
        testOnly: testOnly ?? isTestOnly);
  }

  @override
  String toString() {
    if (!isFriendly) return toRawAddress();
    return toFriendlyAddress();
  }

  @override
  operator ==(other) {
    if (other is! TonAddress) return false;
    return BytesUtils.bytesEqual(other.hash, hash) &&
        other.workChain == workChain;
  }

  @override
  int get hashCode => Object.hash(hash, workChain);
}
