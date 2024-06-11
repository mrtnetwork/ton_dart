import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'block_value_flow.dart';

class BlockchainBlockResponse with JsonSerialization {
  final int txQuantity;
  final BlockValueFlowResponse valueFlow;
  final int workchainId;
  final String shard;
  final int seqno;
  final String rootHash;
  final String fileHash;
  final int globalId;
  final int version;
  final bool afterMerge;
  final bool beforeSplit;
  final bool afterSplit;
  final bool wantSplit;
  final bool wantMerge;
  final bool keyBlock;
  final BigInt genUtime;
  final BigInt startLt;
  final BigInt endLt;
  final int vertSeqno;
  final int genCatchainSeqno;
  final int minRefMcSeqno;
  final int prevKeyBlockSeqno;
  final int? genSoftwareVersion;
  final BigInt? genSoftwareCapabilities;
  final String? masterRef;
  final List<String> prevRefs;
  final BigInt inMsgDescrLength;
  final BigInt outMsgDescrLength;
  final String randSeed;
  final String createdBy;

  const BlockchainBlockResponse({
    required this.txQuantity,
    required this.valueFlow,
    required this.workchainId,
    required this.shard,
    required this.seqno,
    required this.rootHash,
    required this.fileHash,
    required this.globalId,
    required this.version,
    required this.afterMerge,
    required this.beforeSplit,
    required this.afterSplit,
    required this.wantSplit,
    required this.wantMerge,
    required this.keyBlock,
    required this.genUtime,
    required this.startLt,
    required this.endLt,
    required this.vertSeqno,
    required this.genCatchainSeqno,
    required this.minRefMcSeqno,
    required this.prevKeyBlockSeqno,
    this.genSoftwareVersion,
    this.genSoftwareCapabilities,
    this.masterRef,
    required this.prevRefs,
    required this.inMsgDescrLength,
    required this.outMsgDescrLength,
    required this.randSeed,
    required this.createdBy,
  });

  factory BlockchainBlockResponse.fromJson(Map<String, dynamic> json) {
    return BlockchainBlockResponse(
      txQuantity: json['tx_quantity'],
      valueFlow: BlockValueFlowResponse.fromJson(json['value_flow']),
      workchainId: json['workchain_id'],
      shard: json['shard'],
      seqno: json['seqno'],
      rootHash: json['root_hash'],
      fileHash: json['file_hash'],
      globalId: json['global_id'],
      version: json['version'],
      afterMerge: json['after_merge'],
      beforeSplit: json['before_split'],
      afterSplit: json['after_split'],
      wantSplit: json['want_split'],
      wantMerge: json['want_merge'],
      keyBlock: json['key_block'],
      genUtime: BigintUtils.parse(json['gen_utime']),
      startLt: BigintUtils.parse(json['start_lt']),
      endLt: BigintUtils.parse(json['end_lt']),
      vertSeqno: json['vert_seqno'],
      genCatchainSeqno: json['gen_catchain_seqno'],
      minRefMcSeqno: json['min_ref_mc_seqno'],
      prevKeyBlockSeqno: json['prev_key_block_seqno'],
      genSoftwareVersion: json['gen_software_version'],
      genSoftwareCapabilities:
          BigintUtils.tryParse(json['gen_software_capabilities']),
      masterRef: json['master_ref'],
      prevRefs: List<String>.from(json['prev_refs']),
      inMsgDescrLength: BigintUtils.parse(json['in_msg_descr_length']),
      outMsgDescrLength: BigintUtils.parse(json['out_msg_descr_length']),
      randSeed: json['rand_seed'],
      createdBy: json['created_by'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'tx_quantity': txQuantity,
      'value_flow': valueFlow.toJson(),
      'workchain_id': workchainId,
      'shard': shard,
      'seqno': seqno,
      'root_hash': rootHash,
      'file_hash': fileHash,
      'global_id': globalId,
      'version': version,
      'after_merge': afterMerge,
      'before_split': beforeSplit,
      'after_split': afterSplit,
      'want_split': wantSplit,
      'want_merge': wantMerge,
      'key_block': keyBlock,
      'gen_utime': genUtime.toString(),
      'start_lt': startLt.toString(),
      'end_lt': endLt.toString(),
      'vert_seqno': vertSeqno,
      'gen_catchain_seqno': genCatchainSeqno,
      'min_ref_mc_seqno': minRefMcSeqno,
      'prev_key_block_seqno': prevKeyBlockSeqno,
      'gen_software_version': genSoftwareVersion,
      'gen_software_capabilities': genSoftwareCapabilities?.toString(),
      'master_ref': masterRef,
      'prev_refs': prevRefs,
      'in_msg_descr_length': inMsgDescrLength.toString(),
      'out_msg_descr_length': outMsgDescrLength.toString(),
      'rand_seed': randSeed,
      'created_by': createdBy,
    };
  }
}
