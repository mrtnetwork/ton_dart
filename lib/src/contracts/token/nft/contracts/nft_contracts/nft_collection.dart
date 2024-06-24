import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/contract.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/contracts/token/nft/models/models.dart';
import 'package:ton_dart/src/contracts/token/nft/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/nft/utils/utils.dart';
import 'package:ton_dart/src/contracts/utils/transaction_utils.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/provider/provider/provider.dart';

class NFTCollectionContract extends TonContract<NftCollectionParams> {
  final VersonedWalletContract ownerWallet;
  @override
  final TonAddress address;
  @override
  final StateInit? state;
  @override
  final int? subWalletId = null;

  const NFTCollectionContract(
      {required this.ownerWallet, required this.address, this.state});

  factory NFTCollectionContract.create(
      {required VersonedWalletContract ownerWallet,
      required RoyaltyParams royaltyParams,
      required NFTMetadata content,
      BigInt? nextItemIndex}) {
    final state = NftWalletUtils.buildNftCollectionState(
        ownerAddress: ownerWallet.address,
        royaltyParams: royaltyParams,
        content: content,
        code: TomNftConst.nftCollectionCode(ownerWallet.workChain),
        nextItemIndex: nextItemIndex);
    return NFTCollectionContract(
        ownerWallet: ownerWallet,
        address: TonAddress.fromState(
            state: state, workChain: ownerWallet.workChain),
        state: state);
  }

  @override
  Cell code(int workchain) {
    return TomNftConst.nftCollectionCode(workchain);
  }

  @override
  Cell data(NftCollectionParams params, int workchain) {
    return params.serialize(workchain: workchain);
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

  Future<String> mintNft(
      {required TonPrivateKey privateKey,
      required TonProvider rpc,
      required BigInt amount,
      required NFTMintParams params,
      BigInt? queryId,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    if (params.initAmount > amount) {
      throw TonContractException(
          "Amount must be greather than nft init amount");
    }
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: beginCell()
            .storeUint32(TomNftConst.mintNFtOperationId)
            .storeUint64(queryId ?? BigInt.zero)
            .store(params)
            .endCell(),
        bounced: bounced,
        messages: messages,
        timeout: timeout);
  }

  Future<String> batchMintNfts(
      {required TonPrivateKey privateKey,
      required TonProvider rpc,
      required BigInt amount,
      required BatchNFTsMintParams params,
      BigInt? queryId,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    if (params.initializeAmount > amount) {
      throw TonContractException(
          "Amount must be greather than sum of nfts init amount");
    }
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: beginCell()
            .storeUint32(TomNftConst.batchMintNFtOperationId)
            .storeUint64(queryId ?? BigInt.zero)
            .store(params)
            .endCell(),
        bounced: bounced,
        messages: messages,
        timeout: timeout);
  }

  Future<String> changeOwner(
      {required TonPrivateKey privateKey,
      required TonProvider rpc,
      required BigInt amount,
      required TonAddress newOwner,
      BigInt? queryId,
      List<MessageRelaxed> messages = const [],
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    return _sendTransaction(
        privateKey: privateKey,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: beginCell()
            .storeUint32(TomNftConst.changeCollectionOwnerOperationId)
            .storeUint64(queryId ?? BigInt.zero)
            .storeAddress(newOwner)
            .endCell(),
        bounced: bounced,
        messages: messages,
        timeout: timeout);
  }

  Future<NFTCollectionData> getCollectionData(TonProvider rpc) async {
    final data = await getStateStack(rpc: rpc, method: "get_collection_data");
    final reader = data.reader();
    final nexItemIndex = reader.readBigNumber();
    final content = reader.readCell();
    final ownerAddress = reader.readAddress();

    NFTMetadata metadata = NFTRawMetadata(content);
    try {
      final contentSlice = content.beginParse();
      if (contentSlice.loadUint8() ==
          TonMetadataConstant.ftMetadataOffChainTag) {
        metadata = NFTCollectionMetadata(
            collectionMetadataUri: contentSlice.loadStringTail());
      } else {
        metadata = NFTRawMetadata(content);
      }
      // ignore: empty_catches
    } catch (e) {
      metadata = NFTRawMetadata(content);
    }

    return NFTCollectionData(
        nexItemIndex: nexItemIndex,
        content: metadata,
        ownerAddress: ownerAddress);
  }

  Future<TonAddress> getNftAddressByIndex(
      {required BigInt index, required TonProvider rpc}) async {
    final result = await getStateStack(
        rpc: rpc,
        method: "get_nft_address_by_index",
        stack: [
          if (rpc.isTonCenter) ["num", index.toString()] else index.toString()
        ]);
    final reader = result.reader();
    return reader.readAddress();
  }

  Future<RoyaltyParams> royaltyParams(TonProvider rpc) async {
    final data = await getStateStack(rpc: rpc, method: "royalty_params");
    final reader = data.reader();
    final int royaltyFactor = reader.readNumber();
    final int royaltyBase = reader.readNumber();
    final TonAddress address = reader.readAddress();
    return RoyaltyParams(
        royaltyFactor: royaltyFactor,
        royaltyBase: royaltyBase,
        address: address);
  }

  Future<String> getNftContent({
    required TonProvider rpc,
    required NFTItemData nftData,
  }) async {
    if (!nftData.init) {
      throw TonContractException("The NFT has not been initialized.");
    }
    final data =
        await getStateStack(rpc: rpc, method: "get_nft_content", stack: [
      if (rpc.isTonCenter) ...[
        ["num", nftData.index.toString()],
        ["tvm.Cell", nftData.content!.toBase64()]
      ] else ...[
        nftData.index,
        nftData.content?.toBase64(),
      ]
    ]);
    final reader = data.reader();
    final slice = reader.readCell().beginParse();
    slice.loadUint8();
    return slice.loadStringTail();
  }
}
