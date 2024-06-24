import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/ton_dart.dart';

/// transfer#5fcc3d14 query_id:uint64 new_owner:MsgAddress response_destination:MsgAddress
/// custom_payload:(Maybe ^Cell) forward_amount:(VarUInteger 16) forward_payload:(Either Cell ^Cell) = InternalMsgBody;
class TransferNFTParams extends TonSerialization {
  /// address of the new owner of the NFT item.
  final TonAddress newOwnerAddress;

  /// address where to send a response with confirmation of a
  /// successful transfer and the rest of the incoming message coins.
  final TonAddress? responseDestination;

  // /// optional custom data.
  // final Cell? customPayload;

  /// the amount of nanotons to be sent to the new owner.
  final BigInt forwardAmount;

  /// optional custom data that should be sent to the new owner.
  final Cell? forwardPayload;
  const TransferNFTParams(
      {required this.newOwnerAddress,
      this.responseDestination,
      required this.forwardAmount,
      this.forwardPayload});

  @override
  void store(Builder builder) {
    builder.storeAddress(newOwnerAddress);
    builder.storeAddress(responseDestination);
    builder.storeBit(0);
    builder.storeCoins(forwardAmount);
    builder.storeMaybeRef(cell: forwardPayload);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "new_owner_address": newOwnerAddress.toFriendlyAddress(),
      "response_destination": responseDestination?.toFriendlyAddress(),
      "forward_amount": forwardAmount.toString()
    };
  }
}
