import 'package:ton_dart/ton_dart.dart';
import 'http.dart';

void main() async {
  final rpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC"));
  final privateKey = TonPrivateKey.fromBytes(List<int>.filled(32, 56));
  final ownerWallet = WalletV4.create(
      workChain: -1, publicKey: privateKey.toPublicKey().toBytes());

  final minter = JettonMinter.create(
      owner: ownerWallet,
      metadata: const JettonOffChainMetadata("https://github.com/mrtnetwork"));
  await minter.deploy(
      ownerPrivateKey: privateKey, rpc: rpc, amount: TonHelper.toNano("0.5"));

  /// https://testnet.tonscan.org/tx/by-msg-hash/nVALmJB2NmwVOXZu1v2S3e9GtRKjATMEAtjCaIf3go4=
}
