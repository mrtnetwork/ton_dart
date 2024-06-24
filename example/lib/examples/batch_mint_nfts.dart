import 'package:example/examples/http.dart';
import 'package:example/examples/transfer.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final testnetRpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC"));
  final gnWallet = getTestWallet(index: 312);
  final wallet = gnWallet.item1;
  final privateKey = gnWallet.item2;

  final nftCollection = NFTCollectionContract(
      address: TonAddress("Ef9eHhGCu4PS8M7MIoTcIbFFlja5j5u__jwW3BHLUEqlk2Wx"),
      ownerWallet: wallet);

  await nftCollection.batchMintNfts(
      privateKey: privateKey,
      rpc: testnetRpc,
      amount: TonHelper.toNano("1"),
      params: BatchNFTsMintParams(List.generate(
        5,
        (index) => NFTMintParams(
            ownerAddress: wallet.address,
            //// you should select the each file in your base collection or set full path if you dont set collection base in your nft collection
            metadata: const NFTItemMetadata("?filename=ipf.json"),
            initAmount: TonHelper.toNano("0.1"),
            itemIndex: BigInt.from(10) + BigInt.from(index)),
      )));

  /// https://testnet.explorer.tonnft.tools/collection/Ef9eHhGCu4PS8M7MIoTcIbFFlja5j5u__jwW3BHLUEqlk2Wx
  /// https://testnet.tonscan.org/tx/by-msg-hash/hKcVkiPxKFFnURHhWKCJn9bbRjGYH/K0f8Op2715B2k=
}
