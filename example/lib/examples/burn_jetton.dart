import 'package:ton_dart/ton_dart.dart';
import 'http.dart';
import 'transfer.dart';

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

  final jettonWalletAddress =
      await minter.getWalletAddress(rpc: rpc, owner: wallet.address);
  final jettonWallet = JettonWallet.fromAddress(
      jettonWalletAddress: jettonWalletAddress, owner: wallet);
  final burnAmount = BigInt.from(1000000000000);
  final BigInt amount = TonHelper.toNano("0.2");
  await jettonWallet.burn(
      privateKey: privateKey,
      rpc: rpc,
      amount: amount,
      burnJettonAmount: burnAmount);

  /// https://testnet.tonscan.org/tx/by-msg-hash/LGoiWetC0IH_cCCft6QtnaqmputeqvprNyL9pkL6v2I=
}
