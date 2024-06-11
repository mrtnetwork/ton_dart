import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'decoded_message_ext_in_msg_decoded.dart';

class DecodedMessageResponse with JsonSerialization {
  final AccountAddressResponse destination;
  final String destinationWalletVersion;
  final DecodedMessageExtInMsgDecodedResponse? extInMsgDecoded;

  const DecodedMessageResponse(
      {required this.destination,
      required this.destinationWalletVersion,
      this.extInMsgDecoded});

  factory DecodedMessageResponse.fromJson(Map<String, dynamic> json) {
    return DecodedMessageResponse(
      destination: AccountAddressResponse.fromJson(json['destination']),
      destinationWalletVersion: json['destination_wallet_version'],
      extInMsgDecoded: json['ext_in_msg_decoded'] != null
          ? DecodedMessageExtInMsgDecodedResponse.fromJson(
              json['ext_in_msg_decoded'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'destination': destination.toJson(),
      'destination_wallet_version': destinationWalletVersion,
      'ext_in_msg_decoded': extInMsgDecoded!.toJson(),
    };
  }
}
