import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'block_raw.dart';
import 'init_state_raw.dart';

class RawMasterchainInfoExtResponse with JsonSerialization {
  final int mode;
  final int version;
  final BigInt capabilities;
  final BlockRawResponse last;
  final int lastUtime;
  final int now;
  final String stateRootHash;
  final InitStateRawResponse init;
  const RawMasterchainInfoExtResponse({
    required this.mode,
    required this.version,
    required this.capabilities,
    required this.last,
    required this.lastUtime,
    required this.now,
    required this.stateRootHash,
    required this.init,
  });
  factory RawMasterchainInfoExtResponse.fromJson(Map<String, dynamic> json) {
    return RawMasterchainInfoExtResponse(
      mode: json['mode'],
      version: json['version'],
      now: json['now'],
      capabilities: BigintUtils.parse(json['capabilities']),
      lastUtime: json['last_utime'],
      last: BlockRawResponse.fromJson(json['last']),
      stateRootHash: json['state_root_hash'],
      init: InitStateRawResponse.fromJson(json['init']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'last_utime': lastUtime,
      'capabilities': capabilities.toString(),
      'now': now,
      'mode': mode,
      'last': last.toJson(),
      'state_root_hash': stateRootHash,
      'init': init.toJson()
    };
  }
}
