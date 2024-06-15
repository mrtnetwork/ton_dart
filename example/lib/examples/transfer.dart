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

  final privateKey = TonPrivateKey.fromBytes(List<int>.filled(32, 39));
  final wallet =
      WalletV4(workChain: -1, publicKey: privateKey.toPublicKey().toBytes());

  final destination =
      TonAddress("Ef_GHcGwnw-bASoxTGQRMNwMQ6w9iCQnTqrv1REDfJ5fCYD2");

  await wallet.sendTransfer(messages: [
    wallet.createMessageInfo(
        amount: TonHelper.toNano("0.1"), destination: destination)
  ], privateKey: privateKey, rpc: rpc);

  /// https://testnet.tonscan.org/tx/by-msg-hash/ds948UY3_gyU8lXDwgFWMb7ddxcGiqSV7v0gz6kkGu8=
}
