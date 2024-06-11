import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/tuple/exception/exception.dart';

class TupleItemTypes {
  final String name;
  const TupleItemTypes._(this.name);
  static const TupleItemTypes tupleItem = TupleItemTypes._("tuple");
  static const TupleItemTypes nullItem = TupleItemTypes._("null");
  static const TupleItemTypes intItem = TupleItemTypes._("int");
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
    builderItem,
  ];

  static TupleItemTypes fromName(String? name, {TupleItemTypes? excepted}) {
    final type = values.firstWhere(
      (element) => element.name == name,
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

abstract class TupleItem {
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
  @override
  TupleItemTypes get type => TupleItemTypes.tupleItem;
  @override
  operator ==(other) {
    if (super == other) {
      other as TupleItemTuple;
      return iterableIsEqual(items, other.items);
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode ^ Object.hashAll(items);
}

class TupleItemNull extends TupleItem {
  const TupleItemNull();
  factory TupleItemNull.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.nullItem);
    return const TupleItemNull();
  }
  @override
  TupleItemTypes get type => TupleItemTypes.nullItem;
}

class TupleItemInt extends TupleItem {
  final BigInt value;
  const TupleItemInt(this.value);
  factory TupleItemInt.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.intItem);
    return TupleItemInt(BigintUtils.parse(json["value"]));
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
  @override
  TupleItemTypes get type => TupleItemTypes.nanItem;
}

class TupleItemCell extends TupleItem {
  final Cell cell;
  const TupleItemCell(this.cell);
  factory TupleItemCell.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.cellItem);
    final decodeBytes =
        StringUtils.tryEncode(json["cell"], StringEncoding.base64) ??
            BytesUtils.tryFromHexString(json["cell"]);
    if (decodeBytes == null) {
      throw TupleException("Invalid cell string hex or base64");
    }
    final cell = Cell.fromBoc(decodeBytes);
    if (cell.length != 1) {
      throw TupleException("More than one cell.", details: {"cell": cell});
    }
    return TupleItemCell(cell[0]);
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
}

class TupleItemSlice extends TupleItem {
  final Cell slice;
  const TupleItemSlice(this.slice);
  factory TupleItemSlice.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.sliceItem);
    final decodeBytes =
        StringUtils.tryEncode(json["slice"], StringEncoding.base64) ??
            BytesUtils.tryFromHexString(json["slice"]);
    if (decodeBytes == null) {
      throw TupleException("Invalid cell string hex or base64");
    }
    final cell = Cell.fromBoc(decodeBytes);
    if (cell.length != 1) {
      throw TupleException("More than one cell.", details: {"cell": cell});
    }
    return TupleItemSlice(cell[0]);
  }
  @override
  TupleItemTypes get type => TupleItemTypes.sliceItem;
  @override
  operator ==(other) {
    if (super == other) {
      other as TupleItemSlice;
      return other.slice == slice;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode ^ slice.hashCode;
}

class TupleItemBuilder extends TupleItem {
  final Cell builder;
  const TupleItemBuilder(this.builder);
  factory TupleItemBuilder.fromJson(Map<String, dynamic> json) {
    TupleItemTypes.fromName(json["type"], excepted: TupleItemTypes.builderItem);
    final decodeBytes =
        StringUtils.tryEncode(json["builder"], StringEncoding.base64) ??
            BytesUtils.tryFromHexString(json["builder"]);
    if (decodeBytes == null) {
      throw TupleException("Invalid builder string hex or base64");
    }
    final cell = Cell.fromBoc(decodeBytes);
    if (cell.length != 1) {
      throw TupleException("More than on cell.", details: {"cell": cell});
    }
    return TupleItemBuilder(cell[0]);
  }
  @override
  TupleItemTypes get type => TupleItemTypes.builderItem;
  @override
  operator ==(other) {
    if (super == other) {
      other as TupleItemBuilder;
      return other.builder == builder;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode ^ builder.hashCode;
}
