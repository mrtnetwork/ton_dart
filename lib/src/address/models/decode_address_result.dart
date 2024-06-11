import 'package:ton_dart/src/address/address/address.dart';

class DecodeAddressResult {
  final bool? isTestOnly;
  final bool? isBounceable;
  final int workchain;
  final List<int> hash;

  DecodeAddressResult(
      {this.isTestOnly,
      this.isBounceable,
      required this.workchain,
      required this.hash});
  TonAddress get address => TonAddress.fromBytes(workchain, hash);
}
