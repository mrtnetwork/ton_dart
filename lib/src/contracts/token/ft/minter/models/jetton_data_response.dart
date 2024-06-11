import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';

class JettonDataResponse {
  final BigInt totalSupply;
  final bool mintable;
  final TonAddress admin;
  final Cell content;
  final Cell walletCode;
  const JettonDataResponse(
      {required this.totalSupply,
      required this.mintable,
      required this.admin,
      required this.content,
      required this.walletCode});
}
