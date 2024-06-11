import 'package:ton_dart/src/serialization/serialization.dart';

class PoolImplementationResponse with JsonSerialization {
  final String name;
  final String description;
  final String url;
  final List<String> socials;

  const PoolImplementationResponse({
    required this.name,
    required this.description,
    required this.url,
    required this.socials,
  });

  factory PoolImplementationResponse.fromJson(Map<String, dynamic> json) {
    return PoolImplementationResponse(
      name: json['name'],
      description: json['description'],
      url: json['url'],
      socials: List<String>.from(json['socials']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'url': url,
      'socials': socials,
    };
  }
}
