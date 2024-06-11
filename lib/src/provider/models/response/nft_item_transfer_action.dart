import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'encrypted_comment.dart';
import 'refund.dart';

class NftItemTransferActionResponse with JsonSerialization {
  final AccountAddressResponse? sender;
  final AccountAddressResponse? recipient;
  final String nft;
  final String? comment;
  final EncryptedCommentResponse? encryptedComment;
  final String? payload;
  final RefundResponse? refund;

  const NftItemTransferActionResponse({
    this.sender,
    this.recipient,
    required this.nft,
    this.comment,
    this.encryptedComment,
    this.payload,
    this.refund,
  });

  factory NftItemTransferActionResponse.fromJson(Map<String, dynamic> json) {
    return NftItemTransferActionResponse(
      sender: json['sender'] != null
          ? AccountAddressResponse.fromJson(json['sender'])
          : null,
      recipient: json['recipient'] != null
          ? AccountAddressResponse.fromJson(json['recipient'])
          : null,
      nft: json['nft'],
      comment: json['comment'],
      encryptedComment: json['encrypted_comment'] == null
          ? null
          : EncryptedCommentResponse.fromJson(json['encrypted_comment']),
      payload: json['payload'],
      refund: json['refund'] != null
          ? RefundResponse.fromJson(json['refund'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'sender': sender?.toJson(),
      'recipient': recipient?.toJson(),
      'nft': nft,
      'comment': comment,
      'encrypted_comment': encryptedComment?.toJson(),
      'payload': payload,
      'refund': refund?.toJson(),
    };
  }
}
