import 'package:test/test.dart';
import 'package:ton_dart/src/ton_connect/bridge/sse_parser.dart';
import '../utils.dart';

void sseParserTest() {
  group('TonSseParser heartbeat', () {
    test('heartbeat-only input emits nothing, cursor unchanged', () {
      final parser = TonSseParser();
      expect(parser.feed(':\n\n'), isEmpty);
      expect(parser.feed(': heartbeat\n\n'), isEmpty);
      expect(parser.feed(':keepalive\n\n'), isEmpty);
      expect(parser.lastId, isNull);
    });
  });

  group('TonSseParser frames', () {
    test('single frame sets cursor', () {
      final parser = TonSseParser();
      final events = parser.feed(
        'id: 42\nevent: message\ndata: {"from":"a","message":"b"}\n\n',
      );
      expect(events.length, 1);
      expect(events[0].id, '42');
      expect(events[0].event, 'message');
      expect(events[0].data, '{"from":"a","message":"b"}');
      expect(parser.lastId, '42');
    });

    test('multi data lines join with newline', () {
      final parser = TonSseParser();
      final events = parser.feed('id: 7\ndata: {"a":1}\ndata: {"b":2}\n\n');
      expect(events.length, 1);
      expect(events[0].data, '{"a":1}\n{"b":2}');
      expect(parser.lastId, '7');
    });

    test('split chunk across feeds emits once', () {
      final parser = TonSseParser();
      expect(parser.feed('id: 4'), isEmpty);
      final events = parser.feed('2\ndata: x\n\n');
      expect(events.length, 1);
      expect(events[0].id, '42');
      expect(events[0].data, 'x');
      expect(parser.lastId, '42');
    });

    test('two frames in one chunk emit two events', () {
      final parser = TonSseParser();
      final events = parser.feed('id: 1\ndata: one\n\nid: 2\ndata: two\n\n');
      expect(events.length, 2);
      expect(events[0].id, '1');
      expect(events[1].id, '2');
      expect(parser.lastId, '2');
    });

    test('crlf normalized, first id wins, empty data line kept', () {
      final parser = TonSseParser();
      final events = parser.feed('id: 9\r\nid: 10\r\ndata:\r\ndata: x\r\n\r\n');
      expect(events.length, 1);
      expect(events[0].id, '9');
      expect(events[0].data, '\nx');
    });

    test('bridge message frame carries payload', () {
      const aliceHex =
          '69696ee955b62b73cd62bda875fc73d68219e0036b7a0b37c5c7a8e9f8a1b2c3';
      final parser = TonSseParser();
      final events = parser.feed(
        'id: 99\nevent: message\ndata: {"from":"$aliceHex","message":"QUJD"}\n\n',
      );
      expect(events.length, 1);
      expect(events[0].data.contains(aliceHex), isTrue);
      expect(parser.lastId, '99');
    });

    test('reset clears buffer and cursor', () {
      final parser = TonSseParser();
      parser.feed('id: 1\ndata: x\n\n');
      parser.feed('id: 2\nda');
      parser.reset();
      expect(parser.lastId, isNull);
      expect(parser.feed('ta: y\n\n'), isEmpty);
    });
  });
}

void main() {
  TonTestApi.runTest(sseParserTest, 'Sse Parser');
}
