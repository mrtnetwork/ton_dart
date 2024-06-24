import 'package:example/examples/http.dart';
import 'package:example/examples/transfer.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final testnetRpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC",
      api: TonApiType.tonCenter));

  final gnWallet = getTestWallet(index: 312);

  final wallet = gnWallet.item1;
  final privateKey = gnWallet.item2;

  final nftAddr = NFTItemContract.create(
      ownerWallet: wallet,
      params: NFTItemParams(
          index: BigInt.zero,
          ownerAddress: wallet.address,
          content: const NFTItemMetadata(
              "https://ipfs.io/ipfs/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN?filename=ipf.json")));

  await nftAddr.deploy(
      ownerPrivateKey: privateKey,
      rpc: testnetRpc,
      amount: TonHelper.toNano("0.5"));

  /// https://testnet.explorer.tonnft.tools/nft/Ef8e-ohQoQjyil_Zkf_NgwpoxtazjH8mqadZV5V3uRB0bg4u
  /// https://testnet.tonscan.org/tx/by-msg-hash/573JC0C/q3R0DVjFwjEqJiwQ7t03CKDsvf7d2sdTVM0=
}
