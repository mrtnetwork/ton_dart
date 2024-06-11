import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'decoded_raw_message.dart';

class DecodedMessageExtInMsgDecodedWalletV4Response with JsonSerialization {
  final BigInt subwalletId;
  final BigInt validUntil;
  final BigInt seqno;
  final int op;
  final List<DecodedRawMessageResponse> rawMessages;

  const DecodedMessageExtInMsgDecodedWalletV4Response(
      {required this.subwalletId,
      required this.validUntil,
      required this.seqno,
      required this.op,
      required this.rawMessages});

  factory DecodedMessageExtInMsgDecodedWalletV4Response.fromJson(
      Map<String, dynamic> json) {
    return DecodedMessageExtInMsgDecodedWalletV4Response(
      subwalletId: BigintUtils.parse(json['subwallet_id']),
      validUntil: BigintUtils.parse(json['valid_until']),
      seqno: BigintUtils.parse(json['seqno']),
      op: json['op'],
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
      'op': op,
      'raw_messages': rawMessages.map((item) => item.toJson()).toList(),
    };
  }
}
