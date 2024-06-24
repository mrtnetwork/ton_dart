//default#_ royalty_factor:uint16 royalty_base:uint16 royalty_address:MsgAddress = RoyaltyParams;
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class RoyaltyParams extends TonSerialization {
  final int royaltyFactor;
  final int royaltyBase;
  final TonAddress address;
  RoyaltyParams(
      {required this.royaltyFactor,
      required this.royaltyBase,
      required this.address});

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
      "royalty_factor": royaltyFactor,
      "royalty_base": royaltyBase,
      "royalty_address": address.toString()
    };
  }
}
