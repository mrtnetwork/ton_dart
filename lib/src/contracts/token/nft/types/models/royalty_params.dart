//default#_ royalty_factor:uint16 royalty_base:uint16 royalty_address:MsgAddress = RoyaltyParams;
import 'package:blockchain_utils/utils/numbers/utils/int_utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class RoyaltyParams extends TonSerialization {
  final int royaltyFactor;
  final int royaltyBase;
  final TonAddress address;
  const RoyaltyParams(
      {required this.royaltyFactor,
      required this.royaltyBase,
      required this.address});
  factory RoyaltyParams.deserialize(Slice slice) {
    return RoyaltyParams(
        royaltyFactor: slice.loadUint16(),
        royaltyBase: slice.loadUint16(),
        address: slice.loadAddress());
  }
  factory RoyaltyParams.fromJson(Map<String, dynamic> json) {
    return RoyaltyParams(
        royaltyFactor: IntUtils.parse(json['royaltyFactor']),
        royaltyBase: IntUtils.parse(json['royaltyBase']),
        address: TonAddress(json['address']));
  }

  @override
  void store(Builder builder) {
    final cell = beginCell();
    cell.storeUint16(royaltyFactor);
    cell.storeUint16(royaltyBase);
    cell.storeAddress(address);
    builder.storeRef(cell.endCell());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'royaltyFactor': royaltyFactor,
      'royaltyBase': royaltyBase,
      'address': address.toRawAddress()
    };
  }
}
