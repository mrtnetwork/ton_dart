import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/contract.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
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
  Cell data(params) {
    return beginCell().endCell();
  }

  Future<String> _sendTransaction(
      {required TonPrivateKey privateKey,
      required TonApiProvider rpc,
      required BigInt amount,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool bounce = false,
      bool bounced = false,
      Cell? body,
      StateInit? state}) async {
    final message = TransactioUtils.internal(
        destination: address,
        amount: amount,
        initState: state,
        bounced: bounced,
        body: body,
        bounce: bounce);
    return await owner.sendTransfer(
        messages: [message, ...messages],
        privateKey: privateKey,
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode);
  }

  Future<String> deploy(
      {required TonPrivateKey ownerPrivateKey,
      required TonApiProvider rpc,
      required BigInt amount,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool bounce = false,
      bool bounced = false,
      Cell? body}) async {
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
      required TonAddress to,
      required TonAddress from,
      required BigInt forwardTonAmount,
      Cell? customPayload,
      Cell? forwardPayload}) {
    return beginCell()
        .storeUint(JettonWalletConst.transfer, 32)
        .storeUint(0, 64) // op, queryId
        .storeCoins(jettonAmount)
        .storeAddress(to)
        .storeAddress(from)
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

  Future<String> transfer({
    required TonPrivateKey privateKey,
    required TonApiProvider rpc,
    required TonAddress destination,
    required BigInt forwardTonAmount,
    required BigInt jettonAmount,
    required BigInt amount,
    List<MessageRelaxed> messages = const [],
    SendMode sendMode = SendMode.payGasSeparately,
    int? timeout,
    bool bounce = false,
    bool bounced = false,
    Cell? customPayload,
    Cell? forwardPayload,
  }) async {
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: transferMessageBody(
            from: address,
            to: destination,
            forwardTonAmount: forwardTonAmount,
            jettonAmount: jettonAmount,
            customPayload: customPayload,
            forwardPayload: forwardPayload),
        bounce: bounce,
        bounced: bounced,
        messages: messages,
        timeout: timeout);
  }

  Future<String> burn({
    required TonPrivateKey privateKey,
    required TonApiProvider rpc,
    required BigInt burnJettonAmount,
    required BigInt amount,
    List<MessageRelaxed> messages = const [],
    SendMode sendMode = SendMode.payGasSeparately,
    int? timeout,
    bool bounce = false,
    bool bounced = false,
    Cell? customPayload,
  }) async {
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
        timeout: timeout);
  }

  Future<String> withdrawTons({
    required TonPrivateKey privateKey,
    required TonApiProvider rpc,
    required BigInt amount,
    List<MessageRelaxed> messages = const [],
    SendMode sendMode = SendMode.payGasSeparately,
    int? timeout,
    bool bounce = false,
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
        timeout: timeout);
  }

  Future<String> withdrawJettons({
    required TonPrivateKey privateKey,
    required TonApiProvider rpc,
    required BigInt withdrawAmount,
    required BigInt amount,
    required TonAddress from,
    List<MessageRelaxed> messages = const [],
    SendMode sendMode = SendMode.payGasSeparately,
    int? timeout,
    bool bounce = false,
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
        timeout: timeout);
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

  Future<BigInt> getBalance(TonApiProvider rpc) async {
    final data = await getMethod(rpc: rpc, method: "get_wallet_data");
    final reader = data.reader;
    final balance = reader.readBigNumber();
    return balance;
  }

  Future<TonAddress> getWalletAddress(
      {required TonApiProvider rpc, required TonAddress owner}) async {
    final data =
        await getMethod(rpc: rpc, method: "get_wallet_address", stack: [
      ["tvm.Slice", beginCell().storeAddress(owner).endCell().toBase64()]
    ]);
    return data.reader.readAddress();
  }

  @override
  int? get subWalletId => null;
}
