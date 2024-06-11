// ignore_for_file: unnecessary_new

import 'package:test/test.dart';
import 'package:ton_dart/src/boc/bit/bit_builder.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';

void main() {
  group("bit string", () => _test());
}

void _test() {
  test('should read bits', () {
    final bs = BitString([0xaa], 0, 8);
    expect(bs.at(0), true);
    expect(bs.at(1), false);
    expect(bs.at(2), true);
    expect(bs.at(3), false);
    expect(bs.at(4), true);
    expect(bs.at(5), false);
    expect(bs.at(6), true);
    expect(bs.at(7), false);
    expect(bs.toString(), "AA");
  });
  test('should equals', () {
    final a = BitString([0xaa], 0, 8);
    final b = BitString([0xaa], 0, 8);
    final c = BitString([0, 0xaa], 8, 8);
    expect(a, b);
    expect(b, a);
    expect(a, c);
    expect(c, a);
    expect(a.toString(), "AA");
    expect(b.toString(), "AA");
    expect(c.toString(), "AA");
  });
  test('should format strings', () {
    expect(BitString([0x00], 0, 1).toString(), "4_"); // 00
    expect(BitString([0x80], 0, 1).toString(), "C_"); // 80
    expect(BitString([0xc0], 0, 2).toString(), "E_"); // c0
    expect(BitString([0xe0], 0, 3).toString(), "F_"); // e0
    expect(BitString([0xe0], 0, 4).toString(), "E"); // e0
    expect(BitString([0xe8], 0, 5).toString(), "EC_"); // e8
  });
  test('should do subbuffers', () {
    final bs = new BitString([1, 2, 3, 4, 5, 6, 7, 8], 0, 64);
    final bs2 = bs.subbuffer(0, 16);
    expect(bs2!.length, 2);
  });
  test('should do substrings', () {
    final bs = new BitString([1, 2, 3, 4, 5, 6, 7, 8], 0, 64);
    final bs2 = bs.substring(0, 16);
    expect(bs2.length, 16);
  });
  test('should do empty substrings with requested length 0', () {
    final bs = new BitString([1, 2, 3, 4, 5, 6, 7, 8], 0, 64);
    final bs2 = bs.substring(bs.length, 0);
    expect(bs2.length, 0);
  });
  test('should OOB when offset is on the end of bitsring and length > 0', () {
    final bs = BitString([1, 2, 3, 4, 5, 6, 7, 8], 0, 64);
    expect(() => bs.substring(bs.length, 1), throwsA(isA<BocException>()));
  });
  test('should do empty subbuffers with requested length 0', () {
    final bs = new BitString([1, 2, 3, 4, 5, 6, 7, 8], 0, 64);
    final bs2 = bs.subbuffer(bs.length, 0);
    expect(bs2!.length, 0);
  });
  test('should OOB when offset is on the end of buffer and length > 0', () {
    final bs = BitString([1, 2, 3, 4, 5, 6, 7, 8], 0, 64);
    expect(() => bs.subbuffer(bs.length, 1), throwsA(isA<BocException>()));
  });
  test('should OOB when substring offset is out of bounds', () {
    final bs = BitString([1, 2, 3, 4, 5, 6, 7, 8], 0, 64);
    expect(() => bs.substring(bs.length + 1, 0), throwsA(isA<BocException>()));
    expect(() => bs.substring(-1, 0), throwsA(isA<BocException>()));
  });
  test('should OOB when subbuffer offset is out of bounds', () {
    final bs = new BitString([1, 2, 3, 4, 5, 6, 7, 8], 0, 64);
    expect(() => bs.subbuffer(bs.length + 1, 0), throwsA(isA<BocException>()));
    expect(() => bs.subbuffer(-1, 0), throwsA(isA<BocException>()));
  });

  test('should process monkey strings', () {
    const List<List<String>> cases = [
      ['001110101100111010', '3ACEA_'],
      ['01001', '4C_'],
      ['000000110101101010', '035AA_'],
      ['1000011111100010111110111', '87E2FBC_'],
      ['0111010001110010110', '7472D_'],
      ['', ''],
      ['0101', '5'],
      ['010110111010100011110101011110', '5BA8F57A_'],
      ['00110110001101', '3636_'],
      ['1110100', 'E9_'],
      ['010111000110110', '5C6D_'],
      ['01', '6_'],
      ['1000010010100', '84A4_'],
      ['010000010', '414_'],
      ['110011111', 'CFC_'],
      ['11000101001101101', 'C536C_'],
      ['011100111', '73C_'],
      ['11110011', 'F3'],
      ['011001111011111000', '67BE2_'],
      ['10101100000111011111', 'AC1DF'],
      ['0100001000101110', '422E'],
      ['000110010011011101', '19376_'],
      ['10111001', 'B9'],
      ['011011000101000001001001110000', '6C5049C2_'],
      ['0100011101', '476_'],
      ['01001101000001', '4D06_'],
      ['00010110101', '16B_'],
      ['01011011110', '5BD_'],
      ['1010101010111001011101', 'AAB976_'],
      ['00011', '1C_'],
      ['11011111111001111100', 'DFE7C'],
      ['1110100100110111001101011111000', 'E93735F1_'],
      ['10011110010111100110100000', '9E5E682_'],
      ['00100111110001100111001110', '27C673A_'],
      ['01010111011100000000001110000', '57700384_'],
      ['010000001011111111111000', '40BFF8'],
      ['0011110001111000110101100001', '3C78D61'],
      ['101001011011000010', 'A5B0A_'],
      ['1111', 'F'],
      ['10101110', 'AE'],
      ['1001', '9'],
      ['001010010', '294_'],
      ['110011', 'CE_'],
      ['10000000010110', '805A_'],
      ['11000001101000100', 'C1A24_'],
      ['1', 'C_'],
      ['0100101010000010011101111', '4A8277C_'],
      ['10', 'A_'],
      ['1010110110110110110100110010110', 'ADB6D32D_'],
      ['010100000000001000111101011001', '50023D66_']
    ];
    for (final c in cases) {
      // Build string
      final builder = new BitBuilder();
      for (final f in c[0].codeUnits) {
        builder.writeBit(f == 49);
      }
      final r = builder.build();

      // Check that string is valid
      for (int i = 0; i < c[0].length; i++) {
        expect(r.at(i), c[0][i] == '1');
      }

      // Check to string
      expect(r.toString(), c[1]);
    }
  });
}
