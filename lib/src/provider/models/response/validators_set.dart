import 'package:ton_dart/src/serialization/serialization.dart';
import 'validators_set_list_item.dart';

class ValidatorsSetResponse with JsonSerialization {
  final int utimeSince;
  final int utimeUntil;
  final int total;
  final int main;
  final String? totalWeight;
  final List<ValidatorsSetListItemResponse> list;

  const ValidatorsSetResponse(
      {required this.utimeSince,
      required this.utimeUntil,
      required this.total,
      required this.main,
      this.totalWeight,
      required this.list});

  factory ValidatorsSetResponse.fromJson(Map<String, dynamic> json) {
    return ValidatorsSetResponse(
      utimeSince: json['utime_since'],
      utimeUntil: json['utime_until'],
      total: json['total'],
      main: json['main'],
      totalWeight: json['total_weight'],
      list: List<ValidatorsSetListItemResponse>.from((json['list'] as List)
          .map((item) => ValidatorsSetListItemResponse.fromJson(item))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'utime_since': utimeSince,
      'utime_until': utimeUntil,
      'total': total,
      'main': main,
      'total_weight': totalWeight,
      'list': list.map((item) => item.toJson()).toList(),
    };
  }
}
