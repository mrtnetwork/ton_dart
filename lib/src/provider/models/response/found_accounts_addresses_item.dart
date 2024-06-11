import 'package:ton_dart/src/serialization/serialization.dart';

class FoundAccountsAddressesItemResponse with JsonSerialization {
  final String address;
  final String name;
  final String preview;

  const FoundAccountsAddressesItemResponse(
      {required this.address, required this.name, required this.preview});

  factory FoundAccountsAddressesItemResponse.fromJson(
      Map<String, dynamic> json) {
    return FoundAccountsAddressesItemResponse(
        address: json['address'], name: json['name'], preview: json['preview']);
  }

  @override
  Map<String, dynamic> toJson() =>
      {'address': address, 'name': name, 'preview': preview};
}
