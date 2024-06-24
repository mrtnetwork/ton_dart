import 'package:example/examples/http.dart';
import 'package:example/examples/transfer.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final testnetRpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC",
      api: TonApiType.tonCenter));
  final gnWallet = getTestWallet(index: 312);
  final newOwner = getTestWallet(index: 319).item1.address;
  final wallet = gnWallet.item1;
  final privateKey = gnWallet.item2;
  final nftCollection = NFTCollectionContract(
      address: TonAddress("Ef9eHhGCu4PS8M7MIoTcIbFFlja5j5u__jwW3BHLUEqlk2Wx"),
      ownerWallet: wallet);
  final nftAddress = await nftCollection.getNftAddressByIndex(
      index: BigInt.zero, rpc: testnetRpc);
  final nftAddr = NFTItemContract(address: nftAddress, ownerWallet: wallet);

  await nftAddr.transfer(
      ownerPrivateKey: privateKey,
      rpc: testnetRpc,
      amount: TonHelper.toNano("0.3"),
      bounce: false,
      params: TransferNFTParams(
          newOwnerAddress: newOwner, forwardAmount: TonHelper.toNano("0.1")));
}
