import 'package:myapp/app/cores/models/pillowpon_metadata.dart';

class BackendUploadMetadataRequest {
  final PillowponMetadata metadata;

  BackendUploadMetadataRequest({
    required this.metadata,
  });

  Map<String, dynamic> toJson() {
    return metadata.toJson();
  }
}