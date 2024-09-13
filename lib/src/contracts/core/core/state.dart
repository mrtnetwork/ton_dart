import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

/// An abstract base class representing the state of a contract.
///
/// This class provides a structure for managing and interacting with the state of a contract.
/// It defines methods for obtaining the initial state and initial data of the contract.
abstract class ContractState {
  const ContractState();

  /// Returns the initial state of the contract.
  ///
  /// This method provides the initial state configuration required when deploying
  /// a contract. The `StateInit` object represents the initialization parameters or
  /// settings needed for the contract.
  StateInit initialState();

  /// Returns the initial data associated with the contract.
  ///
  /// This method provides the initial data that the contract will operate on
  /// when it is deployed. The `Cell` object represents a cell of data in the
  /// TON blockchain format.
  Cell initialData();
}
