import 'package:example/examples/http.dart';
import 'package:example/examples/transfer.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final testnetRpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC"));
  final gnWallet = getTestWallet(index: 312);
  final royaltyAddress = getTestWallet(index: 314).item1.address;
  final wallet = gnWallet.item1;
  final privateKey = gnWallet.item2;

  final royaltyParams = RoyaltyParams(

      /// 1%
      royaltyFactor: (0.01 * 1000).ceil(),
      royaltyBase: 1000,
      address: royaltyAddress);

  final nftCollection = NFTCollectionContract.create(
      ownerWallet: wallet,
      royaltyParams: royaltyParams,
      nextItemIndex: BigInt.from(100),
      content: const NFTCollectionMetadata(

          /// collection metadata
          collectionMetadataUri:
              "https://ipfs.io/ipfs/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN?filename=ipf.json",

          /// collection base. use your nfts collection folders or set null for empty string
          /// when you want to mint nfts if its not empty you must juast add your nft file name
          /// you can see the example in mint example file
          collectionBase:
              "https://ipfs.io/ipfs/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN"));

  await nftCollection.deploy(
    ownerPrivateKey: privateKey,
    rpc: testnetRpc,
    amount: TonHelper.toNano("0.1"),
  );

  /// https://testnet.explorer.tonnft.tools/collection/Ef9eHhGCu4PS8M7MIoTcIbFFlja5j5u__jwW3BHLUEqlk2Wx
  /// https://testnet.tonscan.org/tx/by-msg-hash/KWMjah7g4afXIikoyujO/qK8/vYfWT5cpr1+fpLjm48=
}
