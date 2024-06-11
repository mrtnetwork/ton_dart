import 'package:ton_dart/src/serialization/serialization.dart';
import 'decode_message_ext_in_msg_decode_wallet_v3.dart';
import 'decoded_message_ext_in_msg_decoded_wallet_highload_v2.dart';
import 'decoded_message_ext_in_msg_decoded_wallet_v4.dart';

class DecodedMessageExtInMsgDecodedResponse with JsonSerialization {
  final DecodedMessageExtInMsgDecodedWalletV3Response? walletV3;
  final DecodedMessageExtInMsgDecodedWalletV4Response? walletV4;
  final DecodedMessageExtInMsgDecodedWalletHighloadV2Response? walletHighloadV2;

  const DecodedMessageExtInMsgDecodedResponse({
    this.walletV3,
    this.walletV4,
    this.walletHighloadV2,
  });

  factory DecodedMessageExtInMsgDecodedResponse.fromJson(
      Map<String, dynamic> json) {
    return DecodedMessageExtInMsgDecodedResponse(
      walletV3: json['wallet_v3'] != null
          ? DecodedMessageExtInMsgDecodedWalletV3Response.fromJson(
              json['wallet_v3'])
          : null,
      walletV4: json['wallet_v4'] != null
          ? DecodedMessageExtInMsgDecodedWalletV4Response.fromJson(
              json['wallet_v4'])
          : null,
      walletHighloadV2: json['wallet_highload_v2'] != null
          ? DecodedMessageExtInMsgDecodedWalletHighloadV2Response.fromJson(
              json['wallet_highload_v2'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'wallet_v3': walletV3?.toJson(),
        'wallet_v4': walletV4?.toJson(),
        'wallet_highload_v2': walletHighloadV2?.toJson()
      };
}
