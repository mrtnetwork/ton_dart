import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider/provider.dart';

typedef OnEstimateFee = Future<void> Function(Message message);

enum TonTransactionAction {
  /// Broadcasts the transaction to the network and returns the transaction hash.
  broadcast,

  /// Returns the serialized BOC as a base58 string without broadcasting.
  boc;

  bool get isBroadcast => this == broadcast;
}

abstract class WalletContract<C extends ContractState,
    T extends WalletContractTransferParams> extends TonContract<C> {
  const WalletContract(
      {required this.state, required this.address, required this.chain});
  @override
  final C? state;

  @override
  final TonAddress address;
  final TonChainId chain;

  Future<String> sendTransfer(
      {required T params,
      required List<MessageRelaxed> messages,
      required TonProvider rpc,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      required OnEstimateFee? onEstimateFee,
      required TonTransactionAction action});
}
