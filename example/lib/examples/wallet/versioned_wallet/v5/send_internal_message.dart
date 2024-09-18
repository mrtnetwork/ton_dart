import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final wallet = TestWallet<WalletV5R1>(version: WalletVersion.v5R1);
  final state = await wallet.wallet.readState(wallet.rpc);
  await wallet.wallet.sendTransfer(
      params: VersionedV5TransferParams.external(signer: wallet.signer),
      messages: [
        TonHelper.internal(
            destination: wallet.address,
            amount: TonHelper.toNano("0.1"),
            body: await wallet.wallet.createAndSignInternalMessage(
                signer: wallet.signer,
                rpc: wallet.rpc,
                accountSeqno: state.seqno + 1,
                v5Messages: [
                  OutActionSendMsg(
                      outMessage: TonHelper.internal(
                          destination: TonAddress(
                              "Uf_BIyysClKPLd5MHuyWqIEVNQxQZTJQmHp4bybS_YuOIJBT"),
                          amount: TonHelper.toNano("0.12123")))
                ]))
      ],
      rpc: wallet.rpc);
}
