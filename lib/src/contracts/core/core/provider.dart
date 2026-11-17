import 'package:blockchain_utils/chain/networks.dart';
import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/provider/models/account_state.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/provider/models/run_method_response.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/tuple/tuple.dart';

mixin ContractProvider {
  /// the address of contract
  TonAddress get address;

  /// call contract methods
  Future<RunMethodResponse> getStateStack({
    required TonQuickClient client,
    required String method,
    TonAddress? address,
    List<TupleItem> stack = const [],
    bool throwOnFail = true,
  }) async {
    final response = await client.runGetMethod(
      address: address ?? this.address,
      method: method,
      args: stack,
    );
    if (throwOnFail && response.exitCode != 0) {
      throw RPCError(
        relatedNetwork: BlockchainNetwork.ton,
        message: 'Run method failed with exit code ${response.exitCode}',
        errorCode: response.exitCode,
        request: {
          'method': method,
          'address': (address ?? this.address).toString(),
        },
        jsonRpcErrpr: {'error': response.items.map((e) => e.toJson()).toList()},
      );
    }
    return response;
  }

  /// static method for get account state (balance, code, data , etc.)
  static Future<AccountStateResponse> getStaticState({
    required TonQuickClient client,
    required TonAddress address,
  }) async {
    return client.getAccountState(address);
  }

  /// static method for get account state if initialized. otherwise throw exception
  static Future<AccountStateResponse> getActiveState({
    required TonQuickClient client,
    required TonAddress address,
  }) async {
    final state = await getStaticState(client: client, address: address);
    if (!state.state.isActive) {
      throw TonContractErrors.stateIsInactive;
    }
    if (state.state.isFrozen && (state.code == null || state.data == null)) {
      throw TonContractErrors.stateIsFrozen;
    }
    return state;
  }

  /// get account state (balance, code, data , etc.)
  Future<AccountStateResponse> getState({
    required TonQuickClient client,
  }) async {
    final state = await getStaticState(client: client, address: address);
    return state;
  }

  Future<String> sendMessage({
    required TonQuickClient client,
    required Message exMessage,
  }) async {
    final boc = exMessage.serialize();
    return client.sendBoc(boc.toBase64());
  }

  /// check if contract is initialized.
  Future<bool> isActive(TonQuickClient client) async {
    final state = await getState(client: client);

    return state.state.isActive;
  }
}
