import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';

class MinterWalletParams {
  final TonAddress owner;
  final Cell? walletCode;
  final String? contentUri;

  const MinterWalletParams(
      {required this.owner, this.walletCode, this.contentUri});
}
