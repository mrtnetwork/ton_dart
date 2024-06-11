import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/core/ton_address.dart';
import 'package:ton_dart/src/address/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class TonAddress implements TonBaseAddress {
  final int workChain;
  final List<int> hash;

  TonAddress.fromBytes(this.workChain, List<int> hash)
      : hash = TonAddressUtils.validateAddressHash(hash);

  factory TonAddress.fromState(
      {required StateInit state, required int workChain}) {
    final hash = beginCell().store(state).endCell().hash();
    return TonAddress.fromBytes(workChain, hash);
  }

  factory TonAddress(String address) {
    final decode = TonAddressUtils.decodeAddress(address);
    return decode.address;
  }

  String toRawAddress() {
    return BytesUtils.toHexString(hash, prefix: "$workChain:");
  }

  List<int> toBytes() {
    final int chain = workChain & mask8;
    return [...hash, ...List.generate(4, (index) => chain)];
  }

  String toStringAddress(
      {bool urlSafe = true, bool bounceable = true, bool testOnly = false}) {
    return TonAddressUtils.encodeAddress(
        hash: hash,
        workChain: workChain,
        bounceable: bounceable,
        urlSafe: urlSafe,
        testOnly: testOnly);
  }

  @override
  String toString(
      {bool urlSafe = true, bool bounceable = true, bool testOnly = false}) {
    return toStringAddress(
        bounceable: bounceable, urlSafe: urlSafe, testOnly: testOnly);
  }

  @override
  operator ==(other) {
    if (other is! TonAddress) return false;
    return bytesEqual(other.hash, hash) && other.workChain == workChain;
  }

  @override
  int get hashCode => Object.hash(hash, workChain);
}
