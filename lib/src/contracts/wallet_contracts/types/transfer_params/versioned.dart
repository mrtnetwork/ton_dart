import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/crypto/crypto.dart';
import 'package:ton_dart/src/models/models/out_action.dart';

class VersionedTransferParams
    extends WalletContractTransferParams<OutActionSendMsg> {
  final TonPrivateKey privateKey;
  VersionedTransferParams(
      {super.messages = const [], required this.privateKey});
}
