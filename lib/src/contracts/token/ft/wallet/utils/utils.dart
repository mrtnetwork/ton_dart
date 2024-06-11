import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/contracts/token/ft/wallet/constants/contants.dart';

class JettonWalletUtils {
  static StateInit buildState(int workchain) {
    return StateInit(
        code: JettonWalletConst.code(workchain), data: beginCell().endCell());
  }
}
