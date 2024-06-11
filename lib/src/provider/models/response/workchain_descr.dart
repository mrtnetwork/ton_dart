import 'package:blockchain_utils/blockchain_utils.dart';

class WorkchainDescr {
  final int workchain;
  final BigInt enabledSince;
  final int actualMinSplit;
  final int minSplit;
  final int maxSplit;
  final int basic;
  final bool active;
  final bool acceptMsgs;
  final int flags;
  final String zerostateRootHash;
  final String zerostateFileHash;
  final BigInt version;

  const WorkchainDescr({
    required this.workchain,
    required this.enabledSince,
    required this.actualMinSplit,
    required this.minSplit,
    required this.maxSplit,
    required this.basic,
    required this.active,
    required this.acceptMsgs,
    required this.flags,
    required this.zerostateRootHash,
    required this.zerostateFileHash,
    required this.version,
  });

  factory WorkchainDescr.fromJson(Map<String, dynamic> json) {
    return WorkchainDescr(
      workchain: json['workchain'],
      enabledSince: BigintUtils.parse(json['enabled_since']),
      actualMinSplit: json['actual_min_split'],
      minSplit: json['min_split'],
      maxSplit: json['max_split'],
      basic: json['basic'],
      active: json['active'],
      acceptMsgs: json['accept_msgs'],
      flags: json['flags'],
      zerostateRootHash: json['zerostate_root_hash'],
      zerostateFileHash: json['zerostate_file_hash'],
      version: BigintUtils.parse(json['version']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workchain': workchain,
      'enabled_since': enabledSince.toString(),
      'actual_min_split': actualMinSplit,
      'min_split': minSplit,
      'max_split': maxSplit,
      'basic': basic,
      'active': active,
      'accept_msgs': acceptMsgs,
      'flags': flags,
      'zerostate_root_hash': zerostateRootHash,
      'zerostate_file_hash': zerostateFileHash,
      'version': version.toString(),
    };
  }
}
