import 'package:ton_dart/src/exception/exception.dart';

class TransactionTypeResponse {
  final String _value;

  const TransactionTypeResponse._(this._value);

  static const TransactionTypeResponse transOrd =
      TransactionTypeResponse._('TransOrd');
  static const TransactionTypeResponse transTickTock =
      TransactionTypeResponse._('TransTickTock');
  static const TransactionTypeResponse transSplitPrepare =
      TransactionTypeResponse._('TransSplitPrepare');
  static const TransactionTypeResponse transSplitInstall =
      TransactionTypeResponse._('TransSplitInstall');
  static const TransactionTypeResponse transMergePrepare =
      TransactionTypeResponse._('TransMergePrepare');
  static const TransactionTypeResponse transMergeInstall =
      TransactionTypeResponse._('TransMergeInstall');
  static const TransactionTypeResponse transStorage =
      TransactionTypeResponse._('TransStorage');

  static const List<TransactionTypeResponse> values = [
    transOrd,
    transTickTock,
    transSplitPrepare,
    transSplitInstall,
    transMergePrepare,
    transMergeInstall,
    transStorage,
  ];

  String get value => _value;

  static TransactionTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw TonDartPluginException(
          'No TransactionTypeResponse find with provided name.',
          details: {'name': name}),
    );
  }
}
