import 'package:example/examples/http.dart';
import 'package:example/examples/transfer.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final testnetRpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC",
      api: TonApiType.tonCenter));
  final gnWallet = getTestWallet(index: 1001);
  final royaltyAddress = getTestWallet(index: 314).item1.address;

  final wallet = gnWallet.item1;
  final privateKey = gnWallet.item2;

  final nftCollection = NFTCollectionEditableContract(
      ownerWallet: wallet,
      address: TonAddress("Ef9J9PRMOwvli37T5CKBrL5wTk2AV-6A_YVL34wRaIHx2QYE"));

  await nftCollection.changeContent(
      privateKey: privateKey,
      rpc: testnetRpc,
      amount: TonHelper.toNano("0.1"),
      newContent: UpdateEditableNFTContent(
          content: const NFTCollectionMetadata(

              /// collection metadata
              collectionMetadataUri:
                  "https://ipfs.io/ipfs/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN?filename=ipf.json",

              /// collection base. use your nfts collection folders or set null for empty string
              /// when you want to mint nfts if its not empty you must juast add your nft file name
              /// you can see the example in mint example file
              collectionBase:
                  "https://ipfs.io/ipfs/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN"),
          royaltyParams: RoyaltyParams(

              /// change to 10%
              royaltyFactor: (0.1 * 1000).ceil(),
              royaltyBase: 1000,
              address: royaltyAddress)));

  /// https://testnet.explorer.tonnft.tools/collection/Ef9J9PRMOwvli37T5CKBrL5wTk2AV-6A_YVL34wRaIHx2QYE
  /// https://testnet.tonscan.org/tx/by-msg-hash/ts9kWXmNIadDOkTTrBdSxvE70BOu6FxZvNBsYETMgas=
}
