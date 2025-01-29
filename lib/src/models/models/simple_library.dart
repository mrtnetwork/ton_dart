import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/dict/dictionary/value.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class SimpleLibraryCodecs {
  static DictionaryValue<SimpleLibrary> codec = DictionaryValue<SimpleLibrary>(
    serialize: (p0, p1) {
      p0.store(p1);
    },
    parse: (p0) => SimpleLibrary.deserialize(p0),
  );
}

class SimpleLibrary extends TonSerialization {
  final bool public;
  final Cell root;
  const SimpleLibrary({required this.public, required this.root});
  factory SimpleLibrary.deserialize(Slice slice) {
    return SimpleLibrary(
      public: slice.loadBit(),
      root: slice.loadRef(),
    );
  }
  factory SimpleLibrary.fromJson(Map<String, dynamic> json) {
    return SimpleLibrary(
        public: json['public'], root: Cell.fromBase64(json['root']));
  }

  @override
  void store(Builder builder) {
    builder.storeBitBolean(public);
    builder.storeRef(root);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'public': public, 'root': root.toBase64()};
  }
}
