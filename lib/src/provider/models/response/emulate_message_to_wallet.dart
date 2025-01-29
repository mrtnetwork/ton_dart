import 'package:ton_dart/src/serialization/serialization.dart';

class EmulateMessageToWalletReqParamsItemResponse with JsonSerialization {
  final String address;
  final int? balance;
  const EmulateMessageToWalletReqParamsItemResponse(
      {required this.address, this.balance});

  @override
  Map<String, dynamic> toJson() {
    return {'address': address, 'balance': balance};
  }
}

class EmulateMessageToWalletReqResponse with JsonSerialization {
  final String boc;
  final List<EmulateMessageToWalletReqParamsItemResponse> params;
  const EmulateMessageToWalletReqResponse(
      {required this.boc, required this.params});
  @override
  Map<String, dynamic> toJson() {
    return {'boc': boc, 'params': params.map((e) => e.toJson()).toList()};
  }
}
