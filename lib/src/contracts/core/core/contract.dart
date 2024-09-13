import 'package:ton_dart/src/address/address/address.dart';

import 'provider.dart';

/// An abstract base class representing a TON (The Open Network) contract.
///
/// This class provides a structure for working with TON contracts, including their
/// state and address. Specific contract implementations should extend this class
/// and provide concrete implementations for the contract's state and address.
abstract class TonContract<T> with ContractProvider {
  const TonContract();

  /// The state associated with this contract.
  ///
  /// This represents the current state of the contract, which may be of type [T].
  /// The state is not guaranteed to be non-null; it can be null depending on the
  /// contract's implementation and context.
  abstract final T? state;

  /// The address of this contract on the TON blockchain.
  ///
  /// This is a unique identifier for the contract on the blockchain and is used
  /// to interact with the contract, such as sending messages or querying data.
  @override
  abstract final TonAddress address;
}
