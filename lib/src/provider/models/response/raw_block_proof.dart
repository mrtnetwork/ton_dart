import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'block_raw.dart';

class RawBlockProofResponse with JsonSerialization {
  final bool complete;
  final BlockRawResponse from;
  final BlockRawResponse to;
  final List<RawBlockProofStepsItemResponse> steps;

  const RawBlockProofResponse({
    required this.complete,
    required this.from,
    required this.to,
    required this.steps,
  });

  factory RawBlockProofResponse.fromJson(Map<String, dynamic> json) {
    return RawBlockProofResponse(
      complete: json['complete'],
      from: BlockRawResponse.fromJson(json['from']),
      to: BlockRawResponse.fromJson(json['to']),
      steps: (json['steps'] as List<dynamic>)
          .map((item) => RawBlockProofStepsItemResponse.fromJson(item))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'complete': complete,
        'from': from.toJson(),
        'to': to.toJson(),
        'steps': steps.map((item) => item.toJson()).toList(),
      };
}

class RawBlockProofStepsItemResponse with JsonSerialization {
  final RawBlockProofStepsItemLiteServerBlockLinkBackResponse
      liteServerBlockLinkBack;
  final RawBlockProofStepsItemLiteServerBlockLinkForwardResponse
      liteServerBlockLinkForward;

  const RawBlockProofStepsItemResponse({
    required this.liteServerBlockLinkBack,
    required this.liteServerBlockLinkForward,
  });

  factory RawBlockProofStepsItemResponse.fromJson(Map<String, dynamic> json) {
    return RawBlockProofStepsItemResponse(
        liteServerBlockLinkBack:
            RawBlockProofStepsItemLiteServerBlockLinkBackResponse.fromJson(
                json["lite_server_block_link_back"]),
        liteServerBlockLinkForward:
            RawBlockProofStepsItemLiteServerBlockLinkForwardResponse.fromJson(
                json["lite_server_block_link_forward"]));
  }

  @override
  Map<String, dynamic> toJson() => {
        'lite_server_block_link_back': liteServerBlockLinkBack.toJson(),
        'lite_server_block_link_forward': liteServerBlockLinkForward.toJson(),
      };
}

class RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItemResponse
    with JsonSerialization {
  final String nodeIDShort;
  final String signature;

  const RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItemResponse({
    required this.nodeIDShort,
    required this.signature,
  });

  factory RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItemResponse.fromJson(
      Map<String, dynamic> json) {
    return RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItemResponse(
      nodeIDShort: json['node_id_short'],
      signature: json['signature'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'node_id_short': nodeIDShort,
        'signature': signature,
      };
}

class RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesResponse
    with JsonSerialization {
  final BigInt validatorSetHash;
  final int catchainSeqno;
  final List<
          RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItemResponse>
      signatures;

  const RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesResponse({
    required this.validatorSetHash,
    required this.catchainSeqno,
    required this.signatures,
  });

  factory RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesResponse.fromJson(
      Map<String, dynamic> json) {
    return RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesResponse(
      validatorSetHash: BigintUtils.parse(json['validator_set_hash']),
      catchainSeqno: json['catchain_seqno'],
      signatures: (json['signatures'] as List<dynamic>)
          .map((item) =>
              RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItemResponse
                  .fromJson(item))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'validator_set_hash': validatorSetHash.toString(),
        'catchain_seqno': catchainSeqno,
        'signatures': signatures.map((item) => item.toJson()).toList(),
      };
}

class RawBlockProofStepsItemLiteServerBlockLinkBackResponse
    with JsonSerialization {
  final bool toKeyBlock;
  final BlockRawResponse from;
  final BlockRawResponse to;
  final String destProof;
  final String proof;
  final String stateProof;

  const RawBlockProofStepsItemLiteServerBlockLinkBackResponse({
    required this.toKeyBlock,
    required this.from,
    required this.to,
    required this.destProof,
    required this.proof,
    required this.stateProof,
  });

  factory RawBlockProofStepsItemLiteServerBlockLinkBackResponse.fromJson(
      Map<String, dynamic> json) {
    return RawBlockProofStepsItemLiteServerBlockLinkBackResponse(
      toKeyBlock: json['to_key_block'],
      from: BlockRawResponse.fromJson(json['from']),
      to: BlockRawResponse.fromJson(json['to']),
      destProof: json['dest_proof'],
      proof: json['proof'],
      stateProof: json['state_proof'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'to_key_block': toKeyBlock,
        'from': from.toJson(),
        'to': to.toJson(),
        'dest_proof': destProof,
        'proof': proof,
        'state_proof': stateProof,
      };
}

class RawBlockProofStepsItemLiteServerBlockLinkForwardResponse
    with JsonSerialization {
  final bool toKeyBlock;
  final BlockRawResponse from;
  final BlockRawResponse to;
  final String destProof;
  final String configProof;
  final RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesResponse
      signatures;

  const RawBlockProofStepsItemLiteServerBlockLinkForwardResponse({
    required this.toKeyBlock,
    required this.from,
    required this.to,
    required this.destProof,
    required this.configProof,
    required this.signatures,
  });

  factory RawBlockProofStepsItemLiteServerBlockLinkForwardResponse.fromJson(
      Map<String, dynamic> json) {
    return RawBlockProofStepsItemLiteServerBlockLinkForwardResponse(
      toKeyBlock: json['to_key_block'],
      from: BlockRawResponse.fromJson(json['from']),
      to: BlockRawResponse.fromJson(json['to']),
      destProof: json['dest_proof'],
      configProof: json['config_proof'],
      signatures:
          RawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesResponse
              .fromJson(json['signatures']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'to_key_block': toKeyBlock,
        'from': from.toJson(),
        'to': to.toJson(),
        'dest_proof': destProof,
        'config_proof': configProof,
        'signatures': signatures.toJson(),
      };
}
