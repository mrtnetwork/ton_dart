import 'package:ton_dart/src/serialization/serialization.dart';

class ImagePreviewResponse with JsonSerialization {
  final String resolution;
  final String url;

  const ImagePreviewResponse({
    required this.resolution,
    required this.url,
  });

  factory ImagePreviewResponse.fromJson(Map<String, dynamic> json) {
    return ImagePreviewResponse(
        resolution: json['resolution'], url: json['url']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'resolution': resolution, 'url': url};
  }
}
