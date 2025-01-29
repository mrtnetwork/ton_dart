import 'package:blockchain_utils/utils/string/string.dart';
import 'package:ton_dart/src/boc/bit/bit_builder.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/utils/utils/math.dart';

class BocUtils {
  static BitBuilder bitsToPaddedBuffer(BitString bits) {
    final int size = ((bits.length / 8).ceil()) * 8;
    // Create builder
    final BitBuilder builder = BitBuilder(size: size);
    builder.writeBits(bits);

    // Apply padding
    final int padding = ((bits.length / 8).ceil()) * 8 - bits.length;
    for (int i = 0; i < padding; i++) {
      builder.writeBit(i == 0);
    }

    return builder;
  }

  static BitString paddedBufferToBits(List<int> buff) {
    int bitLen = 0;
    // Finding rightmost non-zero byte in the buffer
    for (int i = buff.length - 1; i >= 0; i--) {
      if (buff[i] != 0) {
        final int testByte = buff[i];
        // Looking for a rightmost set padding bit
        int bitPos = testByte & -testByte;
        if ((bitPos & 1) == 0) {
          // It's power of 2 (only one bit set)
          bitPos = MathUtils.log2(bitPos) + 1;
        }
        if (i > 0) {
          // If we are dealing with more than 1 byte buffer
          bitLen = i << 3; // Number of full bytes * 8
        }
        bitLen += 8 - bitPos;
        break;
      }
    }
    return BitString(buff, 0, bitLen);
  }

  static List<int> readBuffer(Slice slice) {
    // Check consistency
    if (slice.remainingBits % 8 != 0) {
      throw BocException('Invalid string length.',
          details: {'length': slice.remainingBits});
    }
    if (slice.remainingRefs != 0 && slice.remainingRefs != 1) {
      throw BocException('Invalid number of refs',
          details: {'length': slice.remainingRefs});
    }

    // Read string
    List<int> res = [];
    if (slice.remainingBits != 0) {
      res = slice.loadBuffer(slice.remainingBits ~/ 8);
    }

    // Read tail
    if (slice.remainingRefs == 1) {
      res = [...res, ...readBuffer(slice.loadRef().beginParse())];
    }

    return res;
  }

  static String readString(Slice slice) {
    final buffer = readBuffer(slice);
    return StringUtils.decode(buffer);
  }

  static void writeBuffer(List<int> src, Builder builder) {
    if (src.isNotEmpty) {
      final bytes = builder.availableBits ~/ 8;
      if (src.length > bytes) {
        final a = src.sublist(0, bytes);
        final t = src.sublist(bytes);
        builder = builder.storeBuffer(a);
        final bb = beginCell();
        writeBuffer(t, bb);
        builder = builder.storeRef(bb.endCell());
      } else {
        builder = builder.storeBuffer(src);
      }
    }
  }

  static Cell stringToCell(String src) {
    final builder = beginCell();
    writeBuffer(StringUtils.encode(src), builder);
    return builder.endCell();
  }

  static void writeString(String src, Builder builder) {
    writeBuffer(StringUtils.encode(src), builder);
  }
}
