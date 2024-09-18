import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/constant/constants/mutli_owner.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/order.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/utils/multi_owner.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';

class OrderContract<E extends WalletContractTransferParams>
    extends TonContract<OrderContractState> {
  @override
  final TonAddress address;

  @override
  final OrderContractState? state;
  final WalletContract<ContractState, E> owner;
  const OrderContract({required this.address, required this.owner, this.state});

  factory OrderContract.create(
      {TonChain? chain,
      required TonAddress multisig,
      required BigInt orderSeqno,
      required WalletContract<ContractState, E> owner}) {
    final stateInit =
        OrderContractState(multisig: multisig, orderSeqno: orderSeqno);
    final state = stateInit.initialState();
    return OrderContract(
        address: TonAddress.fromState(
            state: state, workChain: chain?.workchain ?? owner.chain.workchain),
        owner: owner,
        state: stateInit);
  }
  OrderContract changeOwnerWallet<T extends WalletContractTransferParams>(
      WalletContract<ContractState, T> wallet) {
    return OrderContract<T>(address: address, owner: wallet, state: state);
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
          )
        ],
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode,
        onEstimateFee: onEstimateFee);
  }

  Cell initMessageBody(
      {required List<TonAddress> signers,
      required BigInt expirationDate,
      required Cell order,
      required int threshold,
      bool approveOnInit = false,
      int signerIdx = 0,
      BigInt? queryId}) {
    final signersDict = MultiOwnerContractUtils.signersToDict(signers);
    final msgBody = beginCell()
        .storeUint32(MultiOwnerContractConst.orderInitOperation)
        .storeUint64(queryId ?? BigInt.zero)
        .storeUint8(threshold)
        .storeRef(beginCell().storeDictDirect(signersDict).endCell())
        .storeUint(expirationDate, 48)
        .storeRef(order)
        .storeBitBolean(approveOnInit);

    if (approveOnInit) {
      msgBody.storeUint8(signerIdx);
    }
    return msgBody.endCell();
  }

  Cell approveMessageBody({BigInt? queryId, required int signerIdx}) {
    return beginCell()
        .storeUint32(MultiOwnerContractConst.approveOperation)
        .storeUint64(queryId ?? BigInt.zero)
        .storeUint8(signerIdx)
        .endCell();
  }

  Future<String> sendApprove(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      int? signerIdx,
      BigInt? queryId,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      OnEstimateFee? onEstimateFee}) async {
    final active = await isActive(rpc);
    if (!active) {
      throw const TonContractException(
          "canoot send approve before deploying contarct. please first use deply method for deploying.");
    }
    if (signerIdx == null) {
      if (state == null) {
        throw const TonContractException(
            "cannot send approve without known signer index. please first use deply method for deploying.");
      }
      signerIdx = state!.signers.indexOf(owner.address);
    }
    if (signerIdx < 0) {
      throw const TonContractException("cannot find signer.");
    }
    return _sendTransaction(
        params: params,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: approveMessageBody(signerIdx: signerIdx, queryId: queryId),
        bounce: bounce,
        bounced: bounced,
        timeout: timeout,
        onEstimateFee: onEstimateFee);
  }

  Future<OrderContractState> getOrderData(TonProvider rpc) async {
    final state =
        await getStateStack(rpc: rpc, method: "get_order_data", stack: []);
    final stack = state.reader();
    final multisig = stack.readAddress();
    final orderSeqno = stack.readBigNumber();
    final threshold = stack.readNumberOpt();
    final executed = stack.readBooleanOpt();
    final signers =
        MultiOwnerContractUtils.signerCellToList(stack.readCellOpt());
    final approvals = stack.readBigNumberOpt();
    final approvalsNum = stack.readNumberOpt();
    final expirationDate = stack.readBigNumberOpt();
    final order = stack.readCellOpt();
    List<bool> approvalsArray = [];
    if (approvals != null) {
      approvalsArray = List<bool>.filled(256, false);
      for (int i = 0; i < 256; i++) {
        approvalsArray[i] =
            ((BigInt.one << i) & approvals) == BigInt.zero ? false : true;
      }
    }
    return OrderContractState(
        multisig: multisig,
        orderSeqno: orderSeqno,
        threshold: threshold,
        approvals: approvals,
        approvalsNum: approvalsNum,
        executed: executed,
        signers: signers,
        expirationDate: expirationDate,
        order: order);
  }
}
