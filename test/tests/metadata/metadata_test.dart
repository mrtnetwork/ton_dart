import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  group('metadata', () => _test());
}

// {6105d6cc76af400325e94d588ce511be5bfdbb73b437dc51eca43917d7a43e3d: https://postav.su/logo2.png, 82a3537ff0dbce7eec35d69edc3a189ee6f17d82f353a553f9aa96cb0be3ce89: DERE, b76a7ca153c24671658335bbd08946350ffc621fa1c516e7123095d4ffd5c581: DERE, c9046f7a37ad0ea7cee73355984fa5428982f8b37c8f7bcec91f7ac71a7cd104: The DERE token is designed to revolutionize DAO management. The DERE ecosystem supports staking, rewards, and a governance mechanism, fostering the creation of an inclusive and efficient fellowship on the Ton blockchain., ee80fd2f1e03480e2282363596ee752d7bb27f50776b95086a0279189675923e: 4}
void _test() {
  test('offchain', () {
    const cotent =
        'te6cckEBAQEASgAAkAFodHRwczovL3Rvbi5jeC9hZGRyZXNzL0VRRDB2ZFNBX05lZFI5dXZiZ045RWlrUlgtc3Vlc0R4R2VGZzY5WFFNYXZmTHFJd/FLtmM=';
    final contetCell = Cell.fromBase64(cotent);
    final decode = TokneMetadataUtils.loadContent(contetCell);
    expect(decode, isA<JettonOffChainMetadata>());
    expect((decode as JettonOffChainMetadata).uri,
        'https://ton.cx/address/EQD0vdSA_NedR9uvbgN9EikRX-suesDxGeFg69XQMavfLqIw');
    expect(decode.toContent().toBase64(), cotent);
  });
  test('onChain', () {
    const cotent =
        'te6cckECDwEAAdkAAQMAwAECASACBAFDv/CC62Y7V6ABkvSmrEZyiN8t/t252hvuKPZSHIvr0h8ewAMAOABodHRwczovL3Bvc3Rhdi5zdS9sb2dvMi5wbmcCASAFCQIBIAYHAUG/RUam/+G3nP3Ya609uHQxPc3i+wXmp0qn81UtlhfHnRMIAUG/btT5QqeEjOLLBmt3oRKMah/4xD9Dii3OJGErqf+riwMIAAoAREVSRQIBIAoNAUG/Ugje9G9aHU+dzmarMJ9KhRMF8Wb5Hvedkj71jjT5ogkLAf4AVGhlIERFUkUgdG9rZW4gaXMgZGVzaWduZWQgdG8gcmV2b2x1dGlvbml6ZSBEQU8gbWFuYWdlbWVudC4gVGhlIERFUkUgZWNvc3lzdGVtIHN1cHBvcnRzIHN0YWtpbmcsIHJld2FyZHMsIGFuZCBhIGdvdmVybmFuY2UgbWVjDAC8aGFuaXNtLCBmb3N0ZXJpbmcgdGhlIGNyZWF0aW9uIG9mIGFuIGluY2x1c2l2ZSBhbmQgZWZmaWNpZW50IGZlbGxvd3NoaXAgb24gdGhlIFRvbiBibG9ja2NoYWluLgFBv10B+l48BpAcRQRsay3c6lr3ZP6g7tcqENQE8jEs6yR9DgAEADQdW1O1';
    final contetCell = Cell.fromBase64(cotent);
    final decode = TokneMetadataUtils.loadContent(contetCell);
    expect(decode, isA<JettonOnChainMetadata>());
    final jetton = (decode as JettonOnChainMetadata);
    expect(jetton.name, 'DERE');
    expect(jetton.decimals, 4);
    expect(jetton.image, 'https://postav.su/logo2.png');
    expect(decode.toContent().toBase64(), cotent);
  });

  test('offchain', () {
    const cotent =
        'te6cckEBAQEARQAAhgFpcGZzOi8vYmFma3JlaWFzdDRmcWxrcDR1cHl1MmN2bzdmbjdhYWJqdXN4NzY1eXp2cWl0c3I0cnB3ZnZoamd1aHlTV7NY';
    final contetCell = Cell.fromBase64(cotent);
    final decode = TokneMetadataUtils.loadContent(contetCell);
    expect(decode, isA<JettonOffChainMetadata>());
    expect((decode as JettonOffChainMetadata).uri,
        'ipfs://bafkreiast4fqlkp4upyu2cvo7fn7aabjusx765yzvqitsr4rpwfvhjguhy');
  });
}
