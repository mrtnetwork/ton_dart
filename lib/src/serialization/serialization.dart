import 'package:ton_dart/src/boc/boc.dart';

/// Mixin to enforce JSON serialization on implementing classes.
mixin JsonSerialization {
  /// Converts the object to a JSON-compatible `Map<String, dynamic>`.
  Map<String, dynamic> toJson();

  /// Returns a string representation of the object,
  /// including its runtime type and JSON serialization.
  @override
  String toString() {
    final js = toJson();
    return '$runtimeType${js.toString()}';
  }
}

/// Abstract class for TON serialization, extending JSON serialization
/// and implementing BOC serialization.
abstract class TonSerialization
    with JsonSerialization
    implements BocSerializableObject {
  const TonSerialization();

  /// Serializes the object into a BOC cell.
  Cell serialize() {
    return beginCell().store(this).endCell();
  }
}
