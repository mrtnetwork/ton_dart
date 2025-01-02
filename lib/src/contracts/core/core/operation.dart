import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

abstract class ContractOperationType {
  final int operation;
  final String name;
  const ContractOperationType({required this.operation, required this.name});
  @override
  String toString() {
    return '$runtimeType.$name';
  }
}

abstract class ContractOperation extends TonSerialization {
  abstract final String contractName;
  abstract final ContractOperationType type;

  Cell contractCode(TonChain chain);
}
