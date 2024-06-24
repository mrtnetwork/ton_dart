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

  await nftCollection.mintNft(
      privateKey: privateKey,
      rpc: testnetRpc,
      amount: TonHelper.toNano("0.5"),
      params: NFTMintParams(
          ownerAddress: wallet.address,
          //// you should select the each file in your base collection or set full path if you dont set collection base in your nft collection
          metadata: const NFTItemMetadata("?filename=ipf.json"),
          initAmount: TonHelper.toNano("0.1"),
          itemIndex: BigInt.from(0)));

  /// https://testnet.explorer.tonnft.tools/nft/Ef-A8nDJudBo-3qx-BbHkFBZho9hJ52dRITuhzckB68dojzB
  /// https://testnet.tonscan.org/tx/by-msg-hash/qHJ2eWleDjmKj576cV7DeHLIvmZFitFI/l7i34r8f9E=
}
