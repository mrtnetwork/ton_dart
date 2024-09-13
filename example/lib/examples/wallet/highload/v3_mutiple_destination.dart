import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWalletHighLoadWallet wallet = TestWalletHighLoadWallet(index: 12);
  final destination = TestWallet(version: WalletVersion.v1R1);
  final destination2 = TestWallet(version: WalletVersion.v1R2);
  final destination3 = TestWallet(version: WalletVersion.v1R3);
  final destination4 = TestWallet(version: WalletVersion.v2R1);
  final destination5 = TestWallet(version: WalletVersion.v2R2);
  final destination6 = TestWallet(version: WalletVersion.v3R1);
  final destination7 = TestWallet(version: WalletVersion.v3R2);
  final destination8 = TestWallet(version: WalletVersion.v4);
  final destination9 = TestWallet(version: WalletVersion.v5R1, index: 1);
  final query = HighloadQueryId.fromQueryId(BigInt.one);
  final nextQueryId = query.getNext().getQueryId();
  await wallet.wallet.sendTransfer(
      params: HighloadTransferParams(
          queryId: nextQueryId,
          signer: wallet.signer,
          messages: [
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination.address,
                    amount: TonHelper.toNano("0.01"))),
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination2.address,
                    amount: TonHelper.toNano("0.01"))),
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination3.address,
                    amount: TonHelper.toNano("0.01"))),
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination4.address,
                    amount: TonHelper.toNano("0.01"))),
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination5.address,
                    amount: TonHelper.toNano("0.01"))),
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination6.address,
                    amount: TonHelper.toNano("0.01"))),
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination7.address,
                    amount: TonHelper.toNano("0.01"))),
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination8.address,
                    amount: TonHelper.toNano("0.01"))),
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination9.address,
                    amount: TonHelper.toNano("0.01"))),
          ]),
      rpc: wallet.rpc);
}
