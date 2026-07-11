import 'package:test/test.dart' show test, expect;
import 'package:ton_dart/ton_dart.dart';

void main() {
  test('Exception serialization', () {
    {
      final error = TonDartPluginException("error", details: {"length": "32"});
      final decode = BaseTonDartPluginException.deserialize(
        bytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = KeyException("error", details: {"length": "32"});
      final decode = BaseTonDartPluginException.deserialize(
        bytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = DictException("error", details: {"length": "32"});
      final decode = BaseTonDartPluginException.deserialize(
        bytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = TonContractException("error", details: {"length": "32"});
      final decode = BaseTonDartPluginException.deserialize(
        bytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = BocException("error", details: {"length": "32"});
      final decode = BaseTonDartPluginException.deserialize(
        bytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = TokenMetadataException("error", details: {"length": "32"});
      final decode = BaseTonDartPluginException.deserialize(
        bytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
    {
      final error = TupleException("error", details: {"length": "32"});
      final decode = BaseTonDartPluginException.deserialize(
        bytes: error.toCbor().encode(),
      );
      expect(decode, error);
    }
  });
}
