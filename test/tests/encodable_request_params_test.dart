import 'package:blockchain_utils/networks/types/network.dart';
import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  test('encodable provider params', () {
    final param = TonApiBlockchainAccountInspect("account!");
    final request = param.buildRequest(0);
    final deserialize = TonRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.path, request.path);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.ton);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.api, request.api);
  });

  test('encodable provider params', () {
    final param = TonCenterGetBlockTransactions(
      workchain: 1,
      shard: 200,
      seqno: 3,
      afterHash: "0x",
      afterLt: 1,
      count: 2,
    );
    final request = param.buildRequest(0);
    final deserialize = TonRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.path, request.path);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.ton);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.api, request.api);
  });
  test('encodable provider params', () {
    final param = TonCenterV3Traces(
      account: "",
      endLt: 1,
      endUtime: 2,
      includeActions: false,
      limit: 2,
      mcSeqno: 1,
      msgHash: ["s"],
      offset: 1,
      sort: 'ASC',
      startLt: 1,
      startUtime: 2,
      supportActionType: ["actions1", "actions2"],
      traceId: [],
    );
    final request = param.buildRequest(0);
    final deserialize = TonRequestDetails.deserialize(
      bytes: request.toCbor().encode(),
    );
    expect(deserialize.path, request.path);
    expect(deserialize.encodeBody(), request.encodeBody());
    expect(deserialize.successStatusCodes, request.successStatusCodes);
    expect(deserialize.errorStatusCodes, request.errorStatusCodes);
    expect(deserialize.network, BlockchainNetwork.ton);
    expect(deserialize.responseEncoding, request.responseEncoding);
    expect(deserialize.requestMethod, request.requestMethod);
    expect(deserialize.api, request.api);
  });
}
