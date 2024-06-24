import 'package:ton_dart/ton_dart.dart';

class JettonTransferParams {
  final TonAddress destination;
  final BigInt forwardTonAmount;
  final BigInt jettonAmount;
  final BigInt amount;
  final Cell? customPayload;
  final Cell? forwardPayload;
  const JettonTransferParams(
      {required this.destination,
      required this.forwardTonAmount,
      required this.jettonAmount,
      required this.amount,
      this.customPayload,
      this.forwardPayload});
}
