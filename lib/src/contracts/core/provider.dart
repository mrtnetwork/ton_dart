import 'package:blockchain_utils/exception/rpc_error.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/contracts/core/contract.dart';
import 'package:ton_dart/src/contracts/models/account_state.dart';
import 'package:ton_dart/src/contracts/models/run_method_response.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';

mixin ContractProvider on TonWallets {
  Future<RunMethodResponse> getStateStack(
      {required TonProvider rpc,
      required String method,
      TonAddress? address,
      List<dynamic> stack = const [],
      bool throwOnFail = true}) async {
    final RunMethodResponse response;
    if (rpc.isTonCenter) {
      final request = await rpc.request(TonCenterRunGetMethod(
          address: address?.toString() ?? this.address.toString(),
          methodName: method,
          stack: stack));
      response =
          RunMethodResponse(items: request.items, exitCode: request.exitCode);
    } else {
      final request = await rpc.request(TonApiExecGetMethodForBlockchainAccount(
          accountId: address?.toString() ?? this.address.toString(),
          methodName: method,
          args: stack.cast()));
      response = RunMethodResponse(
          items: request.toTuples(), exitCode: request.exitCode);
    }
    if (throwOnFail && response.exitCode != 0) {
      throw RPCError(
          message: "Run method failed with exit code ${response.exitCode}",
          errorCode: response.exitCode,
          data: null,
          request: {
            "method": method,
            "address": address?.toString() ?? this.address.toString(),
            "error": response.items.map((e) => e.toJson()).toList()
          });
    }
    return response;
  }

  static Future<AccountStateResponse> getStaticState(
      {required TonProvider rpc, required TonAddress address}) async {
    if (rpc.isTonCenter) {
      final state =
          await rpc.request(TonCenterGetAddressInformation(address.toString()));
      return AccountStateResponse(
          balance: state.balance,
          code: TonHelper.tryToCell(state.code),
          data: TonHelper.tryToCell(state.data),
          state: state.state);
    }
    try {
      final state =
          await rpc.request(TonApiGetBlockchainRawAccount(address.toString()));
      return AccountStateResponse(
          balance: state.balance,
          code: TonHelper.tryToCell(state.code),
          data: TonHelper.tryToCell(state.data),
          state: state.status);
    } on RPCError catch (e) {
      if (e.message == ApiProviderConst.tonApiNotiFoundError) {
        return AccountStateResponse(
            balance: BigInt.zero,
            code: null,
            data: null,
            state: AccountStatusResponse.uninit);
      }

      rethrow;
    }
  }

  Future<AccountStateResponse> getState({required TonProvider rpc}) async {
    return getStaticState(rpc: rpc, address: address);
  }

  Future<String> sendMessage(
      {required TonProvider rpc, required Message exMessage}) async {
    final boc = exMessage.serialize();
    if (rpc.isTonCenter) {
      await rpc.request(TonCenterSendBocReturnHash(boc.toBase64()));
    } else {
      await rpc
          .request(TonApiSendBlockchainMessage(batch: [], boc: boc.toBase64()));
    }

    return StringUtils.decode(boc.hash(), type: StringEncoding.base64);
  }

  Future<bool> isActive(TonProvider rpc) async {
    final state = await getState(rpc: rpc);
    return state.state.isActive;
  }
}
