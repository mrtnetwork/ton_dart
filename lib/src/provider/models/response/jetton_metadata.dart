import 'package:ton_dart/src/serialization/serialization.dart';

class JettonMetadataResponse with JsonSerialization {
  final String address;
  final String name;
  final String symbol;
  final String decimals;
  final String? image;
  final String? description;
  final List<String> social;
  final List<String> websites;
  final List<String> catalogs;

  const JettonMetadataResponse({
    required this.address,
    required this.name,
    required this.symbol,
    required this.decimals,
    this.image,
    this.description,
    required this.social,
    required this.websites,
    required this.catalogs,
  });

  factory JettonMetadataResponse.fromJson(Map<String, dynamic> json) {
    return JettonMetadataResponse(
      address: json['address'],
      name: json['name'],
      symbol: json['symbol'],
      decimals: json['decimals'],
      image: json['image'],
      description: json['description'],
      social: List<String>.from(json['social'] ?? []),
      websites: List<String>.from(json['websites'] ?? []),
      catalogs: List<String>.from(json['catalogs'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'name': name,
      'symbol': symbol,
      'decimals': decimals,
      'social': social,
      'websites': websites,
      'catalogs': catalogs,
      'image': image,
      'description': description
    };
  }
}
