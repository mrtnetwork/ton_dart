import 'package:blockchain_utils/blockchain_utils.dart';

class TonApiError extends RPCError {
  const TonApiError(String message,
      {Map<String, dynamic> request = const {}, int? code})
      : super(message: message, errorCode: code, request: request);
}
