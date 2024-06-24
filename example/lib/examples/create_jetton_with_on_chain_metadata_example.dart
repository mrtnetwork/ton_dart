import 'package:example/examples/http.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final rpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC"));
  final privateKey = TonPrivateKey.fromBytes(List<int>.filled(32, 132));
  final ownerWallet = WalletV4.create(
      workChain: -1, publicKey: privateKey.toPublicKey().toBytes());
  final balance = await ownerWallet.getBalance(rpc);
  if (balance == BigInt.zero) {
    return;
  }
  final minter = JettonMinter.create(
    owner: ownerWallet,
    metadata: JettonOnChainMetadata.snakeFormat(
      name: "MRT NETWORK",
      image: "https://avatars.githubusercontent.com/u/56779182?s=96&v=4",
      symbol: "MRT",
      decimals: 9,
      description: "https://github.com/mrtnetwork/ton_dart",
    ),
  );
  await minter.deploy(
      ownerPrivateKey: privateKey, rpc: rpc, amount: TonHelper.toNano("0.5"));

  /// https://testnet.tonscan.org/jetton/Ef_S5e9R5RZbWgf7Ob5kfU9JadIYDd-Eb17rYkjG691DmHTl
  /// https://testnet.tonscan.org/tx/fN3-ih_54AKBu_G4SNZEkz5n_JREanECRT9KEQ5SiBs=
}
