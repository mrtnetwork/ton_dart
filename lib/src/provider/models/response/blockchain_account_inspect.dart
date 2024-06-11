import 'package:ton_dart/src/serialization/serialization.dart';
import 'blockchain_account_inspect_methods_item.dart';

class BlockchainAccountInspectResponse with JsonSerialization {
  final String code;
  final String codeHash;
  final List<BlockchainAccountInspectMethodsItemResponse> methods;
  final String? compiler;

  const BlockchainAccountInspectResponse({
    required this.code,
    required this.codeHash,
    required this.methods,
    required this.compiler,
  });

  factory BlockchainAccountInspectResponse.fromJson(Map<String, dynamic> json) {
    return BlockchainAccountInspectResponse(
      code: json['code'],
      codeHash: json['code_hash'],
      methods: List<BlockchainAccountInspectMethodsItemResponse>.from(
          json['methods'].map(
              (x) => BlockchainAccountInspectMethodsItemResponse.fromJson(x))),
      compiler: json['compiler'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'code_hash': codeHash,
      'methods': methods.map((x) => x.toJson()).toList(),
      'compiler': compiler,
    };
  }
}
