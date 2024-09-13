import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/crypto/crypto.dart';
import 'package:ton_dart/src/models/models.dart';

class HighloadTransferParams implements WalletContractTransferParams {
  final TonPrivateKey signer;
  @override
  final List<OutActionSendMsg> messages;
  final BigInt queryId;
  final BigInt? value;
  const HighloadTransferParams(
      {required this.messages,
      required this.queryId,
      required this.signer,
      this.value});
}
