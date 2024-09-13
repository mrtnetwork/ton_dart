import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/token/ft/types/operations/stable_jetton.dart';
import 'package:ton_dart/src/contracts/token/ft/types/state/stable_wallet.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/utils/transaction_utils.dart';

class StableJettonWallet<E extends WalletContractTransferParams>
    extends TonContract<StableJettonWalletState> {
  final WalletContract<ContractState, E> owner;
  @override
  final TonAddress address;
  @override
  final StableJettonWalletState? state;

  const StableJettonWallet(
      {required this.owner, required this.state, required this.address});
  static Future<StableJettonWallet<E>>
      fromAddress<E extends WalletContractTransferParams>(
          {required TonAddress address,
          required WalletContract<ContractState, E> owner,
          required TonProvider rpc}) async {
    final stateData =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state =
        StableJettonWalletState.deserialize(stateData.data!.beginParse());
    return StableJettonWallet(owner: owner, state: state, address: address);
  }

  Future<String> _sendTransaction(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body,
      StateInit? state,
      OnEstimateFee? onEstimateFee}) async {
    final message = TransactioUtils.internal(
        destination: address,
        amount: amount,
        initState: state,
        bounced: bounced,
        body: body,
        bounce: bounce ?? address.isBounceable);
    return await owner.sendTransfer(
        messages: [message],
        params: params,
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode,
        onEstimateFee: onEstimateFee);
  }

  /// Sends a transaction operation.
  ///
  /// This method facilitates sending a transaction with a specified operation, amount, and other parameters
  /// to contract.
  ///
  /// - `params`: owner wallet specify parameters for transfer.
  /// - `rpc`: The RPC provider used to interact with the blockchain.
  /// - `amount`: The amount of cryptocurrency to be sent in the transaction.
  /// - `operation`: The operation to be executed as part of the transaction, encapsulated in a [StableJettonWalletOperation] object.
  /// - `sendMode`: Specifies how the transaction fees are handled. The default is [SendModeConst.payGasSeparately].
  Future<String> sendOperation(
      {required E signerParams,
      required TonProvider rpc,
      required StableJettonWalletOperation operation,
      required BigInt amount,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      OnEstimateFee? onEstimateFee}) async {
    return _sendTransaction(
        params: signerParams,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: operation.toBody(),
        bounce: bounce,
        bounced: bounced,
        timeout: timeout,
        onEstimateFee: onEstimateFee);
  }

  Future<BigInt> getBalance(TonProvider rpc) async {
    final data = await getWalletData(rpc);
    return data.balance;
  }

  Future<StableJettonWalletState> getWalletData(TonProvider rpc) async {
    final data = await getStateStack(rpc: rpc, method: "get_wallet_data");
    return StableJettonWalletState.fromTuple(data.reader());
  }

  Future<StableTokenWalletStatus> getStatus(TonProvider rpc) async {
    final data = await getStateStack(rpc: rpc, method: "get_status");
    return StableTokenWalletStatus.fromTag(data.reader().readNumber());
  }
}
