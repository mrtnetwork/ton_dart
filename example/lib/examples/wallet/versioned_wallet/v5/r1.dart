import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV5R1> wallet = TestWallet(version: WalletVersion.v5R1);

  final destination = TestWallet(version: WalletVersion.v1R1);
  final destination2 = TestWallet(version: WalletVersion.v1R2);
  final destination3 = TestWallet(version: WalletVersion.v1R3);
  final destination4 = TestWallet(version: WalletVersion.v2R1);
  final destination5 = TestWallet(version: WalletVersion.v2R2);
  final destination6 = TestWallet(version: WalletVersion.v3R1);
  final destination7 = TestWallet(version: WalletVersion.v3R2);
  final destination8 = TestWallet(version: WalletVersion.v4);
  final destination9 = TestWallet(version: WalletVersion.v5R1, index: 1);

  await wallet.wallet.sendTransfer(
      params:
          VersionedV5TransferParams.external(signer: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination.address,
                amount: TonHelper.toNanoGrams("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination2.address,
                amount: TonHelper.toNanoGrams("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination3.address,
                amount: TonHelper.toNanoGrams("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination4.address,
                amount: TonHelper.toNanoGrams("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination5.address,
                amount: TonHelper.toNanoGrams("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination6.address,
                amount: TonHelper.toNanoGrams("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination7.address,
                amount: TonHelper.toNanoGrams("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination8.address,
                amount: TonHelper.toNanoGrams("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination9.address,
                amount: TonHelper.toNanoGrams("0.01"))),
      ]),
      client: wallet.client);
  await wallet.wallet.getBalance(wallet.client);
  final publicKey = await wallet.wallet.getPublicKey(wallet.client);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.client);
  assert(BytesUtils.bytesEqual(
      state.publicKey.toBytes(), wallet.signer.toPublicKey().toBytes()));
  assert(state.context == wallet.wallet.state!.context);
  await WalletV5R1.fromAddress(address: wallet.address, client: wallet.client);
}
