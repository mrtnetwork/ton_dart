import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core/chain.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/models/v5_client_id.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/versioned.dart';

class VersionedWalletUtils {
  static VersionedWalletState readState(
      {required Cell? stateData,
      required WalletVersion type,
      required TonChain chain}) {
    if (stateData == null) {
      throw TonContractExceptionConst.stateIsInactive;
    }
    try {
      final cell = stateData.beginParse();
      int seqno;
      List<int> pubkeyBytes;
      int? subWallet;
      switch (type) {
        case WalletVersion.v1R1:
        case WalletVersion.v1R2:
        case WalletVersion.v1R3:
        case WalletVersion.v2R1:
        case WalletVersion.v2R2:
          seqno = cell.loadUint32();
          pubkeyBytes = cell.loadBuffer(32);
          break;
        case WalletVersion.v3R1:
        case WalletVersion.v3R2:
        case WalletVersion.v4:
          seqno = cell.loadUint32();
          subWallet = cell.loadUint32();
          pubkeyBytes = cell.loadBuffer(32);
          break;
        case WalletVersion.v5R1:
          final pubKeyEnabled = cell.loadBoolean();
          seqno = cell.loadUint32();
          final context =
              loadV5Context(contextBytes: cell.loadBuffer(4), chain: chain);
          pubkeyBytes = cell.loadBuffer(32);
          List<TonAddress> extensionPubkeys = [];
          final pubRefs = cell.loadMaybeRef();
          if (pubRefs != null) {
            final Dictionary<List<int>, BigInt> items = Dictionary.loadDirect(
                key: DictionaryKey.bufferCodec(32),
                value: DictionaryValue.bigIntValueCodec(1),
                slice: pubRefs.beginParse());
            extensionPubkeys = items.keys
                .map((e) => TonAddress.fromBytes(chain.workchain, e))
                .toList();
          }

          return V5VersionedWalletState(
              publicKey: pubkeyBytes,
              seqno: seqno,
              context: context,
              version: type,
              setPubKeyEnabled: pubKeyEnabled,
              extensionPubKeys: extensionPubkeys);
        default:
          throw UnimplementedError();
      }
      if (subWallet == null) {
        return NoneSubWalletVersionedWalletState(
            publicKey: pubkeyBytes, seqno: seqno, version: type);
      }
      return SubWalletVersionedWalletState(
          subwallet: subWallet,
          publicKey: pubkeyBytes,
          seqno: seqno,
          version: type);
    } catch (e) {
      throw TonContractException('Invalid ${type.name} state account data.');
    }
  }

  static V5R1Context loadV5Context(
      {required List<int> contextBytes, required TonChain chain}) {
    final contextId = BitReader(BitString(contextBytes, 0, 32)).loadInt(32);
    final context = BigInt.from(contextId) ^ BigInt.from(chain.id);
    final slice = beginCell().storeInt(context, 32).endCell().beginParse();
    final isClientContext = slice.loadBoolean();
    if (isClientContext) {
      final workchain = slice.loadInt(8);
      final walletVersionRaw = slice.loadUint(8);
      if (walletVersionRaw != 0) {
        throw const TonContractException('Invalid wallet contract v5 version.');
      }
      final subwalletNumber = slice.loadUint(15);
      if (chain.workchain != workchain) {
        throw TonContractException('Incorrect workchain.',
            details: {'expected': workchain, 'got': chain.workchain});
      }
      return V5R1ClientContext(chain: chain, subwalletNumber: subwalletNumber);
    }
    return V5R1CustomContext(context: slice.loadUint(31), chain: chain);
  }

  static T buildFromAddress<T extends VersionedWalletState>({
    required Cell? stateData,
    required WalletVersion type,
    required TonAddress address,
    required TonChain? chain,
  }) {
    final state = readState(
        stateData: stateData,
        type: type,
        chain: chain ?? TonChain.fromWorkchain(address.workChain));
    final StateInit currentState = state.initialState();
    final currentAddress =
        TonAddress.fromState(state: currentState, workChain: address.workChain);
    if (currentAddress.toRawAddress() != address.toRawAddress()) {
      throw TonContractException(
          'Invalid wallet address. state gives a different address',
          details: {
            'expected': currentAddress.toRawAddress(),
            'address': address.toRawAddress()
          });
    }
    if (state is! T) {
      throw TonContractException('Incurrect state casting.',
          details: {'expected': state.toString(), 'got': '$T'});
    }
    return state;
  }
}
