import 'package:example/examples/http.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final rpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com"));
  final privateKey = TonPrivateKey.fromBytes(List<int>.filled(32, 56));
  final ownerWallet = WalletV4.create(
      workChain: -1, publicKey: privateKey.toPublicKey().toBytes());

  final minter = JettonMinter.create(
      owner: ownerWallet,
      metadata: const JettonOffChainMetadata(
          "https://ipfs.io/ipfs/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN?filename=ipf.json"));
  final hash = await minter.deploy(
      ownerPrivateKey: privateKey, rpc: rpc, amount: TonHelper.toNano("0.5"));
  print("hash $hash");

  /// https://testnet.tonscan.org/jetton/Ef86P5RpRpBOfm76uCPqU78Y4TdmFAiqJVnx1lozUx0w1gHZ
}
