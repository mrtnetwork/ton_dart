import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_raw.dart';
import 'init_state_raw.dart';

class RawMasterchainInfoResponse with JsonSerialization {
  final BlockRawResponse last;
  final String stateRootHash;
  final InitStateRawResponse init;
  const RawMasterchainInfoResponse({
    required this.last,
    required this.stateRootHash,
    required this.init,
  });
  factory RawMasterchainInfoResponse.fromJson(Map<String, dynamic> json) {
    return RawMasterchainInfoResponse(
      last: BlockRawResponse.fromJson(json['last']),
      stateRootHash: json['state_root_hash'],
      init: InitStateRawResponse.fromJson(json['init']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'last': last.toJson(),
      'state_root_hash': stateRootHash,
      'init': init.toJson()
    };
  }
}
