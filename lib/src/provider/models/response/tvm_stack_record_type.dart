import 'package:ton_dart/src/exception/exception.dart';

class TvmStackRecordTypeResponse {
  final String _value;

  const TvmStackRecordTypeResponse._(this._value);

  static const TvmStackRecordTypeResponse cell =
      TvmStackRecordTypeResponse._('cell');
  static const TvmStackRecordTypeResponse num =
      TvmStackRecordTypeResponse._('num');
  static const TvmStackRecordTypeResponse nan =
      TvmStackRecordTypeResponse._('nan');
  static const TvmStackRecordTypeResponse nullType =
      TvmStackRecordTypeResponse._('null');
  static const TvmStackRecordTypeResponse tuple =
      TvmStackRecordTypeResponse._('tuple');

  static const List<TvmStackRecordTypeResponse> values = [
    cell,
    num,
    nan,
    nullType,
    tuple,
  ];

  String get value => _value;

  static TvmStackRecordTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element._value == name,
      orElse: () => throw TonDartPluginException(
          'No TvmStackRecordTypeResponse found with the provided name: $name'),
    );
  }
}
