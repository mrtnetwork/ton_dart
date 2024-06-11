import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L306
//  cskip_no_state$00 = ComputeSkipReason;
//  cskip_bad_state$01 = ComputeSkipReason;
//  cskip_no_gas$10 = ComputeSkipReason;
class ComputeSkipReason extends TonSerialization {
  final int tag;
  final String reason;
  const ComputeSkipReason._(this.tag, this.reason);
  static const ComputeSkipReason noState = ComputeSkipReason._(0x00, "noState");
  static const ComputeSkipReason badState =
      ComputeSkipReason._(0x01, "badState");
  static const ComputeSkipReason noGas = ComputeSkipReason._(0x02, "noGas");

  factory ComputeSkipReason.deserialize(Slice slice) {
    return ComputeSkipReason.fromTag(slice.loadUint(2));
  }
  factory ComputeSkipReason.fromJson(Map<String, dynamic> json) {
    return ComputeSkipReason.fromValue(json["reason"]);
  }

  static const List<ComputeSkipReason> values = [noState, badState, noGas];
  factory ComputeSkipReason.fromValue(String? status) {
    return values.firstWhere(
      (element) => element.reason == status,
      orElse: () => throw MessageException(
          "Cannot find ComputeSkipReason from provided status",
          details: {"status": status}),
    );
  }
  factory ComputeSkipReason.fromTag(int? tag) {
    return values.firstWhere(
      (element) => element.tag == tag,
      orElse: () => throw MessageException(
          "Cannot find ComputeSkipReason from provided tag",
          details: {"tag": tag}),
    );
  }
  @override
  String toString() {
    return "ComputeSkipReason.$reason";
  }

  @override
  void store(Builder builder) {
    builder.storeUint(tag, 2);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"reason": reason};
  }
}
