/// Server-sent events parser for the TON Connect HTTP bridge
/// (`GET {bridge}/events`, `text/event-stream`).
///
/// Pure-Dart, web-safe: string operations only, no IO. Payload JSON is
/// NOT parsed here — `data` stays a string and is decoded upstream by
/// `TonBridgeMessage.fromJson` (bridge models).
class TonSseEvent {
  /// Resume cursor from the `id:` field, if present.
  final String? id;

  /// SSE `event:` field (usually `message`). Passthrough otherwise.
  final String? event;

  /// Joined `data:` lines (`\n` between multiple lines).
  final String data;

  /// True for heartbeat/comment-only frames (never emitted — documented
  /// for callers that construct events manually in tests).
  final bool isHeartbeat;

  const TonSseEvent({
    required this.id,
    required this.event,
    required this.data,
    this.isHeartbeat = false,
  });
}

/// Incremental `text/event-stream` decoder with resume cursor.
///
/// Feed raw chunks (TCP frames may split lines); complete frames
/// (terminated by a blank line) are returned, the tail stays buffered.
/// `lastId` tracks the last seen `id:` for `?lastEventId=` resume.
class TonSseParser {
  String? _lastId;
  String _buffer = '';

  /// Last seen SSE `id:`, if any. Used as `lastEventId` on reconnect.
  String? get lastId => _lastId;

  /// Feeds a raw stream chunk, returning newly completed events.
  ///
  /// Normalizes `\r\n` to `\n`, splits frames on `\n\n`. Comment-only
  /// frames (`:` prefix, e.g. `: heartbeat`) and frames without `data:`
  /// and `id:` are dropped.
  List<TonSseEvent> feed(String chunk) {
    _buffer += chunk.replaceAll('\r\n', '\n');
    final events = <TonSseEvent>[];
    while (true) {
      final boundary = _buffer.indexOf('\n\n');
      if (boundary < 0) break;
      final frame = _buffer.substring(0, boundary);
      _buffer = _buffer.substring(boundary + 2);
      final event = _parseFrame(frame);
      if (event == null) continue;
      if (event.id != null && event.id!.isNotEmpty) {
        _lastId = event.id;
      }
      events.add(event);
    }
    return events;
  }

  /// Drops buffered partial data and the cursor.
  void reset() {
    _buffer = '';
    _lastId = null;
  }

  TonSseEvent? _parseFrame(String frame) {
    String? id;
    String? event;
    final dataLines = <String>[];
    var hasDataLine = false;
    var commentOnly = true;

    for (final rawLine in frame.split('\n')) {
      if (rawLine.isEmpty) continue;
      if (rawLine.startsWith(':')) continue;
      commentOnly = false;
      final colon = rawLine.indexOf(':');
      if (colon < 0) continue;
      final field = rawLine.substring(0, colon);
      var value = rawLine.substring(colon + 1);
      if (value.startsWith(' ')) {
        value = value.substring(1);
      }
      switch (field) {
        case 'id':
          id ??= value;
        case 'event':
          event ??= value;
        case 'data':
          hasDataLine = true;
          dataLines.add(value);
        default:
          break;
      }
    }
    if (commentOnly) return null;
    if (!hasDataLine && (id == null || id.isEmpty)) return null;
    return TonSseEvent(
      id: (id == null || id.isEmpty) ? null : id,
      event: (event == null || event.isEmpty) ? null : event,
      data: dataLines.join('\n'),
    );
  }
}
