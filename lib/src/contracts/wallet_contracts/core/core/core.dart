import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider/provider.dart';

typedef OnEstimateFee = Future<void> Function(Message message);

abstract class WalletContract<C extends ContractState,
    T extends WalletContractTransferParams> extends TonContract<C> {
  const WalletContract(
      {required this.state, required this.address, required this.chain});
  @override
  final C? state;

  @override
  final TonAddress address;
  final TonChain chain;

  Future<String> sendTransfer(
      {required T params,
      required List<MessageRelaxed> messages,
      required TonProvider rpc,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      OnEstimateFee? onEstimateFee});
}
