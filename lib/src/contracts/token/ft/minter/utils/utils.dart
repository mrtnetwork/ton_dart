import 'package:blockchain_utils/binary/utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/contracts/token/ft/minter/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/ft/wallet/constants/contants.dart';

class JettonMinterUtils {
  static Cell createUriContent(String? uri) {
    final cell = beginCell();
    cell.storeUint(1, 8);
    if (uri != null) {
      cell.storeStringTail(uri);
    }
    return cell.endCell();
  }

  static Cell minterData(
      {required TonAddress owner,
      required Cell walletCode,
      String? contentUri}) {
    final content = createUriContent(contentUri);
    return beginCell()
        .storeCoins(0)
        .storeAddress(owner)
        .storeRef(content)
        .storeRef(walletCode)
        .endCell();
  }

  static StateInit buildState({required TonAddress owner, String? contentUri}) {
    return StateInit(
        code: code(owner.workChain),
        data: minterData(
            owner: owner,
            walletCode: JettonWalletConst.code(owner.workChain),
            contentUri: contentUri));
  }

  static Cell code(int workchain) {
    if (workchain < 0) {
      return Cell.fromBytes(
          BytesUtils.fromHexString(JettonMinterConst.testnetWorkChain));
    }
    return Cell.fromBytes(BytesUtils.fromHexString(JettonMinterConst.code));
  }
}
