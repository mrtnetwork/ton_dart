import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'account_address.dart';
import 'encrypted_comment.dart';
import 'refund.dart';

class TonTransferActionResponse with JsonSerialization {
  final AccountAddressResponse sender;
  final AccountAddressResponse recipient;
  final BigInt amount;
  final String? comment;
  final EncryptedCommentResponse? encryptedComment;
  final RefundResponse? refund;

  const TonTransferActionResponse({
    required this.sender,
    required this.recipient,
    required this.amount,
    this.comment,
    this.encryptedComment,
    this.refund,
  });

  factory TonTransferActionResponse.fromJson(Map<String, dynamic> json) {
    return TonTransferActionResponse(
      sender: AccountAddressResponse.fromJson(json['sender']),
      recipient: AccountAddressResponse.fromJson(json['recipient']),
      amount: BigintUtils.parse(json['amount']),
      comment: json['comment'],
      encryptedComment: json["encrypted_comment"] == null
          ? null
          : EncryptedCommentResponse.fromJson(json['encrypted_comment']),
      refund: json['refund'] == null
          ? null
          : RefundResponse.fromJson(json['refund']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender.toJson(),
      'recipient': recipient.toJson(),
      'amount': amount.toString(),
      'comment': comment,
      'encrypted_comment': encryptedComment?.toJson(),
      'refund': refund?.toJson(),
    };
  }
}
