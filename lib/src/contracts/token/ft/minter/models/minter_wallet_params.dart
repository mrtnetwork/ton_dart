import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';

class MinterWalletParams {
  final TonAddress owner;
  final Cell? walletCode;
  final TokenMetadata? metadata;

  const MinterWalletParams(
      {required this.owner, this.walletCode, this.metadata});
}
