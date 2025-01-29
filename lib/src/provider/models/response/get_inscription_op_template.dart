import 'package:ton_dart/src/serialization/serialization.dart';

class GetInscriptionOpTemplateResponse with JsonSerialization {
  final String comment;
  final String destination;
  const GetInscriptionOpTemplateResponse(
      {required this.comment, required this.destination});
  factory GetInscriptionOpTemplateResponse.fromJson(Map<String, dynamic> json) {
    return GetInscriptionOpTemplateResponse(
        comment: json['comment'], destination: json['destination']);
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {'comment': comment, 'destination': destination};
  }
}
