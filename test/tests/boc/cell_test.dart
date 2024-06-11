import 'package:test/test.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/boc/cell/cell_type.dart';

void main() {
  _test();
}

void _test() {
  test('should construct', () {
    final cell = Cell();
    expect(cell.type, CellType.ordinary);
    expect(cell.bits, BitString([], 0, 0));
    expect(cell.refs, []);
  });
}
