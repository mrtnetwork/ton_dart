import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/crypto/quick_crypto.dart';
import 'package:ton_dart/src/boc/bit/bit_reader.dart';
import 'package:ton_dart/src/boc/bit/bit_string.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/boc/serialization/models/level_mask.dart';
import 'package:ton_dart/src/boc/serialization/models/exotic_merkle_proof.dart';
import 'package:ton_dart/src/boc/serialization/models/exotic_merkle_update.dart';
import 'package:ton_dart/src/boc/serialization/models/exotic_pruned.dart';
import 'package:ton_dart/src/boc/serialization/models/resolve_cell.dart';
import 'package:ton_dart/src/boc/serialization/models/topological_sort.dart';
import 'package:ton_dart/src/boc/cell/cell_type.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'package:ton_dart/src/boc/utils/utils.dart';
import 'package:ton_dart/src/utils/utils/math.dart';

class CellUtils {
  static List<CellTopoloigicalSort> topologicalSort(Cell src) {
    List<Cell> pending = [src];
    final Map<String, Map<String, dynamic>> allCells = {};
    final Set<String> notPermCells = {};
    final List<String> sorted = [];
    while (pending.isNotEmpty) {
      final List<Cell> cells = List<Cell>.from(pending);
      pending = [];
      for (final cell in cells) {
        final String hash = BytesUtils.toHexString(cell.hash());
        if (allCells.containsKey(hash)) {
          continue;
        }
        notPermCells.add(hash);
        allCells[hash] = {
          'cell': cell,
          'refs':
              cell.refs.map((v) => BytesUtils.toHexString(v.hash())).toList()
        };
        for (final r in cell.refs) {
          pending.add(r);
        }
      }
    }
    final Set<String> tempMark = {};

    void visit(String hash) {
      if (!notPermCells.contains(hash)) {
        return;
      }
      if (tempMark.contains(hash)) {
        throw BocException('Not a DAG');
      }
      tempMark.add(hash);

      final refs = List<String>.from(allCells[hash]!['refs']);
      for (var ci = refs.length - 1; ci >= 0; ci--) {
        visit(refs[ci]);
      }
      sorted.add(hash);
      tempMark.remove(hash);
      notPermCells.remove(hash);
    }

    while (notPermCells.isNotEmpty) {
      final String id = notPermCells.first;
      visit(id);
    }

    final Map<String, int> indexes = {};
    for (int i = 0; i < sorted.length; i++) {
      indexes[sorted[sorted.length - i - 1]] = i;
    }
    return sorted.reversed.map((e) {
      final Map<String, dynamic> cels = allCells[e]!;
      return CellTopoloigicalSort(
          cell: cels['cell'],
          refs: (cels['refs'] as List).map((v) => indexes[v]!).toList());
    }).toList();
  }

  static int getRefsDescriptor(List<Cell> refs, int levelMask, CellType type) {
    return refs.length +
        (type != CellType.ordinary ? 1 : 0) * 8 +
        levelMask * 32;
  }

  static int getBitsDescriptor(BitString bits) {
    final len = bits.length;
    return ((len / 8).ceil() + (len / 8).floor()).toInt();
  }

  static List<int> getRepr(BitString originalBits, BitString bits,
      List<Cell> refs, int level, int levelMask, CellType type) {
    // Allocate
    final int bitsLen = (bits.length / 8).ceil();
    final List<int> repr =
        List<int>.filled(2 + bitsLen + (2 + 32) * refs.length, 0);

    int reprCursor = 0;
    repr[reprCursor++] = getRefsDescriptor(refs, levelMask, type);
    repr[reprCursor++] = getBitsDescriptor(originalBits);

    // Write bits
    final List<int> buff =
        BocUtils.bitsToPaddedBuffer(bits).buffer(); //.copy(repr, reprCursor);
    for (int i = 0; i < buff.length; i++) {
      repr[reprCursor + i] = buff[i];
    }
    reprCursor += bitsLen;

    // Write refs
    for (final c in refs) {
      int childDepth;
      if (type == CellType.merkleProof || type == CellType.merkleUpdate) {
        childDepth = c.depth(level: level + 1);
      } else {
        childDepth = c.depth(level: level);
      }
      repr[reprCursor++] = (childDepth / 256).floor();
      repr[reprCursor++] = childDepth % 256;
    }
    for (final c in refs) {
      List<int> childHash;
      if (type == CellType.merkleProof || type == CellType.merkleUpdate) {
        childHash = c.hash(level: level + 1);
      } else {
        childHash = c.hash(level: level);
      }
      repr.setRange(reprCursor, reprCursor + 32, childHash);
      reprCursor += 32;
    }

    // Result
    return repr;
  }

  static void exoticLibrary(BitString bits, List<Cell> refs) {
    final BitReader reader = BitReader(bits);

    // type + hash
    const int size = 8 + 256;

    if (bits.length != size) {
      throw BocException('Invalid Library cell bits length',
          details: {'expected': '8 + 256', 'length': bits.length});
    }

    final type = reader.loadUint(8);
    if (type != 2) {
      throw BocException('Invalid Library cell type.', details: {
        'expected': CellType.library,
        'type': CellType.fromValue(type) ?? '$type'
      });
    }
  }

  static ExoticMerkleProof exoticMerkleProof(BitString bits, List<Cell> refs) {
    final BitReader reader = BitReader(bits);

    // type + hash + depth
    const int size = 8 + 256 + 16;

    if (bits.length != size) {
      throw BocException('Invalid Merkle Proof cell bits length.',
          details: {'expected': size, 'length': bits.length});
    }

    if (refs.length != 1) {
      throw BocException('Invalid Merkle Proof cell reference length.',
          details: {'expected': 1, 'length': refs.length});
    }

    final int type = reader.loadUint(8);
    if (type != 3) {
      throw BocException('Merkle Proof cell type.', details: {
        'expected': CellType.merkleProof,
        'type': CellType.fromValue(type) ?? '$type'
      });
    }

    final List<int> proofHash = reader.loadBuffer(32);
    final int proofDepth = reader.loadUint(16);
    final List<int> refHash = refs[0].hash(level: 0);
    final int refDepth = refs[0].depth(level: 0);
    if (proofDepth != refDepth || !BytesUtils.bytesEqual(proofHash, refHash)) {
      throw BocException('Mismatch in reference');
    }
    return ExoticMerkleProof(proofDepth: proofDepth, proofHash: proofHash);
  }

  static ExoticMerkleUpdate exoticMerkleUpdate(
      BitString bits, List<Cell> refs) {
    final BitReader reader = BitReader(bits);

    // // type + hash + hash + depth + depth
    const int bitLengthSize = 8 + (2 * (256 + 16));

    if (bits.length != bitLengthSize) {
      throw BocException('Invalid Merkle Update cell bits length.',
          details: {'expected': bitLengthSize, 'length': bits.length});
    }

    if (refs.length != 2) {
      throw BocException('Invalid Merkle Update cell refs length.',
          details: {'expected': 2, 'length': refs.length});
    }

    final int type = reader.loadUint(8);
    if (type != 4) {
      throw BocException('Invalid Merkle Update cell type.', details: {
        'expected': CellType.merkleUpdate,
        'type': CellType.fromValue(type) ?? '$type'
      });
    }

    final List<int> proofHash1 = reader.loadBuffer(32);
    final List<int> proofHash2 = reader.loadBuffer(32);
    final int proofDepth1 = reader.loadUint(16);
    final int proofDepth2 = reader.loadUint(16);

    if (proofDepth1 != refs[0].depth(level: 0)) {
      throw BocException('Mismatch in reference 1');
    }
    if (!BytesUtils.bytesEqual(proofHash1, refs[0].hash(level: 0))) {
      throw BocException('Invalid Merkle Update cell reference hash.');
    }

    if (proofDepth2 != refs[1].depth(level: 0)) {
      throw BocException('Mismatch in reference 2');
    }
    if (!BytesUtils.bytesEqual(proofHash2, refs[1].hash(level: 0))) {
      throw BocException('Invalid Merkle Update cell reference 2 hash.');
    }
    return ExoticMerkleUpdate(
        depth1: proofDepth1,
        depth2: proofDepth2,
        proof1: proofHash1,
        proof2: proofHash2);
  }

  static ExoticPruned exoticPruned(BitString bits, List<Cell> refs) {
    final BitReader reader = BitReader(bits);

    final int type = reader.loadUint(8);
    if (type != 1) {
      throw BocException('Invalid Pruned branch cell type.', details: {
        'expected': CellType.prunedBranch,
        'type': CellType.fromValue(type) ?? '$type'
      });
    }

    if (refs.isNotEmpty) {
      throw BocException('Pruned Branch cell have refs');
    }

    LevelMask mask;
    if (bits.length == 280) {
      mask = LevelMask(mask: 1);
    } else {
      final read8 = reader.loadUint(8);
      mask = LevelMask(mask: read8);

      if (mask.level < 1 || mask.level > 3) {
        throw BocException('Invalid Pruned Branch cell level', details: {
          'level': mask.level,
          'expected': [1, 2, 3].join(', ')
        });
      }

      final int size =
          8 + 8 + (mask.apply(mask.level - 1).hashCount * (256 + 16));
      if (bits.length != size) {
        throw BocException('Invalid Pruned branch cell bits length.',
            details: {'expected': size, 'length': bits.length});
      }
    }

    final List<Pruned> pruned = [];
    final List<List<int>> hashes = [];
    final List<int> depths = [];
    for (var i = 0; i < mask.level; i++) {
      hashes.add(reader.loadBuffer(32));
    }
    for (var i = 0; i < mask.level; i++) {
      depths.add(reader.loadUint(16));
    }
    for (var i = 0; i < mask.level; i++) {
      pruned.add(Pruned(hash: hashes[i], depth: depths[i]));
    }

    return ExoticPruned(mask: mask.value, pruned: pruned);
  }

  static ResolvedCellResult resolveExotic(BitString bits, List<Cell> refs) {
    final BitReader reader = BitReader(bits);
    final int typeTag = reader.preloadUint(8);
    final CellType? type = CellType.fromValue(typeTag);
    List<int> depths = [];
    List<List<int>> hashes = [];
    final LevelMask mask;
    switch (type) {
      case CellType.library:
        exoticLibrary(bits, refs);
        mask = LevelMask();
        break;
      case CellType.merkleProof:
        exoticMerkleProof(bits, refs);
        mask = LevelMask(mask: refs[0].level >> 1);
        break;
      case CellType.merkleUpdate:
        exoticMerkleUpdate(bits, refs);
        mask = LevelMask(mask: (refs[0].level | refs[1].level) >> 1);
        break;
      case CellType.prunedBranch:
        final pruned = exoticPruned(bits, refs);
        mask = LevelMask(mask: pruned.mask);
        hashes = pruned.pruned.map((e) => e.hash).toList();
        depths = pruned.pruned.map((e) => e.depth).toList();
        break;
      default:
        throw BocException('Invalid exotic cell type.',
            details: {'type': type ?? '$typeTag'});
    }
    return ResolvedCellResult(
        type: type!, hashes: hashes, depths: depths, mask: mask);
  }

  static ResolvedCellResult wonderCalculator(
      CellType type, BitString bits, List<Cell> refs) {
    //
    // Resolving level mask
    //

    LevelMask levelMask;
    ExoticPruned? pruned;
    switch (type) {
      case CellType.ordinary:
        int mask = 0;
        for (final r in refs) {
          mask |= r.mask.value;
        }
        levelMask = LevelMask(mask: mask);
        break;
      case CellType.prunedBranch:
        pruned = exoticPruned(bits, refs);
        levelMask = LevelMask(mask: pruned.mask);
        break;
      case CellType.merkleProof:
        exoticMerkleProof(bits, refs);
        levelMask = LevelMask(mask: refs[0].mask.value >> 1);
        break;
      case CellType.merkleUpdate:
        exoticMerkleUpdate(bits, refs);
        levelMask =
            LevelMask(mask: (refs[0].mask.value | refs[1].mask.value) >> 1);
        break;
      case CellType.library:
        exoticLibrary(bits, refs);
        levelMask = LevelMask();
        break;
      default:
        throw BocException('Unsupported exotic type', details: {'type': type});
    }
    //
    // Calculate hashes and depths
    //

    final List<int> depths = [];
    final List<List<int>> hashes = [];

    final int hashCount =
        type == CellType.prunedBranch ? 1 : levelMask.hashCount;
    final int totalHashCount = levelMask.hashCount;
    final int hashIOffset = totalHashCount - hashCount;
    for (int levelI = 0, hashI = 0; levelI <= levelMask.level; levelI++) {
      if (!levelMask.isSignificant(levelI)) {
        continue;
      }

      if (hashI < hashIOffset) {
        hashI++;
        continue;
      }
      BitString currentBits;
      if (hashI == hashIOffset) {
        if (!(levelI == 0 || type == CellType.prunedBranch)) {
          throw BocException('Invalid Level.',
              details: {'level': levelI, 'type': type});
        }
        currentBits = bits;
      } else {
        if (!(levelI != 0 && type != CellType.prunedBranch)) {
          throw BocException('Invalid Level.',
              details: {'level': levelI, 'type': type});
        }
        currentBits = BitString(hashes[hashI - hashIOffset - 1], 0, 256);
      }

      int currentDepth = 0;
      for (final r in refs) {
        int childDepth;
        if (type == CellType.merkleProof || type == CellType.merkleUpdate) {
          childDepth = r.depth(level: levelI + 1);
        } else {
          childDepth = r.depth(level: levelI);
        }
        currentDepth = MathUtils.max(currentDepth, childDepth);
      }
      if (refs.isNotEmpty) {
        currentDepth++;
      }

      final List<int> repr = getRepr(
          bits, currentBits, refs, levelI, levelMask.apply(levelI).value, type);
      final List<int> hash = QuickCrypto.sha256Hash(repr);

      final int destI = hashI - hashIOffset;
      depths.insert(destI, currentDepth);
      hashes.insert(destI, hash);

      hashI++;
    }

    //
    // Calculate hash and depth for all levels
    //

    final List<List<int>> resolvedHashes = [];
    final List<int> resolvedDepths = [];
    if (pruned != null) {
      for (int i = 0; i < 4; i++) {
        final int hashIndex = levelMask.apply(i).hashIndex;
        final int thisHashIndex = levelMask.hashIndex;
        if (hashIndex != thisHashIndex) {
          resolvedHashes.add(pruned.pruned[hashIndex].hash);
          resolvedDepths.add(pruned.pruned[hashIndex].depth);
        } else {
          resolvedHashes.add(hashes[0]);
          resolvedDepths.add(depths[0]);
        }
      }
    } else {
      for (int i = 0; i < 4; i++) {
        resolvedHashes.add(hashes[levelMask.apply(i).hashIndex]);
        resolvedDepths.add(depths[levelMask.apply(i).hashIndex]);
      }
    }

    return ResolvedCellResult(
        type: type,
        hashes: resolvedHashes,
        depths: resolvedDepths,
        mask: levelMask);
  }
}
