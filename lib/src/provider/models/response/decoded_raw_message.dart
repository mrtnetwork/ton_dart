import 'package:ton_dart/src/serialization/serialization.dart';
import 'decoded_raw_message_message.dart';

class DecodedRawMessageResponse with JsonSerialization {
  final DecodedRawMessageMessageResponse message;
  final int mode;

  const DecodedRawMessageResponse({required this.message, required this.mode});

  factory DecodedRawMessageResponse.fromJson(Map<String, dynamic> json) {
    return DecodedRawMessageResponse(
        message: DecodedRawMessageMessageResponse.fromJson(json['message']),
        mode: json['mode']);
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'message': message.toJson(),
      'mode': mode,
    };
  }
}
