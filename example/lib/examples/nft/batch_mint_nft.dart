import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final wallet = TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 96);
  final royalityParamsWallet =
      TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 97);
  final RoyaltyParams royaltyParams = RoyaltyParams(

      /// 10% (1000~/100)%
      royaltyFactor: 100,
      royaltyBase: 1000,
      address: royalityParamsWallet.address);
  final state = NftEditableCollectionState(
      royaltyParams: royaltyParams,
      ownerAddress: wallet.address,
      metadata: const NFTCollectionMetadata(

          /// collection metadata
          collectionMetadataUri:
              "https://ipfs.io/ipfs/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN?filename=ipf.json",

          /// collection base. use your nfts collection folders or set null for empty string
          /// when you want to mint nfts if its not empty you must juast add your nft file name
          /// you can see the example in mint example file
          collectionBase:
              "https://ipfs.io/ipfs/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN"));
  final nftCollection =
      NFTCollectionContract.create(owner: wallet.wallet, state: state);

  await nftCollection.sendOperation(
    params: VersionedV5TransferParams.external(signer: wallet.signer),
    rpc: wallet.rpc,
    amount: TonHelper.toNano("1"),
    operation: NFTCollectionBatchMint(
        nfts: List.generate(3, (index) {
      final itemIndex = BigInt.two + BigInt.from(index);
      return NFTMintParams(
          ownerAddress: wallet.address.copyWith(bounceable: false),
          content: NFTItemMetadata("/?filename=nft$itemIndex.json")
              .toContent(collectionless: false),
          initAmount: TonHelper.toNano("0.2"),
          itemIndex: itemIndex);
    })),
  );
  await Future.delayed(const Duration(seconds: 10));
  for (int i = 0; i < 3; i++) {
    final itemIndex = BigInt.two + BigInt.from(i);
    final collectionData = await nftCollection.getNFTItemContractByIndex(
        rpc: wallet.rpc, index: itemIndex, owner: wallet.wallet);
    assert(collectionData.state?.ownerAddress == wallet.address);
    assert(
        collectionData.state?.metadata.uri == "/?filename=nft$itemIndex.json");
    assert(collectionData.state?.index == itemIndex);
  }
}
