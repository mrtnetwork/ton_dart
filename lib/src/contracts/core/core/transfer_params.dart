import 'package:ton_dart/src/models/models/out_action.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';

/// the interface for wallet contracts for called transfer method from another contract like jetton and nfts
/// [messages] the messages to be transfer from specify wallet
abstract class WalletContractTransferParams<T extends OutAction> {
  final List<T> messages;
  WalletContractTransferParams({required List<T> messages})
      : messages = messages.immutable;
}
