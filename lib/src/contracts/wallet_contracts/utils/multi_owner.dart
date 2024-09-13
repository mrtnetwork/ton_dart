import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary.dart';

class MultiOwnerContractUtils {
  static Dictionary<int, TonAddress> signersToDict<V>(List<TonAddress> obj) {
    final dict = Dictionary.empty<int, TonAddress>(
        key: DictionaryKey.uintCodec(8), value: DictionaryValue.addressCodec());
    for (int i = 0; i < obj.length; i++) {
      dict[i] = obj[i];
    }
    return dict;
  }

  static List<TonAddress> signerCellToList<V>(Cell? cell) {
    if (cell == null) return [];
    final dict = Dictionary.empty<int, TonAddress>(
        key: DictionaryKey.uintCodec(8), value: DictionaryValue.addressCodec());
    dict.loadFromClice(cell.beginParse());
    return dict.asMap.values.whereType<TonAddress>().toList();
  }
}
