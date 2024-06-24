import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class TickTock extends TonSerialization {
  final bool tick;
  final bool tock;
  const TickTock({required this.tick, required this.tock});
  factory TickTock.deserialize(Slice slice) {
    return TickTock(
      tick: slice.loadBit(),
      tock: slice.loadBit(),
    );
  }
  factory TickTock.fromJson(Map<String, dynamic> json) {
    return TickTock(tick: json["tick"], tock: json["tock"]);
  }
  @override
  void store(Builder builder) {
    builder.storeBitBolean(tick);
    builder.storeBitBolean(tock);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"tick": tick, "tock": tock};
  }
}
