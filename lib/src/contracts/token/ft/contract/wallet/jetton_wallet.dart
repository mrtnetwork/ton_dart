import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/token/ft/types/operations/jetton.dart';
import 'package:ton_dart/src/contracts/token/ft/types/state/wallet.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/tuple/tuple.dart';

class JettonWallet<E extends WalletContractTransferParams>
    extends TonContract<JettonWalletState> {
  /// jetton wallet owner addresss
  final WalletContract<ContractState, E> owner;

  /// contract address
  @override
  final TonAddress address;

  /// state
  @override
  final JettonWalletState? state;

  const JettonWallet({
    required this.owner,
    required this.state,
    required this.address,
  });
  static Future<JettonWallet<E>>
  fromAddress<E extends WalletContractTransferParams>({
    required TonAddress address,
    required WalletContract<ContractState, E> owner,
    required TonQuickClient client,
  }) async {
    final stateData = await ContractProvider.getActiveState(
      client: client,
      address: address,
    );
    final state = JettonWalletState.deserialize(stateData.data!.beginParse());
    return JettonWallet(owner: owner, state: state, address: address);
  }

  Future<String> _sendTransaction({
    required E params,
    required TonQuickClient client,
    required BigInt amount,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
    Cell? body,
    StateInit? state,
    OnEstimateFee? onEstimateFee,
    TonTransactionAction action = TonTransactionAction.broadcast,
  }) async {
    final message = TonHelper.internal(
      destination: address,
      amount: amount,
      initState: state,
      bounced: bounced,
      body: body,
      bounce: bounce ?? address.isBounceable,
    );
    return await owner.sendTransfer(
      messages: [message],
      params: params,
      client: client,
      timeout: timeout,
      sendMode: sendMode,
      onEstimateFee: onEstimateFee,
      action: action,
    );
  }

  /// Sends a transaction operation.
  ///
  /// This method facilitates sending a transaction with a specified operation, amount, and other parameters
  /// to contract.
  ///
  /// - `params`: owner wallet specify parameters for transfer.
  /// - `client`: The RPC provider used to interact with the blockchain.
  /// - `amount`: The amount of cryptocurrency to be sent in the transaction.
  /// - `operation`: The operation to be executed as part of the transaction, encapsulated in a [JettonWalletOperation] object.
  /// - `sendMode`: Specifies how the transaction fees are handled. The default is [SendModeConst.payGasSeparately].
  Future<String> sendOperation({
    required E signerParams,
    required TonQuickClient client,
    required JettonWalletOperation operation,
    required BigInt amount,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
    OnEstimateFee? onEstimateFee,
    TonTransactionAction action = TonTransactionAction.broadcast,
  }) async {
    return _sendTransaction(
      params: signerParams,
      client: client,
      amount: amount,
      sendMode: sendMode,
      body: operation.toBody(),
      bounce: bounce,
      bounced: bounced,
      timeout: timeout,
      onEstimateFee: onEstimateFee,
      action: action,
    );
  }

  /// get contract balance
  Future<BigInt> getBalance(TonQuickClient client) async {
    final data = await getWalletData(client);
    return data.balance;
  }

  /// get wallet data
  Future<JettonWalletState> getWalletData(TonQuickClient client) async {
    final data = await getStateStack(client: client, method: 'get_wallet_data');
    return JettonWalletState.fromTuple(data.reader());
  }

  /// get wallet address
  Future<TonAddress> getWalletAddress({
    required TonQuickClient client,
    required TonAddress owner,
  }) async {
    final data = await getStateStack(
      client: client,
      method: 'get_wallet_address',
      stack: [
        TupleItemSlice(beginCell().storeAddress(owner).endCell()),
      ],
    );
    return data.reader().readAddress();
  }

  /// read current contract state
  Future<JettonWalletState> readState(TonQuickClient client) async {
    final stateData = await ContractProvider.getActiveState(
      client: client,
      address: address,
    );
    return JettonWalletState.deserialize(stateData.data!.beginParse());
  }
}
