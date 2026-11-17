import 'package:blockchain_utils/chain/types/network.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import '../utils.dart';
import 'package:ton_dart/src/provider/generated/tonapi/tonapi_requests.dart'
    as tonapi;
import 'package:ton_dart/src/provider/generated/toncenter/toncenter_models.dart'
    as toncenter_models;
import 'package:ton_dart/src/provider/generated/toncenter/toncenter_requests.dart'
    as toncenter;
import 'package:ton_dart/src/provider/generated/toncenter_v3/toncenter_v3_requests.dart'
    as toncenter_v3;

void encodableRequestParamsTest() {
  void expectRoundTrip(TonRequestDetails request) {
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
  }

  test('encodable provider params (tonapi GET)', () {
    final param = tonapi.TonApiGetBlockchainRawAccount(accountId: 'account!');
    expectRoundTrip(param.buildRequest(0));
  });

  test('encodable provider params (toncenter v2 POST)', () {
    final param = toncenter.TonCenterGetBlockTransactionsPost(
      workchain: toncenter_models.AddressWithSeqnoRequestSeqnoInteger(1),
      shard: BigInt.from(200),
      seqno: toncenter_models.AddressWithSeqnoRequestSeqnoInteger(3),
      afterHash: '0x',
      afterLt: BigInt.one,
      count: BigInt.from(2),
    );
    expectRoundTrip(param.buildRequest(0));
  });

  test('encodable provider params (toncenter v3 GET)', () {
    final param = toncenter_v3.TonCenterV3GetTraces(
      account: '',
      traceId: 'id',
      limit: '2',
      offset: '1',
      sort: 'ASC',
    );
    expectRoundTrip(param.buildRequest(0));
  });
}

void main() {
  TonTestApi.runTest(encodableRequestParamsTest, 'Encodable Request Params');
}
