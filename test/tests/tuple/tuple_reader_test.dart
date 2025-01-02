import 'package:test/test.dart';
import 'package:ton_dart/src/tuple/tuple/tuple.dart';
import 'package:ton_dart/src/tuple/tuple/tuple_reader.dart';

import 'tuple_json_test_vector.dart';

void main() {
  group('tuple reader', () => _test());
}

void _test() {
  test('should read cons', () {
    final List<TupleItem> cons = [
      TupleItemTuple([
        TupleItemInt(BigInt.one),
        TupleItemTuple([
          TupleItemInt(BigInt.two),
          TupleItemTuple([TupleItemInt(BigInt.from(3)), const TupleItemNull()])
        ]),
      ])
    ];
    final r = TupleReader(cons);

    final List<TupleItem> items = [
      TupleItemInt(BigInt.one),
      TupleItemInt(BigInt.two),
      TupleItemInt(BigInt.from(3)),
    ];

    expect(r.readLispList(), items);
  });
  test('should read ultra deep cons', () {
    final TupleItemTuple cons = TupleItemTuple.fromJson(tupleJsonTestVector);

    final result = [];
    for (int index = 0; index < 187; index++) {
      if (![11, 82, 116, 154].contains(index)) {
        result.add(TupleItemInt(BigInt.from(index)));
      }
    }
    final List<TupleItem> readList = TupleReader([cons]).readLispList();
    expect(readList, result);
  });
  test('should raise error on nontuple element in chain', () {
    final cons = [TupleItemInt(BigInt.zero)];

    final r = TupleReader(cons);
    expect(() => r.readLispListDirect(), throwsA(isA<Exception>()));
  });

  test('should return empty list if tuple is null', () {
    final cons = [const TupleItemNull()];

    TupleReader r = TupleReader(cons);
    expect(r.readLispList(), []);

    r = TupleReader(cons);
    expect(r.readLispListDirect(), []);
  });
}
