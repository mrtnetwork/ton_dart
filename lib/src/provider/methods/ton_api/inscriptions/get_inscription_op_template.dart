import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/get_inscription_op_template.dart';

/// GetInscriptionOpTemplate invokes getInscriptionOpTemplate operation.
///
/// Return comment for making operation with inscription. please don't use it if you don't know what
/// you are doing.
///
class TonApiGetInscriptionOpTemplate extends TonApiRequest<
    GetInscriptionOpTemplateResponse, Map<String, dynamic>> {
  /// Available values : ton20, gram20
  final String type;
  final String? destination;
  final String? comment;

  /// Available values : transfer
  final String operation;
  final String amount;

  /// nano
  final String ticker;

  /// UQAs87W4yJHlF8mt29ocA4agnMrLsOP69jC1HPyBUjJay7Mg
  final String who;
  TonApiGetInscriptionOpTemplate(
      {required this.type,
      this.destination,
      this.comment,
      required this.operation,
      required this.amount,
      required this.ticker,
      required this.who});
  @override
  String get method => TonApiMethods.getinscriptionoptemplate.url;

  @override
  List<String> get pathParameters => [];

  @override
  Map<String, dynamic> get queryParameters => {
        'type': type,
        'destination': destination,
        'comment': comment,
        'operation': operation,
        'amount': amount,
        'ticker': ticker,
        'who': who
      };
  @override
  GetInscriptionOpTemplateResponse onResonse(Map<String, dynamic> result) {
    return GetInscriptionOpTemplateResponse.fromJson(result);
  }
}
