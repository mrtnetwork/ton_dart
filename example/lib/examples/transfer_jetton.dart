import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/ton_dart.dart';
import 'http.dart';

Tuple<WalletV4, TonPrivateKey> getTestWallet({int index = 0}) {
  final privateKey = Bip32Slip10Ed25519.fromSeed(List<int>.filled(32, 56))
      .childKey(Bip32KeyIndex.hardenIndex(index));
  final pr = TonPrivateKey.fromBytes(privateKey.privateKey.raw);
  final WalletV4 w =
      WalletV4(workChain: -1, publicKey: pr.toPublicKey().toBytes());
  return Tuple(w, pr);
}

void main() async {
  final rpc = TonProvider(HTTPProvider(
      tonApiUrl: "https://testnet.tonapi.io",
      tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC"));

  final walletDetails = getTestWallet(index: 12);

  final privateKey = walletDetails.item2;
  final WalletV4 wallet = walletDetails.item1;

  /// owner its not important in this case. we just want to get jetton wallet address
  final minter = JettonMinter(
      owner: wallet,
      address: TonAddress("Ef9PKHV5y7ynx7ITXZqowOkQeY4WynREXDoIn6XomBfIePqS"));

  final transferAddress = getTestWallet(index: 13).item1.address;

  final jettonWalletAddress =
      await minter.getWalletAddress(rpc: rpc, owner: wallet.address);
  final jettonWallet = JettonWallet.fromAddress(
      jettonWalletAddress: jettonWalletAddress, owner: wallet);

  final forwardTonAmount = TonHelper.toNano("0.1");
  final transferAmount = BigInt.from(1000000000);
  final BigInt amount = TonHelper.toNano("0.3");

  await jettonWallet.transfer(
      privateKey: privateKey,
      rpc: rpc,
      destination: transferAddress,
      forwardTonAmount: forwardTonAmount,
      jettonAmount: transferAmount,
      amount: amount + forwardTonAmount);

  /// https://testnet.tonscan.org/jetton/Ef8gF-KVanZWtQEFVyARJURROJKOCoBX6FRdso6DW9Nw3uu0
}
