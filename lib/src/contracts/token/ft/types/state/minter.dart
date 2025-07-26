import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/ft/constants/constant.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/tuple/tuple.dart';

class MinterWalletState extends ContractState {
  final TonAddress? owner;
  final Cell content;
  final BigInt totalSupply;
  final Cell? walletCode;
  Map<String, dynamic> toJson() {
    return {
      'owner': owner?.toFriendlyAddress(),
      'content': content.toBase64(),
      'totalSupply': totalSupply,
      'walletCode': walletCode?.toBase64(),
      'metadata': metadata.toJson()
    };
  }

  factory MinterWalletState.fromTupple(TupleReader reader) {
    final item = reader.pop();
    final BigInt totalSupply;
    if (item.type == TupleItemTypes.intItem) {
      totalSupply = (item as TupleItemInt).value;
    } else {
      totalSupply = reader.readBigNumber();
    }
    reader.readNumber();
    final TonAddress? admin = reader.readAddressOpt();
    final Cell content = reader.readCell();
    final Cell walletCode = reader.readCell();
    return MinterWalletState._(
        totalSupply: totalSupply,
        owner: admin,
        content: content,
        walletCode: walletCode);
  }
  const MinterWalletState._({
    required this.owner,
    required this.totalSupply,
    required this.walletCode,
    required this.content,
  });
  factory MinterWalletState(
      {required TonAddress owner,
      required TonChainId chain,
      TokenMetadata? metadata,
      Cell? contect,
      Cell? walletCode,
      BigInt? totalSupply}) {
    if (metadata != null && contect != null) {
      throw const TonContractException(
          'Use only content or metadata for jetton content');
    }
    return MinterWalletState._(
        owner: owner,
        totalSupply: totalSupply ?? BigInt.zero,
        walletCode: walletCode,
        content: contect ?? TokneMetadataUtils.encodeMetadata(metadata));
  }
  factory MinterWalletState.deserialize(Slice slice) {
    final BigInt totalSupply = slice.loadCoins();
    final TonAddress? owner = slice.loadMaybeAddress();
    final Cell content = slice.loadRef();
    final Cell walletCode = slice.loadRef();
    return MinterWalletState._(
        owner: owner,
        totalSupply: totalSupply,
        walletCode: walletCode,
        content: content);
  }

  TokenMetadata get metadata => TokneMetadataUtils.loadContent(content);

  @override
  StateInit initialState({int? workchain}) {
    return StateInit(
        data: initialData(),
        code: JettonMinterConst.code(owner?.workChain ?? 0));
  }

  @override
  Cell initialData({int? workchain}) {
    final Cell code =
        walletCode ?? JettonWalletConst.code(owner?.workChain ?? 0);
    return beginCell()
        .storeCoins(totalSupply)
        .storeAddress(owner)
        .storeRef(content)
        .storeRef(code)
        .endCell();
  }
}
