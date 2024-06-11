import 'package:ton_dart/src/serialization/serialization.dart';

class DomainNamesResponse with JsonSerialization {
  final List<String> domains;

  const DomainNamesResponse({required this.domains});

  factory DomainNamesResponse.fromJson(Map<String, dynamic> json) {
    return DomainNamesResponse(domains: List<String>.from(json['domains']));
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {'domains': domains};
  }
}
