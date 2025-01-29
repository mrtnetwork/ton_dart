import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/ft/constants/constant.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class StableTokenMinterState extends ContractState {
  final TonAddress adminAddress;
  final TonAddress? nextAdminAddress;
  final Cell content;
  final BigInt totalSupply;
  final Cell? walletCode;
  Map<String, dynamic> toJson() {
    return {
      'adminAddress': adminAddress.toRawAddress(),
      'content': content.toBase64(),
      'totalSupply': totalSupply.toString(),
      'walletCode': walletCode?.toBase64(),
      'nextAdminAddress': nextAdminAddress?.toRawAddress(),
      'metadata': metadata.toJson()
    };
  }

  factory StableTokenMinterState.fromJson(Map<String, dynamic> json) {
    return StableTokenMinterState._(
        adminAddress: TonAddress(json['adminAddress']),
        totalSupply: BigintUtils.parse(json['totalSupply']),
        walletCode: Cell.fromBase64(json['walletCode']),
        content: Cell.fromBase64(json['content']),
        nextAdminAddress: json['nextAdminAddress'] == null
            ? null
            : TonAddress(json['nextAdminAddress']));
  }

  const StableTokenMinterState._({
    required this.adminAddress,
    required this.totalSupply,
    required this.walletCode,
    required this.content,
    required this.nextAdminAddress,
  });
  factory StableTokenMinterState(
      {required TonAddress adminAddress,
      TonAddress? transferAdminAddress,
      TokenMetadata? metadata,
      Cell? contect,
      Cell? walletCode,
      BigInt? totalSupply}) {
    if (metadata != null && contect != null) {
      throw const TonContractException(
          'Use only content or metadata for jetton content');
    }
    return StableTokenMinterState._(
        adminAddress: adminAddress,
        nextAdminAddress: transferAdminAddress,
        totalSupply: totalSupply ?? BigInt.zero,
        walletCode: walletCode,
        content: contect ?? TokneMetadataUtils.encodeMetadata(metadata));
  }
  factory StableTokenMinterState.deserialize(Slice slice) {
    final BigInt totalSupply = slice.loadCoins();
    final TonAddress adminAddress = slice.loadAddress();
    final TonAddress? nextAdminAddress = slice.loadMaybeAddress();
    final Cell walletCode = slice.loadRef();
    final Cell content = slice.loadRef();
    return StableTokenMinterState._(
        adminAddress: adminAddress,
        nextAdminAddress: nextAdminAddress,
        totalSupply: totalSupply,
        walletCode: walletCode,
        content: content);
  }

  TokenMetadata get metadata =>
      StableJettonOffChainMetadata.deserialize(content.beginParse());

  @override
  StateInit initialState({int? workchain}) {
    return StateInit(
        data: initialData(),
        code: JettonMinterConst.stableCode(adminAddress.workChain));
  }

  @override
  Cell initialData({int? workchain}) {
    final Cell code =
        walletCode ?? JettonWalletConst.stableCode(adminAddress.workChain);
    return beginCell()
        .storeCoins(totalSupply)
        .storeAddress(adminAddress)
        .storeAddress(nextAdminAddress)
        .storeRef(code)
        .storeRef(content)
        .endCell();
  }
}
