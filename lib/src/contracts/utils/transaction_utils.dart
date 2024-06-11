import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/common_message_info_relaxed.dart';
import 'package:ton_dart/src/models/models/currency_collection.dart';
import 'package:ton_dart/src/models/models/message_relaxed.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class TransactioUtils {
  static MessageRelaxed internal({
    required TonAddress destination,
    required BigInt amount,
    Cell? body,
    StateInit? initState,
    bool bounce = false,
    bool bounced = false,
  }) {
    return MessageRelaxed(
        info: CommonMessageInfoRelaxedInternal(
            ihrDisabled: true,
            bounce: bounce,
            bounced: bounced,
            dest: destination,
            value: CurrencyCollection(coins: amount),
            ihrFee: BigInt.zero,
            forwardFee: BigInt.zero,
            createdLt: BigInt.zero,
            createdAt: 0),
        body: body ?? Cell.empty,
        init: initState);
  }

  static Cell buildMessageBody(String? memo) {
    if (memo != null) {
      return beginCell().storeUint(0, 32).storeStringTail(memo).endCell();
    }
    return Cell.empty;
  }
}
