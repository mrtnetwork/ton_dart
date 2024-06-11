import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'encrypted_comment.dart';
import 'jetton_preview.dart';
import 'refund.dart';

class JettonTransferActionResponse with JsonSerialization {
  final AccountAddressResponse? sender;
  final AccountAddressResponse? recipient;
  final String sendersWallet;
  final String recipientsWallet;
  final String amount;
  final String? comment;
  final EncryptedCommentResponse? encryptedComment;
  final RefundResponse? refund;
  final JettonPreviewResponse jetton;

  const JettonTransferActionResponse({
    this.sender,
    this.recipient,
    required this.sendersWallet,
    required this.recipientsWallet,
    required this.amount,
    this.comment,
    this.encryptedComment,
    this.refund,
    required this.jetton,
  });

  factory JettonTransferActionResponse.fromJson(Map<String, dynamic> json) {
    return JettonTransferActionResponse(
      sender: json['sender'] != null
          ? AccountAddressResponse.fromJson(json['sender'])
          : null,
      recipient: json['recipient'] != null
          ? AccountAddressResponse.fromJson(json['recipient'])
          : null,
      sendersWallet: json['senders_wallet'],
      recipientsWallet: json['recipients_wallet'],
      amount: json['amount'],
      comment: json['comment'],
      encryptedComment: json['encrypted_comment'] == null
          ? null
          : EncryptedCommentResponse.fromJson(json['encrypted_comment']),
      refund: json['refund'] != null
          ? RefundResponse.fromJson(json['refund'])
          : null,
      jetton: JettonPreviewResponse.fromJson(json['jetton']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender?.toJson(),
      'recipient': recipient?.toJson(),
      'senders_wallet': sendersWallet,
      'recipients_wallet': recipientsWallet,
      'amount': amount,
      'comment': comment,
      'encrypted_comment': encryptedComment?.toJson(),
      'refund': refund?.toJson(),
      'jetton': jetton.toJson(),
    };
  }
}
