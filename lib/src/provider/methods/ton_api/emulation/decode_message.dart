import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/decoded_message.dart';

/// DecodeMessage invokes decodeMessage operation.
///
/// Decode a given message. Only external incoming messages can be decoded currently.
///
class TonApiDecodeMessage extends TonApiPostRequestParam<DecodedMessageResponse,
    Map<String, dynamic>> {
  final String boc;
  TonApiDecodeMessage(this.boc);
  @override
  Object get body => {"boc": boc};

  @override
  String get method => TonApiMethods.decodemessage.url;

  @override
  List<String> get pathParameters => [];
  @override
  DecodedMessageResponse onResonse(Map<String, dynamic> json) {
    return DecodedMessageResponse.fromJson(json);
  }
}
