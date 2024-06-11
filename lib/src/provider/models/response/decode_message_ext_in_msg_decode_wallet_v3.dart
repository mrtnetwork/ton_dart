import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'decoded_raw_message.dart';

class DecodedMessageExtInMsgDecodedWalletV3Response with JsonSerialization {
  final BigInt subwalletId;
  final BigInt validUntil;
  final BigInt seqno;
  final List<DecodedRawMessageResponse> rawMessages;

  const DecodedMessageExtInMsgDecodedWalletV3Response(
      {required this.subwalletId,
      required this.validUntil,
      required this.seqno,
      required this.rawMessages});

  factory DecodedMessageExtInMsgDecodedWalletV3Response.fromJson(
      Map<String, dynamic> json) {
    return DecodedMessageExtInMsgDecodedWalletV3Response(
      subwalletId: BigintUtils.parse(json['subwallet_id']),
      validUntil: BigintUtils.parse(json['valid_until']),
      seqno: BigintUtils.parse(json['seqno']),
      rawMessages: (json['raw_messages'] as List<dynamic>)
          .map((item) => DecodedRawMessageResponse.fromJson(item))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'subwallet_id': subwalletId.toString(),
      'valid_until': validUntil.toString(),
      'seqno': seqno.toString(),
      'raw_messages': rawMessages.map((item) => item.toJson()).toList(),
    };
  }
}
