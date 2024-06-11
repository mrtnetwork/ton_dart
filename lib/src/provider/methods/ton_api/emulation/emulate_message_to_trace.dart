import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// EmulateMessageToTrace invokes emulateMessageToTrace operation.
///
/// Emulate sending message to blockchain.
///
class TonApiEmulateMessageToTrace
    extends TonApiPostRequestParam<dynamic, Map<String, dynamic>> {
  @override
  Object get body => throw UnimplementedError();

  @override
  String get method => TonApiMethods.emulatemessagetotrace.url;

  @override
  List<String> get pathParameters => [];
}
