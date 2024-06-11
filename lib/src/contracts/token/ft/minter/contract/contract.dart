import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/contract.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/ft/minter/models/minter_wallet_params.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/provider/provider/provider.dart';
import 'package:ton_dart/src/tuple/tuple.dart';
import 'package:ton_dart/src/contracts/core/provider.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/token/ft/minter/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/ft/minter/models/jetton_data_response.dart';
import 'package:ton_dart/src/contracts/token/ft/minter/utils/utils.dart';
import 'package:ton_dart/src/contracts/utils/transaction_utils.dart';

class JettonMinter extends TonContract<MinterWalletParams>
    with ContractProvider {
  final VersonedWalletContract owner;
  @override
  final TonAddress address;
  @override
  final StateInit? state;

  const JettonMinter({required this.owner, required this.address, this.state});
  factory JettonMinter.create(
      {required VersonedWalletContract owner,
      String? content,
      StateInit? state}) {
    state ??=
        JettonMinterUtils.buildState(owner: owner.address, contentUri: content);
    return JettonMinter(
        owner: owner,
        address: TonAddress.fromState(state: state, workChain: owner.workChain),
        state: state);
  }
  @override
  Cell code(int workchain) {
    return JettonMinterUtils.code(workchain);
  }

  @override
  Cell data(MinterWalletParams params) {
    return JettonMinterUtils.minterData(
        owner: params.owner,
        walletCode: params.walletCode ?? code(workChain),
        contentUri: params.contentUri);
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
      bounce: bounce,
    );
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
    if (state == null) {
      throw TonContractException(
          "For deploy minter please use create constructor to build state");
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

  Future<String> mint(
      {required TonPrivateKey privateKey,
      required TonApiProvider rpc,
      required BigInt jettonAmout,
      required BigInt forwardTonAmount,
      required BigInt totalTonAmount,
      required BigInt amount,
      required TonAddress to,
      int queryId = 0,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool bounce = false,
      bool bounced = false,
      Cell? body}) async {
    if (totalTonAmount < forwardTonAmount) {
      throw TonContractException(
          "Forward ton amount must be lower than total ton amout");
    }
    if (amount <= totalTonAmount) {
      throw TonContractException(
          "Amount must be grather than total ton amount");
    }
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: mintBodyMessage(
            from: address,
            to: to,
            jettonAmount: jettonAmout,
            forwardTonAmount: forwardTonAmount,
            totalTonAmount: totalTonAmount,
            queryId: queryId),
        bounce: bounce,
        bounced: bounced,
        messages: messages,
        timeout: timeout);
  }

  Future<String> discover(
      {required TonPrivateKey privateKey,
      required TonApiProvider rpc,
      required BigInt amount,
      required TonAddress owner,
      required bool includeAddress,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool bounce = false,
      bool bounced = false,
      Cell? body}) async {
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body:
            discoveryMessageBody(owner: owner, includeAddress: includeAddress),
        bounce: bounce,
        bounced: bounced,
        messages: messages,
        timeout: timeout);
  }

  Future<String> changeAdmin(
      {required TonPrivateKey privateKey,
      required TonApiProvider rpc,
      required BigInt amount,
      required TonAddress newOwner,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool bounce = false,
      bool bounced = false,
      Cell? body}) async {
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: changeAdminMessageBody(newOwner),
        bounce: bounce,
        bounced: bounced,
        messages: messages,
        timeout: timeout);
  }

  Cell internalTransfer(
      {required TonAddress from,
      required BigInt jettonAmount,
      required BigInt forwardTonAmount,
      required BigInt totalTonAmount,
      int queryId = 0}) {
    return beginCell()
        .storeUint(JettonMinterConst.internalTransferOperation, 32)
        .storeUint(queryId, 64)
        .storeCoins(jettonAmount)
        .storeAddress(null)
        .storeAddress(from)
        .storeCoins(forwardTonAmount)
        .storeBitBolean(false)
        .endCell();
  }

  Cell mintBodyMessage(
      {required TonAddress from,
      required TonAddress to,
      required BigInt jettonAmount,
      required BigInt forwardTonAmount,
      required BigInt totalTonAmount,
      int queryId = 0}) {
    final mintMsg = beginCell()
        .storeUint(JettonMinterConst.internalTransferOperation, 32)
        .storeUint(0, 64)
        .storeCoins(jettonAmount)
        .storeAddress(null)
        .storeAddress(from)
        .storeCoins(forwardTonAmount)
        .storeMaybeRef(cell: null)
        .endCell();
    return beginCell()
        .storeUint(21, 32)
        .storeUint(queryId, 64)
        .storeAddress(to)
        .storeCoins(totalTonAmount)
        .storeCoins(jettonAmount)
        .storeRef(mintMsg)
        .endCell();
  }

  Cell discoveryMessageBody(
      {required TonAddress owner, required bool includeAddress}) {
    return beginCell()
        .storeUint(JettonMinterConst.discoverMessageOperation, 32)
        .storeUint(0, 64)
        .storeAddress(owner)
        .storeBitBolean(includeAddress)
        .endCell();
  }

  Cell changeAdminMessageBody(TonAddress newOwner) {
    return beginCell()
        .storeUint(JettonMinterConst.changeAddminOperation, 32)
        .storeUint(0, 64)
        .storeAddress(newOwner)
        .endCell();
  }

  Future<JettonDataResponse> getJettonData(TonApiProvider rpc) async {
    final data = await getMethod(rpc: rpc, method: "get_jetton_data");
    final reader = data.reader;
    final item = reader.pop();
    final BigInt totalSupply;
    if (item.type == TupleItemTypes.intItem) {
      totalSupply = (item as TupleItemInt).value;
    } else {
      totalSupply = reader.readBigNumber();
    }
    final bool mintable = reader.readBoolean();
    final TonAddress admin = reader.readAddress();
    final Cell content = reader.readCell();
    final Cell walletCode = reader.readCell();
    return JettonDataResponse(
        totalSupply: totalSupply,
        mintable: mintable,
        admin: admin,
        content: content,
        walletCode: walletCode);
  }

  Future<TonAddress> getWalletAddress(
      {required TonApiProvider rpc, required TonAddress owner}) async {
    final data =
        await getMethod(rpc: rpc, method: "get_wallet_address", stack: [
      ["tvm.Slice", beginCell().storeAddress(owner).endCell().toBase64()]
    ]);
    return data.reader.readAddress();
  }

  Future<BigInt> totalSupply(TonApiProvider rpc) async {
    final data = await getJettonData(rpc);
    return data.totalSupply;
  }

  Future<TonAddress> adminAddress(TonApiProvider rpc) async {
    final data = await getJettonData(rpc);
    return data.admin;
  }

  Future<Cell> getContent(TonApiProvider rpc) async {
    final data = await getJettonData(rpc);
    return data.content;
  }

  @override
  int? get subWalletId => null;
}
