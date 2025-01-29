import 'package:ton_dart/src/serialization/serialization.dart';

class AddressParseBounceableResponse with JsonSerialization {
  final String b64;
  final String b64Url;
  const AddressParseBounceableResponse(
      {required this.b64, required this.b64Url});

  factory AddressParseBounceableResponse.fromJson(Map<String, dynamic> json) {
    return AddressParseBounceableResponse(
        b64: json['b64'], b64Url: json['b64url']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'b64': b64, 'b64url': b64Url};
  }
}
