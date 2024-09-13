import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/utils/transaction_utils.dart';
import 'package:ton_dart/src/crypto/crypto.dart';
import 'package:ton_dart/src/models/models.dart';

class VersionedV5TransferParams
    extends WalletContractTransferParams<OutActionWalletV5> {
  final TonPrivateKey? privateKey;
  final WalletV5AuthType type;
  final BigInt? queryId;
  VersionedV5TransferParams._({
    this.type = WalletV5AuthType.external,
    List<OutActionWalletV5> messages = const [],
    this.privateKey,
    this.queryId,
  }) : super(messages: messages);
  factory VersionedV5TransferParams.external({
    required TonPrivateKey signer,
    List<OutActionWalletV5> messages = const [],
  }) {
    return VersionedV5TransferParams._(
        privateKey: signer,
        messages: messages,
        type: WalletV5AuthType.external);
  }
  factory VersionedV5TransferParams.internal({
    required TonPrivateKey signer,
    List<OutActionWalletV5> messages = const [],
  }) {
    return VersionedV5TransferParams._(
        privateKey: signer,
        messages: messages,
        type: WalletV5AuthType.internal);
  }
  factory VersionedV5TransferParams.extension({
    required BigInt queryId,
    List<OutActionWalletV5> messages = const [],
  }) {
    return VersionedV5TransferParams._(
        queryId: queryId, messages: messages, type: WalletV5AuthType.extension);
  }
}
