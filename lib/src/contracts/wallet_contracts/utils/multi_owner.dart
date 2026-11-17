import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary.dart';

class MultiOwnerContractUtils {
  static Dictionary<int, TonAddress> signersToDict<V>(List<TonAddress> obj) {
    final dict = Dictionary.empty<int, TonAddress>(
      key: DictionaryKey.uintCodec(8),
      value: DictionaryValue.addressCodec(),
    );
    for (int i = 0; i < obj.length; i++) {
      dict[i] = obj[i];
    }
    return dict;
  }

  static List<TonAddress> signerCellToList<V>(Cell? cell) {
    if (cell == null) return [];
    // Signer dicts are direct-layout cells (inline hashmap root) everywhere
    // the contracts carry them: `packOrder`/`packUpdateRequest` store them
    // with `storeDictDirect`, the multisig state deserializer reads them
    // with `loadRef` + direct parse, and `get_order_data` returns them as
    // an inline root. Parsing them as maybe-layout (`loadFromClice`) throws
    // `BuError: No more references` on real chain responses.
    return Dictionary.loadDirect<int, TonAddress>(
      key: DictionaryKey.uintCodec(8),
      value: DictionaryValue.addressCodec(),
      slice: cell.beginParse(),
    ).asMap.values.whereType<TonAddress>().toList();
  }
}
