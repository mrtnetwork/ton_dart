import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/tuple/exception/exception.dart';

class TupleItemTypes {
  final String name;
  const TupleItemTypes._(this.name);
  static const TupleItemTypes tupleItem = TupleItemTypes._("tuple");
  static const TupleItemTypes nullItem = TupleItemTypes._("null");
  static const TupleItemTypes intItem = TupleItemTypes._("num");
  static const TupleItemTypes nanItem = TupleItemTypes._("nan");
  static const TupleItemTypes cellItem = TupleItemTypes._("cell");
  static const TupleItemTypes sliceItem = TupleItemTypes._("slice");
  static const TupleItemTypes builderItem = TupleItemTypes._("builder");
  static const List<TupleItemTypes> values = [
    tupleItem,
    nullItem,
    intItem,
    nanItem,
    cellItem,
    sliceItem,
    builderItem
  ];

  static TupleItemTypes fromName(String? name, {TupleItemTypes? excepted}) {
    final n = name?.replaceAll("tvm.", '').toLowerCase();
    final type = values.firstWhere(
      (element) => element.name == n,
      orElse: () => throw TupleException(
          "Cannot find tuple type from provided type.",
          details: {"value": name}),
    );
    if (excepted != null && excepted != type) {
      throw TupleException("Incorrect tuple type excepted $excepted got $type");
    }
    return type;
  }

  @override
  String toString() {
    return name;
  }
}

abstract class TupleItem with JsonSerialization {
  abstract final TupleItemTypes type;
  const TupleItem();
  factory TupleItem.fromJson(Map<String, dynamic> json) {
    final type = TupleItemTypes.fromName(json["type"]);
    switch (type) {
      case TupleItemTypes.tupleItem:
        return TupleItemTuple.fromJson(json);
      case TupleItemTypes.nanItem:
        return const TupleItemNaN();
      case TupleItemTypes.nullItem:
        return const TupleItemNull();
      case TupleItemTypes.intItem:
        return TupleItemInt.fromJson(json);
      case TupleItemTypes.cellItem:
        return TupleItemCell.fromJson(json);
      case TupleItemTypes.sliceItem:
        return TupleItemSlice.fromJson(json);
      default:
        return TupleItemBuilder.fromJson(json);
    }
  }
  factory TupleItem.fromTvm(Map<String, dynamic> json) {
    final type = TupleItemTypes.fromName(json["@type"]);
    switch (type) {
      case TupleItemTypes.tupleItem:
        return TupleItemTuple.fromTvm(json);
      case TupleItemTypes.nanItem:
        return const TupleItemNaN();
      case TupleItemTypes.nullItem:
        return const TupleItemNull();
      case TupleItemTypes.intItem:
        return TupleItemInt.fromTvm(json);
      case TupleItemTypes.cellItem:
        return TupleItemCell.fromTvm(json);
      case TupleItemTypes.sliceItem:
        return TupleItemSlice.fromTvm(json);
      default:
        return TupleItemBuilder.fromTvm(json);
    }
  }

  @override
  operator ==(other) {
    if (other is! TupleItem) return false;
    if (other.runtimeType != runtimeType) return false;
    if (other.type != type) return false;
    return true;
  }

  @override
  int get hashCode => type.hashCode;
}

class TupleItemTuple extends TupleItem {
  final List<TupleItem> items;
  const TupleItemTuple(this.items);
  factory TupleItemTuple.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.tupleItem);
    return TupleItemTuple(
        (json["items"] as List).map((e) => TupleItem.fromJson(e)).toList());
  }
  factory TupleItemTuple.fromTvm(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["@type"], excepted: TupleItemTypes.tupleItem);
    return TupleItemTuple(
        (json["items"] as List).map((e) => TupleItem.fromJson(e)).toList());
  }
  @override
  TupleItemTypes get type => TupleItemTypes.tupleItem;
  @override
  operator ==(other) {
    if (super == other) {
      other as TupleItemTuple;
      return CompareUtils.iterableIsEqual(items, other.items);
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode ^ Object.hashAll(items);

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "items": items.map((e) => e.toJson()).toList()};
  }
}

class TupleItemNull extends TupleItem {
  const TupleItemNull();
  factory TupleItemNull.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.nullItem);
    return const TupleItemNull();
  }
  factory TupleItemNull.fromTvm(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["@type"], excepted: TupleItemTypes.nullItem);
    return const TupleItemNull();
  }
  @override
  TupleItemTypes get type => TupleItemTypes.nullItem;

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }
}

class TupleItemInt extends TupleItem {
  final BigInt value;
  const TupleItemInt(this.value);
  factory TupleItemInt.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.intItem);
    return TupleItemInt(BigintUtils.parse(json["num"]));
  }
  factory TupleItemInt.fromTvm(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["@type"], excepted: TupleItemTypes.intItem);
    return TupleItemInt(BigintUtils.parse(json["int"]));
  }
  @override
  TupleItemTypes get type => TupleItemTypes.intItem;
  @override
  operator ==(other) {
    if (super == other) {
      other as TupleItemInt;
      return other.value == value;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode ^ value.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "num": value.toString()};
  }

  @override
  String toString() {
    return "TupleItemInt($value)";
  }
}

class TupleItemNaN extends TupleItem {
  const TupleItemNaN();
  factory TupleItemNaN.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.nanItem);
    return const TupleItemNaN();
  }
  factory TupleItemNaN.fromTvm(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["@type"], excepted: TupleItemTypes.nanItem);
    return const TupleItemNaN();
  }
  @override
  TupleItemTypes get type => TupleItemTypes.nanItem;

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }
}

class TupleItemCell extends TupleItem {
  final Cell cell;
  const TupleItemCell(this.cell);
  factory TupleItemCell.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.cellItem);
    final cell = TonHelper.tryToCell(json["cell"]);
    if (cell == null) {
      throw TupleException("Invalid Slice string hex or base64");
    }
    return TupleItemCell(cell);
  }
  factory TupleItemCell.fromTvm(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["@type"], excepted: TupleItemTypes.cellItem);
    final cell = TonHelper.tryToCell(json["bytes"]);
    if (cell == null) {
      throw TupleException("Invalid Slice string hex or base64");
    }
    return TupleItemSlice(cell);
  }

  @override
  TupleItemTypes get type => TupleItemTypes.cellItem;

  @override
  operator ==(other) {
    if (super == other) {
      other as TupleItemCell;
      return other.cell == cell;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode ^ cell.hashCode;
  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "cell": cell.toBase64()};
  }
}

class TupleItemSlice extends TupleItemCell {
  const TupleItemSlice(Cell cell) : super(cell);
  factory TupleItemSlice.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.sliceItem);
    final cell = TonHelper.tryToCell(json["cell"]);
    if (cell == null) {
      throw TupleException("Invalid Slice string hex or base64");
    }
    return TupleItemSlice(cell);
  }
  factory TupleItemSlice.fromTvm(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["@type"], excepted: TupleItemTypes.sliceItem);
    final cell = TonHelper.tryToCell(json["bytes"]);
    if (cell == null) {
      throw TupleException("Invalid Slice string hex or base64");
    }
    return TupleItemSlice(cell);
  }
  @override
  TupleItemTypes get type => TupleItemTypes.sliceItem;
  @override
  operator ==(other) {
    if (super == other) {
      other as TupleItemSlice;
      return other.cell == cell;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode ^ cell.hashCode;
}

class TupleItemBuilder extends TupleItemCell {
  const TupleItemBuilder(Cell cell) : super(cell);
  factory TupleItemBuilder.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.builderItem);
    final cell = TonHelper.tryToCell(json["cell"]);
    if (cell == null) {
      throw TupleException("Invalid builder string hex or base64");
    }
    return TupleItemBuilder(cell);
  }
  factory TupleItemBuilder.fromTvm(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["@type"],
        excepted: TupleItemTypes.builderItem);
    final cell = TonHelper.tryToCell(json["bytes"]);
    if (cell == null) {
      throw TupleException("Invalid builder string hex or base64");
    }
    return TupleItemBuilder(cell);
  }
  @override
  TupleItemTypes get type => TupleItemTypes.builderItem;
  @override
  operator ==(other) {
    if (super == other) {
      other as TupleItemBuilder;
      return other.cell == cell;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode ^ cell.hashCode;
}
