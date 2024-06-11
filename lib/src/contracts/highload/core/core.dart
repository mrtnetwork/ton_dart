import 'package:ton_dart/src/contracts/core/contract.dart';
import 'package:ton_dart/src/contracts/highload/models/v3_account_params.dart';

abstract class HighloadWallets<T>
    extends TonContract<HighloadWalletV3AccountParams> {
  const HighloadWallets();
}
