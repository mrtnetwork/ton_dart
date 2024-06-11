import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_currency_collection.dart';

class BlockValueFlowResponse with JsonSerialization {
  final BlockCurrencyCollectionResponse fromPrevBlk;
  final BlockCurrencyCollectionResponse toNextBlk;
  final BlockCurrencyCollectionResponse imported;
  final BlockCurrencyCollectionResponse exported;
  final BlockCurrencyCollectionResponse feesCollected;
  final BlockCurrencyCollectionResponse? burned;
  final BlockCurrencyCollectionResponse feesImported;
  final BlockCurrencyCollectionResponse recovered;
  final BlockCurrencyCollectionResponse created;
  final BlockCurrencyCollectionResponse minted;

  const BlockValueFlowResponse({
    required this.fromPrevBlk,
    required this.toNextBlk,
    required this.imported,
    required this.exported,
    required this.feesCollected,
    this.burned,
    required this.feesImported,
    required this.recovered,
    required this.created,
    required this.minted,
  });

  factory BlockValueFlowResponse.fromJson(Map<String, dynamic> json) {
    return BlockValueFlowResponse(
      fromPrevBlk:
          BlockCurrencyCollectionResponse.fromJson(json['from_prev_blk']),
      toNextBlk: BlockCurrencyCollectionResponse.fromJson(json['to_next_blk']),
      imported: BlockCurrencyCollectionResponse.fromJson(json['imported']),
      exported: BlockCurrencyCollectionResponse.fromJson(json['exported']),
      feesCollected:
          BlockCurrencyCollectionResponse.fromJson(json['fees_collected']),
      burned: json['burned'] != null
          ? BlockCurrencyCollectionResponse.fromJson(json['burned'])
          : null,
      feesImported:
          BlockCurrencyCollectionResponse.fromJson(json['fees_imported']),
      recovered: BlockCurrencyCollectionResponse.fromJson(json['recovered']),
      created: BlockCurrencyCollectionResponse.fromJson(json['created']),
      minted: BlockCurrencyCollectionResponse.fromJson(json['minted']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'from_prev_blk': fromPrevBlk.toJson(),
      'to_next_blk': toNextBlk.toJson(),
      'imported': imported.toJson(),
      'exported': exported.toJson(),
      'fees_collected': feesCollected.toJson(),
      'burned': burned?.toJson(),
      'fees_imported': feesImported.toJson(),
      'recovered': recovered.toJson(),
      'created': created.toJson(),
      'minted': minted.toJson(),
    };
  }
}
