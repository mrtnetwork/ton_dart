import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/ft/contract/wallet/stable_jetton_wallet.dart';
import 'package:ton_dart/src/contracts/token/ft/types/models/stable_minter_data.dart';
import 'package:ton_dart/src/contracts/token/ft/types/state/stable_minter.dart';
import 'package:ton_dart/src/contracts/token/ft/types/operations/stable_jetton.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/provider/provider/provider.dart';
import 'package:ton_dart/src/contracts/token/ft/constants/constant/minter.dart';

class StableJettonMinter<E extends WalletContractTransferParams>
    extends TonContract<StableTokenMinterState> with ContractProvider {
  final WalletContract<dynamic, E> owner;
  @override
  final TonAddress address;
  @override
  final StableTokenMinterState? state;

  const StableJettonMinter(
      {required this.owner, required this.address, this.state});
  factory StableJettonMinter.create({
    required WalletContract<dynamic, E> owner,
    required StableTokenMinterState state,
  }) {
    return StableJettonMinter(
        owner: owner,
        address: TonAddress.fromState(
            state: state.initialState(), workChain: owner.address.workChain),
        state: state);
  }
  static Future<StableJettonMinter>
      fromAddress<E extends WalletContractTransferParams>(
          {required WalletContract<dynamic, E> owner,
          required TonAddress address,
          required TonProvider rpc}) async {
    final stateData =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state =
        StableTokenMinterState.deserialize(stateData.data!.beginParse());

    return StableJettonMinter(owner: owner, address: address, state: state);
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
    return await owner.sendTransfer(
        params: params,
        messages: [
          TonHelper.internal(
            destination: address,
            amount: amount,
            initState: state,
            bounced: bounced,
            body: body,
            bounce: bounce ?? address.isBounceable,
          ),
        ],
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode,
        onEstimateFee: onEstimateFee);
  }

  Future<String> deploy(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      OnEstimateFee? onEstimateFee}) async {
    final active = await isActive(rpc);
    if (active) {
      throw const TonContractException('Account is already active.');
    }
    if (state == null) {
      throw const TonContractException(
          'For deploy minter please use create constructor to build state');
    }
    return _sendTransaction(
        params: params,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: beginCell()
            .storeUint32(JettonMinterConst.deployOperation)
            .storeUint64(BigInt.zero)
            .endCell(),
        bounce: bounce,
        bounced: bounced,
        state: state!.initialState(),
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
  /// - `operation`: The operation to be executed as part of the transaction, encapsulated in a [StableJettonMinterOperation] object.
  /// - `sendMode`: Specifies how the transaction fees are handled. The default is [SendModeConst.payGasSeparately].
  Future<String> sendOperation(
      {required E signerParams,
      required TonProvider rpc,
      required StableJettonMinterOperation operation,
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

  Future<StableTokenMinterData> getJettonData(TonProvider rpc) async {
    final data = await getStateStack(rpc: rpc, method: 'get_jetton_data');
    return StableTokenMinterData.fromTuple(data.reader());
  }

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

  Future<StableJettonWallet<T>>
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
    final address = data.reader().readAddress();
    return StableJettonWallet.fromAddress(
        address: address, owner: owner, rpc: rpc);
  }

  Future<BigInt> totalSupply(TonProvider rpc) async {
    final data = await getJettonData(rpc);
    return data.totalSupply;
  }

  Future<TonAddress?> adminAddress(TonProvider rpc) async {
    final data = await getJettonData(rpc);
    return data.adminAddress;
  }

  Future<TonAddress?> getNextAdminAddress(TonProvider rpc) async {
    final data =
        await getStateStack(rpc: rpc, method: 'get_next_admin_address');
    return data.reader().readAddressOpt();
  }
}
