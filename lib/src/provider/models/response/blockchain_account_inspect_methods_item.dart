import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class BlockchainAccountInspectMethodsItemResponse with JsonSerialization {
  final BigInt id;
  final String method;

  const BlockchainAccountInspectMethodsItemResponse(
      {required this.id, required this.method});

  factory BlockchainAccountInspectMethodsItemResponse.fromJson(
      Map<String, dynamic> json) {
    return BlockchainAccountInspectMethodsItemResponse(
        id: BigintUtils.parse(json['id']), method: json['method']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'method': method,
    };
  }
}
