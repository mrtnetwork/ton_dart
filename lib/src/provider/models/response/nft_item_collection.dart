import 'package:ton_dart/src/serialization/serialization.dart';

class NftItemCollectionResponse with JsonSerialization {
  final String address;
  final String name;
  final String description;

  const NftItemCollectionResponse({
    required this.address,
    required this.name,
    required this.description,
  });

  factory NftItemCollectionResponse.fromJson(Map<String, dynamic> json) {
    return NftItemCollectionResponse(
        address: json['address'],
        name: json['name'],
        description: json['description']);
  }

  @override
  @override
  Map<String, dynamic> toJson() =>
      {'address': address, 'name': name, 'description': description};
}
