import 'package:example/examples/http.dart';
import 'package:example/examples/transfer.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final testnetRpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC",
      api: TonApiType.tonCenter));

  final gnWallet = getTestWallet(index: 1001);
  final newOwner = getTestWallet(index: 417).item1.address;
  final wallet = gnWallet.item1;
  final privateKey = gnWallet.item2;
  final nftCollection = NFTCollectionEditableContract(
      address: TonAddress("Ef9J9PRMOwvli37T5CKBrL5wTk2AV-6A_YVL34wRaIHx2QYE"),
      ownerWallet: wallet);

  await nftCollection.changeOwner(
      privateKey: privateKey,
      rpc: testnetRpc,
      amount: TonHelper.toNano("0.1"),
      newOwner: newOwner,
      bounce: false);
}
