import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

import 'provider.dart';

abstract class TonWallets {
  abstract final TonAddress address;
  int get workChain => address.workChain;
  abstract final int? subWalletId;
  const TonWallets();
}

abstract class TonContract<T> extends TonWallets with ContractProvider {
  Cell code(int workchain);
  Cell data(T params);
  abstract final StateInit? state;
  const TonContract();
}
