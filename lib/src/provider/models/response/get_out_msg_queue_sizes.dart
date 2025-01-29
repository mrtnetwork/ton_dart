import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_raw.dart';

class OutMsgQueueSizesShardsItemResponse with JsonSerialization {
  final BlockRawResponse id;
  final int size;
  const OutMsgQueueSizesShardsItemResponse(
      {required this.id, required this.size});
  factory OutMsgQueueSizesShardsItemResponse.fromJson(
      Map<String, dynamic> json) {
    return OutMsgQueueSizesShardsItemResponse(
        id: BlockRawResponse.fromJson(json['id']), size: json['sizes']);
  }
  @override
  Map<String, dynamic> toJson() {
    return {'id': id.toJson(), 'size': size};
  }
}

class OutMsgQueueSizesResponse with JsonSerialization {
  final int extMsgQueueSizeLimit;
  final List<OutMsgQueueSizesShardsItemResponse> shards;
  const OutMsgQueueSizesResponse(
      {required this.extMsgQueueSizeLimit, required this.shards});
  factory OutMsgQueueSizesResponse.fromJson(Map<String, dynamic> json) {
    return OutMsgQueueSizesResponse(
      extMsgQueueSizeLimit: json['ext_msg_queue_size_limit'],
      shards: (json['shards'] as List)
          .map((e) => OutMsgQueueSizesShardsItemResponse.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'shards': shards.map((e) => e.toJson()).toList(),
      'ext_msg_queue_size_limit': extMsgQueueSizeLimit
    };
  }
}
