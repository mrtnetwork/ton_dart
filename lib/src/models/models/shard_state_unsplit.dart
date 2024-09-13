import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';

import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extentions.dart';
import 'master_chain_state_extra.dart';
import 'shard_accounts.dart';
import 'shard_ident.dart';

class _ShardStateUnsplitConst {
  static const int magic = 0x9023afe2;
}

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L396
/// shard_state#9023afe2 global_id:int32
///  shard_id:ShardIdent
///  seq_no:uint32 vert_seq_no:#
///  gen_utime:uint32 gen_lt:uint64
///  min_ref_mc_seqno:uint32
///  out_msg_queue_info:^OutMsgQueueInfo
///  before_split:(## 1)
///  accounts:^ShardAccounts
///  ^[ overload_history:uint64 underload_history:uint64
///  total_balance:CurrencyCollection
///  total_validator_fees:CurrencyCollection
///  libraries:(HashmapE 256 LibDescr)
///  master_ref:(Maybe BlkMasterInfo) ]
///  custom:(Maybe ^McStateExtra)
///  = ShardStateUnsplit;
class ShardStateUnsplit extends TonSerialization {
  final int globalId;
  final ShardIdent shardId;
  final int seqno;
  final int vertSeqNo;
  final int genUtime;
  final BigInt genLt;
  final int minRefMcSeqno;
  final bool beforeSplit;
  final ShardAccounts? accounts;
  final MasterchainStateExtra? extras;
  ShardStateUnsplit(
      {required this.globalId,
      required this.shardId,
      required this.seqno,
      required this.vertSeqNo,
      required this.genUtime,
      required this.genLt,
      required this.minRefMcSeqno,
      required this.beforeSplit,
      this.accounts,
      this.extras});
  factory ShardStateUnsplit.deserialize(Slice slice) {
    if (slice.loadUint(32) != _ShardStateUnsplitConst.magic) {
      throw const TonDartPluginException(
          "Invalid ShardStateUnsplit slice data.");
    }
    final globalId = slice.loadInt(32);
    final shardId = ShardIdent.deserialize(slice);
    final seqno = slice.loadUint(32);
    final vertSeqNo = slice.loadUint(32);
    final genUtime = slice.loadUint(32);
    final genLt = slice.loadUintBig(64);
    final minRefMcSeqno = slice.loadUint(32);

    /// Skip OutMsgQueueInfo: usually exotic
    slice.loadRef();

    final beforeSplit = slice.loadBit();

    /// Parse accounts
    final shardAccountsRef = slice.loadRef();
    ShardAccounts? accounts;
    if (!shardAccountsRef.isExotic) {
      accounts = ShardAccounts.deserialize(shardAccountsRef.beginParse());
    }

    /// Skip (not used by apps)
    slice.loadRef();

    /// Parse extras
    final mcStateExtra = slice.loadBit();
    MasterchainStateExtra? extras;
    if (mcStateExtra) {
      final cell = slice.loadRef();
      if (!cell.isExotic) {
        extras = MasterchainStateExtra.deserialize(cell.beginParse());
      }
    }
    return ShardStateUnsplit(
        globalId: globalId,
        shardId: shardId,
        seqno: seqno,
        vertSeqNo: vertSeqNo,
        genUtime: genUtime,
        genLt: genLt,
        minRefMcSeqno: minRefMcSeqno,
        beforeSplit: beforeSplit,
        accounts: accounts,
        extras: extras);
  }
  factory ShardStateUnsplit.fromJson(Map<String, dynamic> json) {
    return ShardStateUnsplit(
        globalId: json["global_id"],
        shardId: ShardIdent.fromJson(json["shard_id"]),
        seqno: json["seqno"],
        vertSeqNo: json["vert_seq_no"],
        genUtime: json["gen_utime"],
        genLt: BigintUtils.parse(json["gen_lt"]),
        minRefMcSeqno: json["min_ref_mc_seqno"],
        beforeSplit: json["before_split"],
        accounts: ((json["accounts"] as Object?)?.convertTo<ShardAccounts, Map>(
            (result) => ShardAccounts.fromJson(result.cast()))),
        extras: (json["extras"] as Object?)
            ?.convertTo<MasterchainStateExtra, Map>(
                (result) => MasterchainStateExtra.fromJson(result.cast())));
  }

  @override
  void store(Builder builder) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "global_id": globalId,
      "shard_id": shardId.toJson(),
      "seqno": seqno,
      "vert_seq_no": vertSeqNo,
      "gen_utime": genUtime,
      "gen_lt": genLt.toString(),
      "min_ref_mc_seqno": minRefMcSeqno,
      "before_split": beforeSplit,
      "accounts": accounts?.toJson(),
      "extras": extras?.toJson()
    };
  }
}
