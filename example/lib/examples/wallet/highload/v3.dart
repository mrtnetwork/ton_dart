import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWalletHighLoadWallet wallet = TestWalletHighLoadWallet(index: 12);
  final TestWallet<WalletV5R1> destination =
      TestWallet(version: WalletVersion.v5R1, index: 10);
  final query = HighloadQueryId.fromQueryId(BigInt.one);
  final nextQueryId = query.getQueryId();
  await wallet.wallet.sendTransfer(
      params: HighloadTransferParams(
          queryId: nextQueryId,
          signer: wallet.signer,
          messages: [
            OutActionSendMsg(
                outMessage: TransactioUtils.internal(
                    destination: destination.address,
                    amount: TonHelper.toNano("0.1"))),
          ]),
      rpc: wallet.rpc);
  await wallet.wallet.getBalance(wallet.rpc);
  final publicKey = await wallet.wallet.getPublicKey(wallet.rpc);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.rpc);
  assert(BytesUtils.bytesEqual(
      state.publicKey, wallet.signer.toPublicKey().toBytes()));
  assert(state.subWalletId == wallet.wallet.state!.subWalletId);
  await HighloadWalletV3.fromAddress(address: wallet.address, rpc: wallet.rpc);
}
