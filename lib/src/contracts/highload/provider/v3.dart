import 'package:ton_dart/src/contracts/highload/core/core.dart';
import 'package:ton_dart/src/provider/provider.dart';

mixin HighloadWalletV3ProviderImpl on HighloadWallets {
  Future<String> getPublicKey({required TonProvider rpc}) async {
    final result = await getStateStack(rpc: rpc, method: "get_public_key");
    final reader = result.reader();
    return reader.readBigNumberAsHex();
  }

  Future<BigInt> getBalance({required TonProvider rpc}) async {
    final result = await getState(rpc: rpc);
    return result.balance;
  }

  Future<int> getSubwalletId({required TonProvider rpc}) async {
    final result = await getStateStack(rpc: rpc, method: "get_subwallet_id");
    final reader = result.reader();
    return reader.readNumber();
  }

  Future<int> getTimeout({required TonProvider rpc}) async {
    final result = await getStateStack(rpc: rpc, method: "get_timeout");
    final reader = result.reader();
    return reader.readNumber();
  }

  Future<int> getLastCleaned({required TonProvider rpc}) async {
    final result = await getStateStack(rpc: rpc, method: "get_last_clean_time");
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
        method: "processed?",
        stack: rpc.isTonCenter
            ? [
                ["num", queryId],
                ["num", clean]
              ]
            : ["$queryId", "$clean"]);
    final reader = result.reader();
    return reader.readBoolean();
  }
}
