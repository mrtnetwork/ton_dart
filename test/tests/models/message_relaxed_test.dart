import 'package:test/test.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/common_message_info_relaxed.dart';
import 'package:ton_dart/src/models/models/message_relaxed.dart';

void main() {
  group('Message Relaxed', () => _test());
}

void _test() {
  test('should parse message relaxed', () {
    const state =
        'te6ccsEBAgEAkQA3kQFoYgBgSQkXjXbkhpC1sju4zUJsLIAoavunKbfNsPFbk9jXL6BfXhAAAAAAAAAAAAAAAAAAAQEAsA+KfqUAAAAAAAAAAEO5rKAIAboVCXedy2J0RCseg4yfdNFtU8/BfiaHVEPkH/ze1W+fABicYUqh1j9Lnqv9ZhECm0XNPaB7/HcwoBb3AJnYYfqByAvrwgCqR2XE';
    final cell = Cell.fromBase64(state);
    final relaxed = MessageRelaxed.deserialize(cell.beginParse());
    final stored = beginCell();
    relaxed.store(stored);
    expect(stored.endCell(), cell);
    expect(relaxed.body.toBase64(),
        'te6cckEBAQEAWgAAsA+KfqUAAAAAAAAAAEO5rKAIAboVCXedy2J0RCseg4yfdNFtU8/BfiaHVEPkH/ze1W+fABicYUqh1j9Lnqv9ZhECm0XNPaB7/HcwoBb3AJnYYfqByAvrwgBtBtvs');
  });

  test('should store exotic message relaxed', () {
    const boc =
        'te6cckEBBgEApwAJRgMNtncFfUUJSR6XK02Y/bjHpB1pj8VtOlnKAxgDtajfKgACASIFgZABAwIoSAEBN4Yioo+yQnBEkgpN5SV1lnSGuoJhL3ShCi0dcMHbuFcAACIBIAUEAE2/fOtFTZyY8zlmFJ8dch//XZQ4QApiXOGPZXvjFv5j0LSgZ7ckWPAoSAEBr+h0Em3TbCgl+CpPMKKoQskNFu4vLU/8w4Zuaz7PRP8AAOG0rdg=';
    final message = MessageRelaxed(
        info: CommonMessageInfoRelaxedExternalOut(
            createdLt: BigInt.zero, createdAt: 0),
        body: Cell.fromBase64(boc));
    final payload = beginCell();
    message.store(payload);
    payload.endCell();
  });
}
