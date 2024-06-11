import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/method_execution_result.dart';

/// ExecGetMethodForBlockchainAccount invokes execGetMethodForBlockchainAccount operation.
///
/// Execute get method for account.
///
class TonApiExecGetMethodForBlockchainAccount extends TonApiRequestParam<
    MethodExecutionResultResponse, Map<String, dynamic>> {
  final String accountId;
  final String methodName;
  final List<String> args;
  TonApiExecGetMethodForBlockchainAccount(
      {required this.accountId,
      required this.methodName,
      this.args = const []});
  @override
  String get method => TonApiMethods.execgetmethodforblockchainaccount.url;

  @override
  List<String> get pathParameters => [accountId, methodName];

  @override
  Map<String, dynamic> get queryParameters =>
      {"args": args.isEmpty ? null : args.toString()};

  @override
  MethodExecutionResultResponse onResonse(Map<String, dynamic> json) {
    return MethodExecutionResultResponse.fromJson(json);
  }
}
