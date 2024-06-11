import 'package:ton_dart/src/serialization/serialization.dart';
import 'inscription_balance.dart';

class InscriptionBalancesResponse with JsonSerialization {
  final List<InscriptionBalanceResponse> inscriptions;

  const InscriptionBalancesResponse({required this.inscriptions});

  factory InscriptionBalancesResponse.fromJson(Map<String, dynamic> json) {
    return InscriptionBalancesResponse(
        inscriptions: List<InscriptionBalanceResponse>.from(
            (json['inscriptions'] as List)
                .map((x) => InscriptionBalanceResponse.fromJson(x))));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'inscriptions':
          inscriptions.map((inscription) => inscription.toJson()).toList(),
    };
  }
}
