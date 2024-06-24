import 'package:ton_dart/ton_dart.dart';
import 'http.dart';
import 'transfer.dart';

void main() async {
  final rpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC"));
  final privateKey = TonPrivateKey.fromBytes(List<int>.filled(32, 56));
  final ownerWallet = WalletV4.create(
      workChain: -1, publicKey: privateKey.toPublicKey().toBytes());

  final TonAddress destination = getTestWallet(index: 12).item1.address;

  final minter = JettonMinter.create(
      owner: ownerWallet,
      metadata: const JettonOffChainMetadata("https://github.com/mrtnetwork"));

  final amount = TonHelper.toNano("0.5");
  final forwardAmount = TonHelper.toNano("0.3");
  final totalAmount = TonHelper.toNano("0.4");
  final jettonAmountForMint = BigInt.parse("1${"0" * 15}");
  await minter.mint(
      privateKey: privateKey,
      rpc: rpc,
      jettonAmout: jettonAmountForMint,
      forwardTonAmount: forwardAmount,
      totalTonAmount: totalAmount,
      amount: totalAmount + amount,
      to: destination);

  /// https://testnet.tonscan.org/tx/by-msg-hash/HUWTXbjj/dGymCB3a1reOGHFzDvtFp/XygUE6fH9YHWgUiHuJf6Q=
}
