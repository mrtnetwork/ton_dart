import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/highload/highload_wallet.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/types.dart';
import 'package:ton_dart/src/provider/provider.dart';

mixin HighloadWalletV3ProviderImpl<T extends ContractState>
    on HighloadWallets<T> {
  Future<String> getPublicKey(TonProvider rpc) async {
    final result = await getStateStack(rpc: rpc, method: 'get_public_key');
    final reader = result.reader();
    return reader.readBigNumberAsHex();
  }

  Future<BigInt> getBalance(TonProvider rpc) async {
    final result = await getState(rpc: rpc);
    return result.balance;
  }

  Future<T> readState(TonProvider rpc) async {
    final stateData =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state =
        HighloadWalletV3State.deserialize(stateData.data!.beginParse());
    return state as T;
  }

  Future<int> getSubwalletId({required TonProvider rpc}) async {
    final result = await getStateStack(rpc: rpc, method: 'get_subwallet_id');
    final reader = result.reader();
    return reader.readNumber();
  }

  Future<int> getTimeout({required TonProvider rpc}) async {
    final result = await getStateStack(rpc: rpc, method: 'get_timeout');
    final reader = result.reader();
    return reader.readNumber();
  }

  Future<int> getLastCleaned({required TonProvider rpc}) async {
    final result = await getStateStack(rpc: rpc, method: 'get_last_clean_time');
    final reader = result.reader();
    return reader.readNumber();
  }

  Future<bool> getProcessed(
      {required TonProvider rpc,
      required int queryId,
      bool needClean = true}) async {
    final int clean = needClean ? 1 : 0;
    final result = await getStateStack(
        rpc: rpc,
        method: 'processed?',
        stack: rpc.isTonCenter
            ? [
                ['num', queryId],
                ['num', clean]
              ]
            : ['$queryId', '$clean']);
    final reader = result.reader();
    return reader.readBoolean();
  }
}
