import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/transfer_params/highload.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core/core.dart';

abstract class HighloadWallets<T extends ContractState>
    extends WalletContract<T, HighloadTransferParams> {
  HighloadWallets({
    required T? stateInit,
    required super.address,
  }) : super(
            chain: TonChain.fromWorkchain(address.workChain), state: stateInit);
}
