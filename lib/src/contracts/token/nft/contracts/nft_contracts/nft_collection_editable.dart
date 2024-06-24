import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/contracts/token/nft/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/nft/models/models.dart';
import 'package:ton_dart/src/contracts/token/nft/utils/utils.dart';
import 'package:ton_dart/src/contracts/utils/transaction_utils.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'nft_collection.dart';

class NFTCollectionEditableContract extends NFTCollectionContract {
  const NFTCollectionEditableContract(
      {required VersonedWalletContract ownerWallet,
      required TonAddress address,
      StateInit? state})
      : super(ownerWallet: ownerWallet, address: address, state: state);

  factory NFTCollectionEditableContract.create(
      {required VersonedWalletContract ownerWallet,
      required RoyaltyParams royaltyParams,
      required NFTMetadata content,
      BigInt? nextItemIndex}) {
    final state = NftWalletUtils.buildNftCollectionState(
        ownerAddress: ownerWallet.address,
        royaltyParams: royaltyParams,
        content: content,
        code: TomNftConst.nftEditableCollectionCode(ownerWallet.workChain),
        nextItemIndex: nextItemIndex);
    return NFTCollectionEditableContract(
        ownerWallet: ownerWallet,
        address: TonAddress.fromState(
            state: state, workChain: ownerWallet.workChain),
        state: state);
  }

  @override
  Cell code(int workchain) {
    return TomNftConst.nftEditableCollectionCode(workchain);
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

  Future<String> changeContent(
      {required TonPrivateKey privateKey,
      required TonProvider rpc,
      required BigInt amount,
      required UpdateEditableNFTContent newContent,
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
            .storeUint32(TomNftConst.changeContent)
            .storeUint64(queryId ?? BigInt.zero)
            .store(newContent)
            .endCell(),
        bounced: bounced,
        messages: messages,
        timeout: timeout);
  }
}
