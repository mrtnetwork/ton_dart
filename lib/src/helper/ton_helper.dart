import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/models/models.dart';

/// A utility class for handling TON (The Open Network) specific operations.
///
/// This class provides methods for converting between nanoGrams and decimal strings,
/// parsing cell data from strings, and converting strings to cells.
class TonHelper {
  // /// The number of decimal places for naoGrams values.
  static const int nanoGramsDecimalPlaces = 9;

  /// Returns the equivalent value in nanoGrams as a [BigInt].
  static BigInt toNanoGrams(String gram) {
    return AmountConverter.gram.toUnit(gram);
  }

  /// Returns the equivalent decimal string representation.
  static String fromNanoGrams(BigInt nanograms) {
    return AmountConverter.gram.toAmount(nanograms);
  }

  /// Attempts to parse a string into a [Cell] object.
  ///
  /// [data] - The string data that might represent a cell in hex or base64 format.
  ///
  /// Returns the parsed [Cell] if successful, or `null` if the data is invalid or parsing fails.
  static Cell? tryToCell(String? data) {
    try {
      if (data?.trim().isEmpty ?? true) return null;
      if (StringUtils.isHexBytes(data!)) {
        return Cell.fromHex(data);
      }
      return Cell.fromBase64(data);
    } catch (e) {
      return null;
    }
  }

  /// Converts a string into a [Cell] object, throwing an exception if the conversion fails.
  ///
  /// [data] - The string data that represents a cell in hex or base64 format.
  ///
  /// Returns the parsed [Cell].
  /// Throws a [TonDartPluginException] if the data is invalid or cannot be parsed.
  static Cell toCell(String? data) {
    final toCell = tryToCell(data);
    if (toCell == null) {
      throw TonDartPluginException(
        'Invalid cell data.',
        details: {'data': data},
      );
    }
    return toCell;
  }

  static MessageRelaxed internal({
    required TonAddress destination,
    required BigInt amount,
    Cell? body,
    StateInit? initState,
    String? memo,
    bool bounce = false,
    bool bounced = false,
  }) {
    assert(
      memo == null || body == null,
      'You have to choose a memo or body for each message.',
    );
    return MessageRelaxed(
      info: CommonMessageInfoRelaxedInternal(
        ihrDisabled: true,
        bounce: bounce,
        bounced: bounced,
        dest: destination,
        value: CurrencyCollection(coins: amount),
        ihrFee: BigInt.zero,
        forwardFee: BigInt.zero,
        createdLt: BigInt.zero,
        createdAt: 0,
      ),
      body: body ?? Cell(),
      init: initState,
    );
  }

  static Cell buildMessageBody(String? memo) {
    if (memo != null) {
      return beginCell().storeUint(0, 32).storeStringTail(memo).endCell();
    }
    return Cell();
  }
}
