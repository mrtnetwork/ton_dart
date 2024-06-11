import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class MisbehaviourPunishmentConfigResponse with JsonSerialization {
  final BigInt defaultFlatFine;
  final BigInt defaultProportionalFine;
  final int severityFlatMult;
  final int severityProportionalMult;
  final int unpunishableInterval;
  final int longInterval;
  final int longFlatMult;
  final int longProportionalMult;
  final int mediumInterval;
  final int mediumFlatMult;
  final int mediumProportionalMult;

  const MisbehaviourPunishmentConfigResponse({
    required this.defaultFlatFine,
    required this.defaultProportionalFine,
    required this.severityFlatMult,
    required this.severityProportionalMult,
    required this.unpunishableInterval,
    required this.longInterval,
    required this.longFlatMult,
    required this.longProportionalMult,
    required this.mediumInterval,
    required this.mediumFlatMult,
    required this.mediumProportionalMult,
  });

  factory MisbehaviourPunishmentConfigResponse.fromJson(
      Map<String, dynamic> json) {
    return MisbehaviourPunishmentConfigResponse(
      defaultFlatFine: BigintUtils.parse(json['default_flat_fine']),
      defaultProportionalFine:
          BigintUtils.parse(json['default_proportional_fine']),
      severityFlatMult: json['severity_flat_mult'],
      severityProportionalMult: json['severity_proportional_mult'],
      unpunishableInterval: json['unpunishable_interval'],
      longInterval: json['long_interval'],
      longFlatMult: json['long_flat_mult'],
      longProportionalMult: json['long_proportional_mult'],
      mediumInterval: json['medium_interval'],
      mediumFlatMult: json['medium_flat_mult'],
      mediumProportionalMult: json['medium_proportional_mult'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'default_flat_fine': defaultFlatFine.toString(),
      'default_proportional_fine': defaultProportionalFine.toString(),
      'severity_flat_mult': severityFlatMult,
      'severity_proportional_mult': severityProportionalMult,
      'unpunishable_interval': unpunishableInterval,
      'long_interval': longInterval,
      'long_flat_mult': longFlatMult,
      'long_proportional_mult': longProportionalMult,
      'medium_interval': mediumInterval,
      'medium_flat_mult': mediumFlatMult,
      'medium_proportional_mult': mediumProportionalMult
    };
  }
}
