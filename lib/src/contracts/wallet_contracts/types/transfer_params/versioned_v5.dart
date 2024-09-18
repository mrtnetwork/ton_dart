import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/wallet_contracts.dart';
import 'package:ton_dart/src/crypto/crypto.dart';
import 'package:ton_dart/src/models/models.dart';

class VersionedV5TransferParams
    extends WalletContractTransferParams<OutActionWalletV5> {
  final TonPrivateKey signer;
  final WalletV5AuthType type;
  VersionedV5TransferParams._({
    this.type = WalletV5AuthType.external,
    List<OutActionWalletV5> messages = const [],
    required this.signer,
  }) : super(messages: messages);
  factory VersionedV5TransferParams.external(
      {required TonPrivateKey signer,
      List<OutActionWalletV5> messages = const []}) {
    return VersionedV5TransferParams._(
        signer: signer, messages: messages, type: WalletV5AuthType.external);
  }
}
