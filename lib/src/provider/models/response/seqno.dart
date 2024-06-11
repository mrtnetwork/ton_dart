import 'package:ton_dart/src/serialization/serialization.dart';

class SeqnoResponse with JsonSerialization {
  final int seqno;

  const SeqnoResponse({
    required this.seqno,
  });

  factory SeqnoResponse.fromJson(Map<String, dynamic> json) {
    return SeqnoResponse(seqno: json['seqno']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'seqno': seqno,
    };
  }
}
