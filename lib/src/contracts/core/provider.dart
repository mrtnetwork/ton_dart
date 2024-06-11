import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/contract.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/models/response/run_method_response.dart';
import 'package:ton_dart/src/provider/models/response/ton_center_address_info.dart';
import 'package:ton_dart/src/provider/provider.dart';

mixin ContractProvider on TonWallets {
  Future<RunMethodResponse> getMethod(
      {required TonApiProvider rpc,
      required String method,
      TonAddress? address,
      List<dynamic> stack = const []}) async {
    return await rpc.request(TonCenterRunGetMethod(
        address: address?.toString() ?? this.address.toString(),
        methodName: method,
        stack: stack));
  }

  Future<TonCenterFullAccountStateResponse> getState(
      {required TonApiProvider rpc}) async {
    final state =
        await rpc.request(TonCenterGetAddressInformation(address.toString()));
    return state;
  }

  Future<String> sendMessage(
      {required TonApiProvider rpc, required Message exMessage}) async {
    final boc = beginCell().store(exMessage).endCell().toBase64();
    final result = await rpc.request(TonCenterSendBocReturnHash(boc));
    return result["hash"];
  }

  Future<bool> isActive(TonApiProvider rpc) async {
    final state = await getState(rpc: rpc);
    return state.state.isActive;
  }
}
