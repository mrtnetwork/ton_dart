import 'package:blockchain_utils/exception/exceptions.dart';

class TonDartPluginException extends BlockchainUtilsException {
  @override
  final String message;
  final Map<String, dynamic>? details;
  TonDartPluginException(this.message, {this.details});

  @override
  String toString() {
    final infos = Map<String, dynamic>.fromEntries(
        details?.entries.where((element) => element.value != null) ?? []);
    if (infos.isEmpty) return "$runtimeType($message)";
    final String msg =
        "$message ${infos.entries.map((e) => "${e.key}: ${e.value}").join(", ")}";
    return "$runtimeType($msg)";
  }
}
