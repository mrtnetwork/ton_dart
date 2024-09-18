import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final wallet = TestWalletMultiOwner(
      startIndex: 0, proposIndex: 144, threshHold: 2, name: "Multisig owner");
  final destination1 =
      TestWallet(version: WalletVersion.v4, name: "destination 1");
  final destination2 =
      TestWallet(version: WalletVersion.v5R1, index: 3, name: "destination 2");
  final int expire = (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 3600;
  final proposer = wallet.wallet.changeOwnerWallet(wallet.proposer);

  /// create new order for transfer Ton from multi owner account
  await proposer.sendTransfer(
      params: MultiOwnerTransferParams(
          params: VersionedTransferParams(privateKey: wallet.proposerKey),
          expirationDate: BigInt.from(expire),
          amount: TonHelper.toNano("0.5"),
          messages: [
            OutActionMultiSigSendMsg(
                outMessage: TonHelper.internal(
                    destination:
                        destination1.address.copyWith(bounceable: false),
                    amount: TonHelper.toNano("0.01"))),
            OutActionMultiSigSendMsg(
                outMessage: TonHelper.internal(
                    destination:
                        destination2.address.copyWith(bounceable: false),
                    amount: TonHelper.toNano("0.01"))),
          ]),
      rpc: wallet.rpc);

  /// wait transaction confirmed
  await Future.delayed(const Duration(seconds: 30));

  /// get wallet state
  final state = await wallet.wallet.getStateData(wallet.rpc);

  /// get previous seqno
  final seqno = state.nextOrderSeqno - BigInt.one;
  for (int i = 0; i < wallet.thereshHold; i++) {
    final signerWalletContract = wallet.signerWalletes[i];

    /// get order contract
    final orderContract = await wallet.wallet.getOrderContract(
        rpc: wallet.rpc, seqno: seqno, signerWallet: signerWalletContract);

    /// approve order
    await orderContract.sendApprove(
        params: VersionedV5TransferParams.external(signer: wallet.signers[i]),
        rpc: wallet.rpc,
        amount: TonHelper.toNano("0.3"));
    if (i + 1 == wallet.thereshHold) {
      await Future.delayed(const Duration(seconds: 30));
      final state = await orderContract.getOrderData(wallet.rpc);
      assert(state.executed == true);
    }
  }
}
