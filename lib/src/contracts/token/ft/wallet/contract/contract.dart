import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/contract.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/ft/wallet/models/jetton_transfer_params.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/token/ft/wallet/constants/contants.dart';
import 'package:ton_dart/src/contracts/token/ft/wallet/utils/utils.dart';
import 'package:ton_dart/src/contracts/utils/transaction_utils.dart';

class JettonWallet extends TonContract {
  final VersonedWalletContract owner;

  @override
  final TonAddress address;

  @override
  final StateInit state;

  const JettonWallet(
      {required this.owner, required this.state, required this.address});
  factory JettonWallet.fromAddress(
      {required TonAddress jettonWalletAddress,
      required VersonedWalletContract owner}) {
    return JettonWallet(
        owner: owner,
        state: JettonWalletUtils.buildState(owner.workChain),
        address: jettonWalletAddress);
  }

  @override
  Cell code(int workchain) {
    return JettonWalletConst.code(workchain);
  }

  @override
  Cell data(params, int workchain) {
    return beginCell().endCell();
  }

  Future<String> _sendTransaction(
      {required TonPrivateKey privateKey,
      required TonProvider rpc,
      required BigInt amount,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body,
      StateInit? state,
      OnEstimateFee? onEstimateFees}) async {
    final message = TransactioUtils.internal(
        destination: address,
        amount: amount,
        initState: state,
        bounced: bounced,
        body: body,
        bounce: bounce ?? address.isBounceable);
    return await owner.sendTransfer(
        messages: [message, ...messages],
        privateKey: privateKey,
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode,
        onEstimateFee: onEstimateFees);
  }

  Future<String> deploy(
      {required TonPrivateKey ownerPrivateKey,
      required TonProvider rpc,
      required BigInt amount,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body,
      OnEstimateFee? onEstimateFees}) async {
    final active = await isActive(rpc);
    if (active) {
      throw TonContractException("Account is already active.");
    }
    return _sendTransaction(
        privateKey: ownerPrivateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: body,
        bounce: bounce,
        bounced: bounced,
        state: state,
        messages: messages,
        timeout: timeout);
  }

  Cell transferMessageBody(
      {required BigInt jettonAmount,
      required TonAddress destination,
      required TonAddress responseDestination,
      required BigInt forwardTonAmount,
      Cell? customPayload,
      Cell? forwardPayload}) {
    return beginCell()
        .storeUint(JettonWalletConst.transfer, 32)
        .storeUint(0, 64) // op, queryId
        .storeCoins(jettonAmount)
        .storeAddress(destination)
        .storeAddress(responseDestination)
        .storeMaybeRef(cell: customPayload)
        .storeCoins(forwardTonAmount)
        .storeMaybeRef(cell: forwardPayload)
        .endCell();
  }

  Cell burnMessageBody(
      {required BigInt burnAmount,
      required TonAddress from,
      Cell? customPayload}) {
    return beginCell()
        .storeUint(JettonWalletConst.burn, 32)
        .storeUint(0, 64) // op, queryId
        .storeCoins(burnAmount)
        .storeAddress(from)
        .storeMaybeRef(cell: customPayload)
        .endCell();
  }

  Cell withdrawTonsMessageBody() {
    return beginCell().storeUint(0x6d8e5e3c, 32).storeUint(0, 64).endCell();
  }

  Future<String> transfer(
      {required TonPrivateKey privateKey,
      required TonProvider rpc,
      required TonAddress destination,
      required BigInt forwardTonAmount,
      required BigInt jettonAmount,
      required BigInt amount,
      Cell? customPayload,
      Cell? forwardPayload,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      OnEstimateFee? onEstimateFees}) async {
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: transferMessageBody(
            responseDestination: owner.address,
            destination: destination,
            forwardTonAmount: forwardTonAmount,
            jettonAmount: jettonAmount,
            customPayload: customPayload,
            forwardPayload: forwardPayload),
        bounce: bounce,
        bounced: bounced,
        messages: messages,
        timeout: timeout,
        onEstimateFees: onEstimateFees);
  }

  Future<String> multipleTransfer(
      {required List<JettonTransferParams> transfers,
      required TonPrivateKey signerKey,
      required TonProvider rpc,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      OnEstimateFee? onEstimateFees}) async {
    final jettonMessages = transfers.map((e) => TransactioUtils.internal(
        destination: address,
        amount: e.amount,
        initState: state,
        body: transferMessageBody(
            responseDestination: owner.address,
            destination: e.destination,
            forwardTonAmount: e.forwardTonAmount,
            jettonAmount: e.jettonAmount,
            customPayload: e.customPayload,
            forwardPayload: e.forwardPayload),
        bounce: e.destination.isBounceable));
    return await owner.sendTransfer(
        messages: [...jettonMessages, ...messages],
        privateKey: signerKey,
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode,
        onEstimateFee: onEstimateFees);
  }

  Future<String> burn(
      {required TonPrivateKey privateKey,
      required TonProvider rpc,
      required BigInt burnJettonAmount,
      required BigInt amount,
      Cell? customPayload,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      OnEstimateFee? onEstimateFees}) async {
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: burnMessageBody(
            from: owner.address,
            customPayload: customPayload,
            burnAmount: burnJettonAmount),
        bounce: bounce,
        bounced: bounced,
        messages: messages,
        timeout: timeout,
        onEstimateFees: onEstimateFees);
  }

  Future<String> withdrawTons({
    required TonPrivateKey privateKey,
    required TonProvider rpc,
    required BigInt amount,
    OnEstimateFee? onEstimateFees,
    List<MessageRelaxed> messages = const [],
    SendMode sendMode = SendMode.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
  }) async {
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: withdrawTonsMessageBody(),
        bounce: bounce,
        bounced: bounced,
        messages: messages,
        timeout: timeout,
        onEstimateFees: onEstimateFees);
  }

  Future<String> withdrawJettons({
    required TonPrivateKey privateKey,
    required TonProvider rpc,
    required BigInt withdrawAmount,
    required BigInt amount,
    required TonAddress from,
    List<MessageRelaxed> messages = const [],
    OnEstimateFee? onEstimateFees,
    SendMode sendMode = SendMode.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
  }) async {
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: withdrawJettonsMessageBody(from: from, amount: withdrawAmount),
        bounce: bounce,
        bounced: bounced,
        messages: messages,
        timeout: timeout,
        onEstimateFees: onEstimateFees);
  }

  Cell withdrawJettonsMessageBody(
      {required TonAddress from, required BigInt amount}) {
    return beginCell()
        .storeUint(0x768a50b2, 32)
        .storeUint(0, 64)
        .storeAddress(from)
        .storeCoins(amount)
        .storeMaybeRef()
        .endCell();
  }

  Future<BigInt> getBalance(TonProvider rpc) async {
    final data = await getStateStack(rpc: rpc, method: "get_wallet_data");
    final reader = data.reader();
    final balance = reader.readBigNumber();
    return balance;
  }

  Future<TonAddress> getWalletAddress(
      {required TonProvider rpc, required TonAddress owner}) async {
    final data =
        await getStateStack(rpc: rpc, method: "get_wallet_address", stack: [
      if (rpc.isTonCenter)
        ["tvm.Slice", beginCell().storeAddress(owner).endCell().toBase64()]
      else
        owner.toString()
    ]);
    return data.reader().readAddress();
  }

  @override
  int? get subWalletId => null;
}
