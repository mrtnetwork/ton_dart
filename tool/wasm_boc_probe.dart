// Temporary dart2wasm hang probe (NOT a test; delete after diagnosis).
// Walks the BOC round-trip step by step, stamping progress into the DOM.
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:ton_dart/src/boc/serialization/serialization/serialization.dart';
import '../test/tests/cell/account_state_test_vector.dart'
    as vectors show accountStateVector;

void mark(String s) {
  final document = globalContext.getProperty('document'.toJS) as JSObject;
  final body = document.getProperty('body'.toJS) as JSObject;
  body.setProperty('textContent'.toJS, s.toJS);
}

List<int> _fromB64(String s) {
  const chars =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  final out = <int>[];
  var acc = 0, bits = 0;
  for (var i = 0; i < s.length; i++) {
    final c = s[i];
    if (c == '=') break;
    final v = chars.indexOf(c);
    if (v < 0) continue;
    acc = (acc << 6) | v;
    bits += 6;
    if (bits >= 8) {
      bits -= 8;
      out.add((acc >> bits) & 0xFF);
    }
  }
  return out;
}

void main() {
  try {
    mark('START');
    final boc = _fromB64(vectors.accountStateVector);
    mark('DECODED:${boc.length}');
    final c = BocSerialization.deserialize(boc)[0];
    mark('DESERIALIZED');
    final b = BocSerialization.serialize(root: c, idx: false, crc32: true);
    mark('SERIALIZED:${b.length}');
    final c2 = BocSerialization.deserialize(b)[0];
    mark('REDESERIALIZED');
    mark('WASM-BOC-OK:${c == c2}');
  } catch (e) {
    mark('PROBE-FAIL: $e');
  }
}
