import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';

class ActionSimplePreviewResponse with JsonSerialization {
  final String name;
  final String description;
  final String? actionImage;
  final String? value;
  final String? valueImage;
  final List<AccountAddressResponse> accounts;

  const ActionSimplePreviewResponse({
    required this.name,
    required this.description,
    this.actionImage,
    this.value,
    this.valueImage,
    required this.accounts,
  });

  factory ActionSimplePreviewResponse.fromJson(Map<String, dynamic> json) {
    return ActionSimplePreviewResponse(
      name: json['name'] as String,
      description: json['description'] as String,
      actionImage: json['action_image'],
      value: json['value'],
      valueImage: json['value_image'],
      accounts: (json['accounts'] as List)
          .map((e) => AccountAddressResponse.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'accounts': accounts.map((e) => e.toJson()).toList(),
      'action_image': actionImage,
      'value': value,
      'value_image': valueImage
    };
  }
}
