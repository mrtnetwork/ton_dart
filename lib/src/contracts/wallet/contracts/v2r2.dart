import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/contracts/core/provider.dart';
import 'package:ton_dart/src/contracts/wallet/core/version.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/wallet/utils/utils.dart';

/// This version introduces the valid_until parameter which is used to set a time limit for a
/// transaction in case you don't want it to be confirmed too late. This version also doesn't
/// have the get-method for public key, which is added in V2R2.
/// It can be used in most cases, but it misses one cool feature, which was added in V3.
/// https://docs.ton.org/participate/wallets/contracts
class WalletV2R2 extends WalletContract {
  @override
  final StateInit state;

  @override
  final TonAddress address;

  const WalletV2R2._({required this.state, required this.address});

  factory WalletV2R2({required int workChain, required List<int> publicKey}) {
    final state = VersionedWalletUtils.buildState(
        publicKey: publicKey, type: WalletVersion.v2R2);
    return WalletV2R2._(
        state: state,
        address: TonAddress.fromState(state: state, workChain: workChain));
  }
  static Future<WalletV2R2> fromAddress(
      {required TonAddress address, required TonProvider rpc}) async {
    final data =
        await ContractProvider.getStaticState(rpc: rpc, address: address);
    final state = VersionedWalletUtils.buildFromAddress(
        address: address, stateData: data.data, type: WalletVersion.v2R2);
    return WalletV2R2._(state: state.item1, address: address);
  }

  @override
  WalletVersion get type => WalletVersion.v2R2;

  @override
  int? get subWalletId => null;
}
