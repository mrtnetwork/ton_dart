import 'package:ton_dart/src/contracts/highload/core/core.dart';
import 'package:ton_dart/src/provider/provider.dart';

mixin HighloadWalletV3ProviderImpl on HighloadWallets {
  Future<String> getPublicKey({
    required TonApiProvider rpc,
  }) async {
    final result = await rpc.request(TonCenterRunGetMethod(
        address: address.toString(), methodName: "get_public_key", stack: []));
    final reader = result.reader;
    return reader.readBigNumberAsHex();
  }

  Future<int> getSubwalletId({required TonApiProvider rpc}) async {
    final result = await rpc.request(TonCenterRunGetMethod(
        address: address.toString(),
        methodName: "get_subwallet_id",
        stack: []));
    final reader = result.reader;
    return reader.readNumber();
  }

  Future<int> getTimeout({required TonApiProvider rpc}) async {
    final result = await rpc.request(TonCenterRunGetMethod(
        address: address.toString(), methodName: "get_timeout", stack: []));
    final reader = result.reader;
    return reader.readNumber();
  }

  Future<int> getLastCleaned({required TonApiProvider rpc}) async {
    final result = await rpc.request(TonCenterRunGetMethod(
        address: address.toString(),
        methodName: "get_last_clean_time",
        stack: []));
    final reader = result.reader;
    return reader.readNumber();
  }

  Future<bool> getProcessed(
      {required TonApiProvider rpc,
      required int queryId,
      bool needClean = true}) async {
    final result = await rpc.request(TonCenterRunGetMethod(
        address: address.toString(),
        methodName: "processed?",
        stack: [
          ["num", queryId],
          ["num", needClean ? -1 : 0]
        ]));
    final reader = result.reader;
    return reader.readBoolean();
  }
}
