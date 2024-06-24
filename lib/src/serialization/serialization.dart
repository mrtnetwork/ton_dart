import 'package:ton_dart/src/boc/boc.dart';

mixin JsonSerialization {
  Map<String, dynamic> toJson();

  @override
  String toString() {
    final js = toJson();
    return "$runtimeType${js.toString()}";
  }
}

abstract class TonSerialization
    with JsonSerialization
    implements BocSerializableObject {
  const TonSerialization();

  Cell serialize() {
    return beginCell().store(this).endCell();
  }
}
