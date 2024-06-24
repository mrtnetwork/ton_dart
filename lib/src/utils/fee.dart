import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/message_relaxed.dart';
import 'package:ton_dart/src/provider/models/models.dart';

class StorageStat {
  int cells;
  int bits;

  StorageStat({required this.cells, required this.bits});
}

class TonFeeUtils {
  static BigInt shr16ceil(BigInt src) {
    BigInt rem = src % BigInt.from(65536);
    BigInt res = src >> 16;
    if (rem != BigInt.zero) {
      res += BigInt.one;
    }
    return res;
  }

  static BigInt computeGasPrices(
      BigInt gasUsed, GasLimitPricesResponse prices) {
    if (gasUsed <= prices.flatGasLimit) {
      return prices.flatGasPrice;
    } else {
      return prices.flatGasPrice +
          ((prices.gasPrice * (gasUsed - prices.flatGasLimit)) >> 16);
    }
  }

  static StorageStat collectCellStats(Cell cell) {
    int bits = cell.bits.length;
    int cells = 1;
    for (Cell ref in cell.refs) {
      StorageStat r = collectCellStats(ref);
      cells += r.cells;
      bits += r.bits;
    }
    return StorageStat(bits: bits, cells: cells);
  }

  static BigInt computeFwdFees(
      MsgForwardPricesResponse msgPrices, BigInt cells, BigInt bits) {
    return msgPrices.lumpPrice +
        shr16ceil(msgPrices.bitPrice * bits + msgPrices.cellPrice * cells);
  }

  static BigInt computeExternalMessageFees(
      MsgForwardPricesResponse msgPrices, Cell cell) {
    StorageStat storageStats = collectCellStats(cell);
    storageStats.bits -= cell.bits.length;
    storageStats.cells -= 1;
    return computeFwdFees(msgPrices, BigInt.from(storageStats.cells),
        BigInt.from(storageStats.bits));
  }

  static Tuple<BigInt, BigInt> computeMessageForwardFees(
      MsgForwardPricesResponse msgPrices, MessageRelaxed msg) {
    StorageStat storageStats = StorageStat(bits: 0, cells: 0);
    if (msg.init != null) {
      Cell raw = beginCell().store(msg.init!).endCell();
      StorageStat c = collectCellStats(raw);
      c.bits -= raw.bits.length;
      c.cells -= 1;
      storageStats.bits += c.bits;
      storageStats.cells += c.cells;
    }

    StorageStat bc = collectCellStats(msg.body);
    bc.bits -= msg.body.bits.length;
    bc.cells -= 1;
    storageStats.bits += bc.bits;
    storageStats.cells += bc.cells;

    BigInt fees = computeFwdFees(msgPrices, BigInt.from(storageStats.cells),
        BigInt.from(storageStats.bits));
    BigInt res = (fees * BigInt.from(msgPrices.firstFrac)) >> 16;
    BigInt remaining = fees - res;
    return Tuple(res, remaining);
  }

  static BigInt computeStorageFees({
    required int now,
    required List<BlockchainConfig18StoragePricesItem> storagePrices,
    required AccountStorageInfoResponse storageStats,
    required bool special,
    required bool masterchain,
  }) {
    if (now <= storageStats.lastPaid ||
        storagePrices.isEmpty ||
        now < storagePrices[0].utimeSince ||
        special) {
      return BigInt.zero;
    }
    int upto = storageStats.lastPaid > storagePrices[0].utimeSince
        ? storageStats.lastPaid
        : storagePrices[0].utimeSince;
    BigInt total = BigInt.zero;
    for (int i = 0; i < storagePrices.length && upto < now; i++) {
      final int validUntil = (i < storagePrices.length - 1
          ? (now < storagePrices[i + 1].utimeSince
              ? now
              : storagePrices[i + 1].utimeSince)
          : now);
      BigInt payment = BigInt.zero;
      if (upto < validUntil) {
        int delta = validUntil - upto;
        payment += (storageStats.usedCells *
            (masterchain
                ? storagePrices[i].mcCellPricePs
                : storagePrices[i].cellPricePs));
        payment += (storageStats.usedBits *
            (masterchain
                ? storagePrices[i].mcBitPricePs
                : storagePrices[i].bitPricePs));
        payment *= BigInt.from(delta);
      }
      upto = validUntil;
      total += payment;
    }
    return total ~/ BigInt.two.pow(16);
  }
}
