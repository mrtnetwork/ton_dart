import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

abstract class ContractOperationType {
  /// contract operation id
  final int operation;

  /// contract operation name
  final String name;
  const ContractOperationType({required this.operation, required this.name});
  @override
  String toString() {
    return '$runtimeType.$name';
  }
}

abstract class ContractOperation extends TonSerialization {
  /// contract name
  abstract final String contractName;

  /// the type of operation
  abstract final ContractOperationType type;

  /// contract code
  Cell contractCode(TonChain chain);
}
