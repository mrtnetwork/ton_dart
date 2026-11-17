import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart' show test, expect, equals;
import 'package:ton_dart/ton_dart.dart';
import '../../utils.dart';

void exeptionTest() {
  test('Exception serialization', () {
    BuErrorCodec.registerTypes(TonErrorType.values);
    {
      final error = BuError(
        TonErrorType.plugin,
        "error",
        details: {"length": '32'},
      );
      final decode = BuErrorCodec.decode(bytes: error.toCborBytes());
      expect(decode.type, TonErrorType.plugin);
      expect(decode.message, "error");
    }
    {
      final error = BuError(
        TonErrorType.key,
        "error",
        details: {"length": '32'},
      );
      final decode = BuErrorCodec.decode(bytes: error.toCborBytes());
      expect(decode.type, TonErrorType.key);
      expect(decode.message, "error");
    }
    {
      final error = BuError(
        TonErrorType.contract,
        "error",
        details: {"length": '32'},
      );
      final decode = BuErrorCodec.decode(bytes: error.toCborBytes());
      expect(decode.type, TonErrorType.contract);
      expect(decode.message, "error");
    }
    {
      final ids = TonErrorType.values.map((e) => e.id);
      expect(ids.toSet().length, TonErrorType.values.length);
      for (final id in ids) {
        expect(id > 258, equals(true));
      }
    }
  });
}

void main() {
  TonTestApi.runTest(exeptionTest, 'Exeption');
}
