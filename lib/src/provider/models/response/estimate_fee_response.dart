import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class EstimateFeeResponse with JsonSerialization {
  final EstimateFeeSourceFeesResponse sourceFees;
  final List<EstimateFeeSourceFeesResponse> destinationFees;
  const EstimateFeeResponse(
      {required this.sourceFees, required this.destinationFees});
  factory EstimateFeeResponse.fromJson(Map<String, dynamic> json) {
    return EstimateFeeResponse(
        sourceFees: EstimateFeeSourceFeesResponse.fromJson(json['source_fees']),
        destinationFees: List.from(json['destination_fees'] ?? [])
            .map((e) => EstimateFeeSourceFeesResponse.fromJson(e))
            .toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'source_fees': sourceFees.toJson(),
      'destination_fees': destinationFees.map((e) => e.toJson()).toList()
    };
  }

  BigInt get totalFee =>
      sourceFees.fwdFee +
      sourceFees.gasFee +
      sourceFees.inFwdFee +
      sourceFees.storageFee;
}

class EstimateFeeSourceFeesResponse with JsonSerialization {
  final BigInt inFwdFee;
  final BigInt storageFee;
  final BigInt gasFee;
  final BigInt fwdFee;

  const EstimateFeeSourceFeesResponse(
      {required this.inFwdFee,
      required this.storageFee,
      required this.gasFee,
      required this.fwdFee});
  factory EstimateFeeSourceFeesResponse.fromJson(Map<String, dynamic> json) {
    return EstimateFeeSourceFeesResponse(
      inFwdFee: BigintUtils.parse(json['in_fwd_fee']),
      storageFee: BigintUtils.parse(json['storage_fee']),
      gasFee: BigintUtils.parse(json['gas_fee']),
      fwdFee: BigintUtils.parse(json['fwd_fee']),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'in_fwd_fee': inFwdFee.toString(),
      'storage_fee': storageFee.toString(),
      'gas_fee': gasFee.toString(),
      'fwd_fee': fwdFee.toString()
    };
  }
}
