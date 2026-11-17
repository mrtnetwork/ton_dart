import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/highload/highload_wallet.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/types.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/tuple/tuple.dart';

mixin HighloadWalletV3ProviderImpl<T extends ContractState>
    on HighloadWallets<T> {
  Future<String> getPublicKey(TonQuickClient client) async {
    final result = await getStateStack(
      client: client,
      method: 'get_public_key',
    );
    final reader = result.reader();
    return reader.readBigNumberAsHex();
  }

  Future<BigInt> getBalance(TonQuickClient client) async {
    final result = await getState(client: client);
    return result.balance;
  }

  Future<T> readState(TonQuickClient client) async {
    final stateData = await ContractProvider.getActiveState(
      client: client,
      address: address,
    );
    final state = HighloadWalletV3State.deserialize(
      stateData.data!.beginParse(),
    );
    return state as T;
  }

  Future<int> getSubwalletId({required TonQuickClient client}) async {
    final result = await getStateStack(
      client: client,
      method: 'get_subwallet_id',
    );
    final reader = result.reader();
    return reader.readNumber();
  }

  Future<int> getTimeout({required TonQuickClient client}) async {
    final result = await getStateStack(client: client, method: 'get_timeout');
    final reader = result.reader();
    return reader.readNumber();
  }

  Future<int> getLastCleaned({required TonQuickClient client}) async {
    final result = await getStateStack(
      client: client,
      method: 'get_last_clean_time',
    );
    final reader = result.reader();
    return reader.readNumber();
  }

  Future<bool> getProcessed({
    required TonQuickClient client,
    required int queryId,
    bool needClean = true,
  }) async {
    final int clean = needClean ? 1 : 0;
    final result = await getStateStack(
      client: client,
      method: 'processed?',
      stack: [
        TupleItemInt(BigInt.from(queryId)),
        TupleItemInt(BigInt.from(clean)),
      ],
    );
    final reader = result.reader();
    return reader.readBoolean();
  }
}
