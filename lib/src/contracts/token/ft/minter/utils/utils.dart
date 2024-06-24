import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/contracts/token/ft/minter/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/ft/wallet/constants/contants.dart';

class JettonMinterUtils {
  static Cell minterData(
      {required TonAddress owner,
      required Cell walletCode,
      TokenMetadata? metadata}) {
    final content = TokneMetadataUtils.encodeMetadata(metadata);
    return beginCell()
        .storeCoins(0)
        .storeAddress(owner)
        .storeRef(content)
        .storeRef(walletCode)
        .endCell();
  }

  static StateInit buildState(
      {required TonAddress owner, TokenMetadata? metadata}) {
    return StateInit(
        code: code(owner.workChain),
        data: minterData(
            owner: owner,
            walletCode: JettonWalletConst.code(owner.workChain),
            metadata: metadata));
  }

  static Cell code(int workchain) {
    if (workchain < 0) {
      return Cell.fromBytes(
          BytesUtils.fromHexString(JettonMinterConst.testnetWorkChain));
    }
    return Cell.fromBytes(BytesUtils.fromHexString(JettonMinterConst.code));
  }
}
