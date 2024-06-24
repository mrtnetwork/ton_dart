import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/contracts/core/contract.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/nft/constant/constant.dart';
import 'package:ton_dart/src/crypto/crypto.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider/provider.dart';

/// https://github.com/ton-blockchain/TEPs/blob/master/text/0062-nft-standard.md
class NFTItemContract extends TonContract<NFTItemParams> {
  final VersonedWalletContract ownerWallet;
  @override
  final TonAddress address;
  @override
  final StateInit? state;

  @override
  final int? subWalletId = null;
  factory NFTItemContract.create({
    required VersonedWalletContract ownerWallet,
    required NFTItemParams params,
  }) {
//     cell calculate_nft_item_state_init(int item_index, cell nft_item_code) {
//   cell data = begin_cell().store_uint(item_index, 64).store_slice(my_address()).end_cell();
//   return begin_cell().store_uint(0, 2).store_dict(nft_item_code).store_dict(data).store_uint(0, 1).end_cell();
// }
    final state = StateInit(
        code: TomNftConst.nftItemCode(ownerWallet.workChain),
        data: params.serialize());
    return NFTItemContract(
        address: TonAddress.fromState(
            state: state, workChain: ownerWallet.workChain),
        ownerWallet: ownerWallet,
        state: state);
  }

  const NFTItemContract(
      {required this.address, required this.ownerWallet, this.state});

  @override
  Cell code(int workchain) {
    return TomNftConst.nftItemCode(workchain);
  }

  @override
  Cell data(NFTItemParams params, int workchain) {
    return params.serialize();
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
      StateInit? state}) async {
    final message = TransactioUtils.internal(
      destination: address,
      amount: amount,
      initState: state,
      bounced: bounced,
      body: body,
      bounce: bounce ?? address.isBounceable,
    );
    return await ownerWallet.sendTransfer(
        messages: [message, ...messages],
        privateKey: privateKey,
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode);
  }

  /// https://github.com/ton-blockchain/TEPs/blob/master/text/0062-nft-standard.md#1-transfer
  Future<String> transfer(
      {required TonPrivateKey ownerPrivateKey,
      required TonProvider rpc,
      required BigInt amount,
      required TransferNFTParams params,
      BigInt? queryId,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    return _sendTransaction(
        privateKey: ownerPrivateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: beginCell()
            .storeUint32(TomNftConst.nftTransferOperationId)
            .storeUint64(queryId ?? BigInt.zero)
            .store(params)
            .endCell(),
        bounce: bounce,
        bounced: bounced,
        state: state,
        messages: messages,
        timeout: timeout);
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

  /// https://github.com/ton-blockchain/TEPs/blob/master/text/0062-nft-standard.md#2-get_static_data
  Future<String> getStaticData(
      {required TonPrivateKey ownerPrivateKey,
      required TonProvider rpc,
      required BigInt amount,

      /// arbitrary request number.
      required BigInt queryId,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
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
        body: beginCell()
            .storeUint32(TomNftConst.getStaticDataOperationId)
            .storeUint64(queryId)
            .endCell(),
        bounce: bounce,
        bounced: bounced,
        state: state,
        messages: messages,
        timeout: timeout);
  }

  Future<NFTItemData> getNftData(TonProvider rpc) async {
    final result = await getStateStack(rpc: rpc, method: "get_nft_data");
    final reader = result.reader();
    final bool init = reader.readNumber() != 0;
    final index = reader.readBigNumber();
    if (!init) {
      return NFTItemData(init: init, index: index);
    }
    final collectionAddress = reader.readAddressOpt();
    final ownerAddress = reader.readAddressOpt();
    final content = reader.readCell();

    return NFTItemData(
        init: init,
        collectionAddress: collectionAddress,
        content: content,
        ownerAddress: ownerAddress,
        index: index);
  }
}
