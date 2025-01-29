import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/get_out_msg_queue_sizes.dart';

/// GetOutMsgQueueSizes invokes getOutMsgQueueSizes operation.
///
/// Get out msg queue sizes.
///
class TonApiGetOutMsgQueueSizes
    extends TonApiRequest<OutMsgQueueSizesResponse, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.getoutmsgqueuesizes.url;

  @override
  OutMsgQueueSizesResponse onResonse(Map<String, dynamic> result) {
    return OutMsgQueueSizesResponse.fromJson(result);
  }
}
