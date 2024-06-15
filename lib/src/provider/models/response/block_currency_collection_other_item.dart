import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

class BlockCurrencyCollectionOtherItemResponse with JsonSerialization {
  final BigInt id;
  final String value;

  const BlockCurrencyCollectionOtherItemResponse(
      {required this.id, required this.value});

  factory BlockCurrencyCollectionOtherItemResponse.fromJson(
      Map<String, dynamic> json) {
    return BlockCurrencyCollectionOtherItemResponse(
      id: BigintUtils.parse(json['id']),
      value: json['value'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'value': value,
    };
  }
}
