import 'package:blockchain_utils/utils/utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/utils/utils.dart';
import 'dict_test.dart';

void main() {
  group('parse dict', () => _test());
}

void _test() {
  test('should parse the one from documentation', () {
    final root = storeBits(beginCell(), '11001000')
        .storeRef(storeBits(beginCell(), '011000')
            .storeRef(
                storeBits(beginCell(), '1010011010000000010101001').asCell())
            .storeRef(
                storeBits(beginCell(), '1010000010000000100100001').asCell())
            .asCell())
        .storeRef(
            storeBits(beginCell(), '1011111011111101111100100001').asCell())
        .endCell();

    final loaded =
        DictionaryUtils.parseDict(root.beginParse(), 16, (src) => src);

    expect(loaded[BigInt.from(13)]?.loadUint(16), 169);
    expect(loaded[BigInt.from(17)]?.loadUint(16), 289);
    expect(loaded[BigInt.from(239)]?.loadUint(16), 57121);
  });

  test('should parse with single node', () {
    final root = beginCell()
        .storeBuffer(BytesUtils.fromHexString(
            'a01f6e01b8f0a32c242ce41087ffee755406d9bcf9059a75e6b28d4af2a8250b73a8ee6b2800'))
        .endCell();
    final loaded =
        DictionaryUtils.parseDict(root.beginParse(), 256, (src) => src);
    final slice = loaded[BigInt.parse(
        '113728506967403912844988930199811170511118141411198189003219273357906839886749')];
    expect(slice?.toString(), 'x{4773594004_}');
    expect(BytesUtils.tryToHexString(slice?.asCell().hash()),
        'f358cf51c1a3f5d2dd9f09e46980ef204c12e4433c42073ef0f8d82d4531b25f');
  });

  test('should parse dict with exotics', () {
    final cs = Cell.fromBase64(
            'te6cckECMQEABTYAAhOCCc7v0txVpwSwAQIDEwEE53fpbirTglgEAwIISAEBs+lknRDMs3k2joGjp+jknI61P2rMabC6L/qACC9w7jkAAQhIAQGcUdBjRLK2XTGk56evuoGpCTwBOhaNJ3gUFm8TAe0n5QAyAxMBAye9rIc4cIC4MAYFCEgBAW8xXyW0o5rBLIX+pOz+eoPl5Z0fBZeD+gw+8nlzCIBhAAADEwEBQI3GZN/+jNgvBwgDEwEATAHi3hq0fjgKCQgISAEB7X4mvTbvptXZtPaqq5gTrwdCqEJEl390/UB0ycmJCL4AAAhIAQH6TA1tA7w5MqlUZE/iIYZlmhFY/0nMfG9YEH4IA4oG9AAmAxEA/JVwvbaVd7guDAsISAEB16y7YCM4yG1hDzXPs2L9dvwYsYEkdrb8qZoGeOZl/PUAAAIRAOC+0jznnr0oLQ0CEQDgeIc2I3nB6A8OCEgBAe5bbwbC8lILAkcW7BvTGqfH7ackw/xrJ+4xJ9g0lay7ACICDwDcWf0tZ7wILBACDwDPXe4GVoRIEhEISAEBpqnx4FY+VMV5fZOCgk11aYemGilh+4jfDQXGfVnuO2QAHwIPAMwQLzuW7ygrEwIPAMGD4CnDLugVFAhIAQHhkmjGsVW1E//8jS7VtFUP/nG+13eBz2DH8b6lkRkfowATAg8AwL3BnpH5iCoWAg8AwFv9OrsVqBgXCEgBAUnJQzkhkkoQxP70VqQNlWC2ClDLq6thxGgnH+VDOUIdABICDwDAI9NSaezIKRkCDQC0EKoS2YgbGghIAQEUW2BGLrIxcR0xUglz9exM5sN90zhfxgdRBW0FkjOQBQAPAg0ApaMONrGIHRwISAEB20MCSueWmfetSar0Li+5Q8Ip7t01JoPqgAJhVAvv4PEADAINAKFiMLr7SCgeAg0AoV/mfAxIJx8CDQCgRMc88eghIAhIAQHFrdac2QaoB3A0l38UmVSRNUC4pYwh2FyGJ5Vl+MyhJgAJAgkAbRF4aCYiAgkAZzzR6CQjCEgBAax1zsp9u3C3amDOdSJD9mQdDCqhiDj+ZgliaFHwLgWgAAIBj7rR38jjeSour5CAiFzP5jBGI24SWg7B0O37+3W43agB1e+xhmG5Sli1Zv3ZU7LzkGnD7l80gqgY14NkUTcQu0YAAC5TRp8sgyUISAEBnuyDAqn2pYKXQ/wsg9nT0mXlzYlz/XD92d92SJgRWv8AAQhIAQHEi2bfoY75oVrUbsi8DucSPG1oWEcd3KHUGYp0M+RQMQACCEgBAWJ+cuHH5x28R42OXHVN6a1Jf7VXJHmTxS88Gp/rZs2wAAIISAEBOz2DLgJl9RiydhyAtaSVoJad3MYUNnANbILzFnfSgEkADQhIAQHMnAtnlPhbBcz2DH0IRfSKuD1YfeBVgFaujjkW+iHqDgAPCEgBAVyyY7T30fyOwTmieJ8TthLedj5loRH+lxKqP5GbivrBABcISAEBuusLuLgfE7diC4/aes/bPk0SUgkgruJUU+h2pBoayZwAFwhIAQFmUFOfgo2uUi6cXR4FvV6TYWbPc7i/d5MmEQOA4FGbgQAbCEgBAV7HcGhkdhUswzXpHOx7WG6dvrqJjJdLMlC+kTQaJBqhACMISAEBG14jhyXXJ7RLRZCnKyrvsoR9OsBOvnfdOdK6ADqrS88AIQhIAQFZ+0nqF8AuEf14qz7cSjcXQjasTFC5jvk1aLELPzNMHAAnCEgBAdzBkxtJradUwhDmKe2fCZCcreVUbqwio3hW3tN6N2dBAhTWF3cC')
        .beginParse();
    final loaded =
        DictionaryUtils.parseDict(cs.loadRef().beginParse(), 256, (src) => src);
    final slice = loaded[BigInt.parse(
        '49451966632621557758120471512616710959653013068366703758014780023369952074677')];
    expect(slice?.toString(),
        'x{003ABDF630CC37294B16ACDFBB2A765E720D387DCBE69055031AF06C8A26E21768C00005CA68D3E5906_}\n p{01019EEC8302A9F6A5829743FC2C83D9D3D265E5CD8973FD70FDD9DF764898115AFF0001}');
    expect(BytesUtils.tryToHexString(slice?.asCell().hash()),
        '75741add82edc3448ef8b6e83a4b9a356ea61f7a53bf166d71b3e8f1bf52de97');
  });
}
