import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/ft/contract/contracts.dart';
import 'package:ton_dart/src/contracts/token/ft/types/types.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/provider/provider/provider.dart';

class JettonMinter<E extends WalletContractTransferParams>
    extends TonContract<MinterWalletState> with ContractProvider {
  /// the minter contract owner wallet
  final WalletContract<dynamic, E> owner;

  /// address of contract
  @override
  final TonAddress address;

  /// state of contract
  @override
  final MinterWalletState? state;

  const JettonMinter({required this.owner, required this.address, this.state});
  factory JettonMinter.create({
    required WalletContract<dynamic, E> owner,
    required MinterWalletState state,
  }) {
    return JettonMinter(
        owner: owner,
        address: TonAddress.fromState(
            state: state.initialState(), workChain: owner.address.workChain),
        state: state);
  }
  static Future<JettonMinter>
      fromAddress<E extends WalletContractTransferParams>(
          {required WalletContract<dynamic, E> owner,
          required TonAddress address,
          required TonProvider rpc}) async {
    final stateData =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state = MinterWalletState.deserialize(stateData.data!.beginParse());
    return JettonMinter(owner: owner, address: address, state: state);
  }

  Future<String> _sendTransaction({
    required E params,
    required TonProvider rpc,
    required BigInt amount,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
    Cell? body,
    OnEstimateFee? onEstimateFee,
    TonTransactionAction action = TonTransactionAction.broadcast,
  }) async {
    final active = await isActive(rpc);
    if (!active && state == null) {
      throw const TonContractException(
          'The account is inactive and requires state initialization.');
    }
    return await owner.sendTransfer(
        params: params,
        messages: [
          TonHelper.internal(
            destination: address,
            amount: amount,
            initState: active ? null : state!.initialState(),
            bounced: bounced,
            body: body,
            bounce: bounce ?? address.isBounceable,
          ),
        ],
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode,
        onEstimateFee: onEstimateFee,
        action: action);
  }

  /// deploy contract
  Future<String> deploy(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body,
      OnEstimateFee? onEstimateFee}) async {
    return _sendTransaction(
        params: params,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: body,
        bounce: bounce,
        bounced: bounced,
        timeout: timeout,
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
  /// - `operation`: The operation to be executed as part of the transaction, encapsulated in a [JettonMinterOperation] object.
  /// - `sendMode`: Specifies how the transaction fees are handled. The default is [SendModeConst.payGasSeparately].
  Future<String> sendOperation({
    required E signerParams,
    required TonProvider rpc,
    required BigInt amount,
    required JettonMinterOperation operation,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
  }) {
    return _sendTransaction(
        params: signerParams,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: operation.toBody(),
        bounce: bounce,
        bounced: bounced,
        timeout: timeout);
  }

  /// get jetton data
  Future<MinterWalletState> getJettonData(TonProvider rpc) async {
    final data = await getStateStack(rpc: rpc, method: 'get_jetton_data');
    return MinterWalletState.fromTupple(data.reader());
  }

  /// get jetton wallet address
  Future<TonAddress> getWalletAddress(
      {required TonProvider rpc, required TonAddress owner}) async {
    final data =
        await getStateStack(rpc: rpc, method: 'get_wallet_address', stack: [
      if (rpc.isTonCenter)
        ['tvm.Slice', beginCell().storeAddress(owner).endCell().toBase64()]
      else
        owner.toString()
    ]);
    return data.reader().readAddress();
  }

  /// get jetton wallet contract
  Future<JettonWallet<T>>
      getJettonWalletContract<T extends WalletContractTransferParams>(
          {required TonProvider rpc,
          required WalletContract<ContractState, T> owner}) async {
    final data =
        await getStateStack(rpc: rpc, method: 'get_wallet_address', stack: [
      if (rpc.isTonCenter)
        [
          'tvm.Slice',
          beginCell().storeAddress(owner.address).endCell().toBase64()
        ]
      else
        owner.address.toString()
    ]);
    return JettonWallet.fromAddress<T>(
        address: data.reader().readAddress(), owner: owner, rpc: rpc);
  }

  /// total supply
  Future<BigInt> totalSupply(TonProvider rpc) async {
    final data = await getJettonData(rpc);
    return data.totalSupply;
  }

  /// admin address of jetton
  Future<TonAddress?> adminAddress(TonProvider rpc) async {
    final data = await getJettonData(rpc);
    return data.owner;
  }

  /// jetton content
  Future<Cell> getContent(TonProvider rpc) async {
    final data = await getJettonData(rpc);
    return data.content;
  }

  /// jetton metadata
  Future<TokenMetadata?> getMetadata(TonProvider rpc) async {
    final data = await getJettonData(rpc);
    return TokneMetadataUtils.loadContent(data.content);
  }
}
