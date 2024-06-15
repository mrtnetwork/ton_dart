import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'decoded_raw_message.dart';

class DecodedMessageExtInMsgDecodedWalletHighloadV2Response
    with JsonSerialization {
  final BigInt subwalletID;
  final String boundedQueryID;
  final List<DecodedRawMessageResponse> rawMessages;

  const DecodedMessageExtInMsgDecodedWalletHighloadV2Response({
    required this.subwalletID,
    required this.boundedQueryID,
    required this.rawMessages,
  });

  factory DecodedMessageExtInMsgDecodedWalletHighloadV2Response.fromJson(
      Map<String, dynamic> json) {
    return DecodedMessageExtInMsgDecodedWalletHighloadV2Response(
      subwalletID: BigintUtils.parse(json['subwallet_id']),
      boundedQueryID: json['bounded_query_id'],
      rawMessages: List<DecodedRawMessageResponse>.from(json['raw_messages']
          .map((x) => DecodedRawMessageResponse.fromJson(x))),
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() => {
        'subwallet_id': subwalletID.toString(),
        'bounded_query_id': boundedQueryID,
        'raw_messages': List<dynamic>.from(rawMessages.map((x) => x.toJson())),
      };
}
