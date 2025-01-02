import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/models/models/out_action.dart';

class MultiOwnerTransferParams<E extends WalletContractTransferParams>
    extends WalletContractTransferParams<OutActionMultiSig> {
  final E params;
  final BigInt expirationDate;
  final BigInt amount;
  final BigInt? orderId;
  final BigInt? queryId;
  MultiOwnerTransferParams(
      {required this.params,
      required this.expirationDate,
      required this.amount,
      this.orderId,
      this.queryId,
      super.messages = const []});
}
