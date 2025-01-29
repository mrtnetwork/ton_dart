import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/models/models/account_status.dart';
import 'package:ton_dart/src/models/models/currency_collection.dart';
import 'package:ton_dart/src/models/models/message.dart';
import 'package:ton_dart/src/models/models/transaction_description.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';

import 'hash_update.dart';

class _TonTransactionUtils {
  static Dictionary<int, Message> dict({Map<int, Message> message = const {}}) {
    return Dictionary.fromEnteries(
        key: DictionaryKey.uintCodec(15),
        value: MessageCodec.codec,
        map: message);
  }
}

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L263
/// transaction$0111 account_addr:bits256 lt:uint64
///  prev_trans_hash:bits256 prev_trans_lt:uint64 now:uint32
///  outmsg_cnt:uint15
///  orig_status:AccountStatus end_status:AccountStatus
///  ^[ in_msg:(Maybe ^(Message Any)) out_msgs:(HashmapE 15 ^(Message Any)) ]
///  total_fees:CurrencyCollection state_update:^(HASH_UPDATE Account)
///  description:^TransactionDescr = Transaction;
class TonTransaction extends TonSerialization {
  final BigInt address;
  final BigInt lt;
  final BigInt prevTransactionHash;
  final BigInt prevTransactionLt;
  final int now;
  final int outMessagesCount;
  final AccountStatus oldStatus;
  final AccountStatus endStatus;
  final Message? inMessage;
  final Map<int, Message> outMessages;
  final CurrencyCollection totalFees;
  final HashUpdate stateUpdate;
  final TransactionDescription description;
  final Cell raw;
  const TonTransaction(
      {required this.address,
      required this.lt,
      required this.prevTransactionHash,
      required this.prevTransactionLt,
      required this.now,
      required this.outMessagesCount,
      required this.oldStatus,
      required this.endStatus,
      this.inMessage,
      required this.outMessages,
      required this.totalFees,
      required this.stateUpdate,
      required this.description,
      required this.raw});

  factory TonTransaction.deserialize(Slice slice) {
    final raw = slice.asCell();

    if (slice.loadUint(4) != 0x07) {
      throw const TonDartPluginException('Invalid transaction slice data.');
    }

    final BigInt address = slice.loadUintBig(256);
    final BigInt lt = slice.loadUintBig(64);
    final BigInt prevTransactionHash = slice.loadUintBig(256);
    final BigInt prevTransactionLt = slice.loadUintBig(64);
    final int now = slice.loadUint(32);
    final int outMessagesCount = slice.loadUint(15);
    final AccountStatus oldStatus = AccountStatus.deserialize(slice);
    final AccountStatus endStatus = AccountStatus.deserialize(slice);
    final msgRef = slice.loadRef();
    final msgSlice = msgRef.beginParse();
    final Message? inMessage = msgSlice
        .loadBit()
        .onTrue(() => Message.deserialize(msgSlice.loadRef().beginParse()));
    final Dictionary<int, Message> outMessages = _TonTransactionUtils.dict();
    outMessages.loadFromClice(msgSlice);
    msgSlice.endParse();
    final CurrencyCollection totalFees = CurrencyCollection.deserialize(slice);
    final HashUpdate stateUpdate =
        HashUpdate.deserialize(slice.loadRef().beginParse());
    final TransactionDescription description =
        TransactionDescription.deserialize(slice.loadRef().beginParse());
    return TonTransaction(
        address: address,
        lt: lt,
        prevTransactionHash: prevTransactionHash,
        prevTransactionLt: prevTransactionLt,
        now: now,
        outMessagesCount: outMessagesCount,
        oldStatus: oldStatus,
        endStatus: endStatus,
        inMessage: inMessage,
        outMessages: outMessages.asMap,
        totalFees: totalFees,
        stateUpdate: stateUpdate,
        description: description,
        raw: raw);
  }
  factory TonTransaction.fromJson(Map<String, dynamic> json) {
    return TonTransaction(
        address: BigintUtils.parse(json['address']),
        lt: BigintUtils.parse(json['lt']),
        prevTransactionHash: BigintUtils.parse(json['prev_transaction_hash']),
        prevTransactionLt: BigintUtils.parse(json['prev_transaction_lt']),
        now: json['now'],
        outMessagesCount: json['out_meessages_count'],
        oldStatus: AccountStatus.fromJson(json['old_status']),
        endStatus: AccountStatus.fromJson(json['end_status']),
        inMessage: (json['in_message'] as Object?)?.convertTo<Message, Map>(
            (result) => Message.fromJson(result.cast())),
        outMessages: (json['out_messages'] as Map).map<int, Message>(
            (key, value) =>
                MapEntry(key, Message.fromJson((value as Map).cast()))),
        totalFees: CurrencyCollection.fromJson(json['total_fees']),
        stateUpdate: HashUpdate.fromJson(json['state_update']),
        description: TransactionDescription.fromJson(json['description']),
        raw: Cell.fromBase64(json['raw']));
  }

  @override
  void store(Builder builder) {
    builder.storeUint(0x07, 4);
    builder.storeUint(address, 256);
    builder.storeUint(lt, 64);
    builder.storeUint(prevTransactionHash, 256);
    builder.storeUint(prevTransactionLt, 64);
    builder.storeUint(now, 32);
    builder.storeUint(outMessagesCount, 15);
    oldStatus.store(builder);
    endStatus.store(builder);

    final msgBuilder = beginCell();
    if (inMessage != null) {
      msgBuilder.storeBitBolean(true);
      msgBuilder.storeRef(beginCell().store(inMessage!).endCell());
    } else {
      msgBuilder.storeBitBolean(false);
    }
    msgBuilder.storeDict(dict: _TonTransactionUtils.dict(message: outMessages));
    builder.storeRef(msgBuilder.endCell());
    totalFees.store(builder);
    builder.storeRef(beginCell().store(stateUpdate).endCell());
    builder.storeRef(beginCell().store(description).endCell());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address.toString(),
      'lt': lt.toString(),
      'prev_transaction_hash': prevTransactionHash.toString(),
      'prev_transaction_lt': prevTransactionLt.toString(),
      'now': now,
      'out_meessages_count': outMessagesCount,
      'old_status': oldStatus.toJson(),
      'end_status': endStatus.toJson(),
      'in_message': inMessage?.toJson(),
      'out_messages': outMessages.map<int, Map<String, dynamic>>(
          (key, value) => MapEntry(key, value.toJson())),
      'total_fees': totalFees.toJson(),
      'state_update': stateUpdate.toJson(),
      'description': description.toJson(),
      'raw': raw.toBase64()
    };
  }

  List<int> hash() {
    return raw.hash();
  }
}
