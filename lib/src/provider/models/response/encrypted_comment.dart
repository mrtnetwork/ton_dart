import 'package:ton_dart/src/serialization/serialization.dart';

class EncryptedCommentResponse with JsonSerialization {
  final String encryptionType;
  final String cipherText;

  const EncryptedCommentResponse({
    required this.encryptionType,
    required this.cipherText,
  });

  factory EncryptedCommentResponse.fromJson(Map<String, dynamic> json) {
    return EncryptedCommentResponse(
        encryptionType: json['encryption_type'],
        cipherText: json['cipher_text']);
  }

  @override
  Map<String, dynamic> toJson() =>
      {'encryption_type': encryptionType, 'cipher_text': cipherText};
}
