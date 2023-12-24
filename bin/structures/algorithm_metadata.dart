import 'package:freezed_annotation/freezed_annotation.dart';

import '../services/consumer_parameters.dart';

part 'algorithm_metadata.freezed.dart';
part 'algorithm_metadata.g.dart';

@freezed
class AlgorithmMetadata with _$AlgorithmMetadata {
  const AlgorithmMetadata._();
  const factory AlgorithmMetadata({
    required String url,
    required String rawcode,
    required String language,
    required String format,
    required String version,
    required String containerEntryPoint,
    required String containerImage,
    required String containerTag,
    required String containerChecksum,
    List<ConsumerParameters>? consumerParameters,
  }) = _AlgorithmMetadata;

  @override
  Map<String, dynamic> toJson() {
    return {
      'meta': {
        'url': url,
        'rawcode': rawcode,
        'language': language,
        'format': format,
        'version': version,
        'container': {
          'entrypoint': containerEntryPoint,
          'image': containerImage,
          'tag': containerTag,
          'checksum': containerChecksum,
        },
        if (consumerParameters?.isNotEmpty ?? false)
          'consumerParameters':
              consumerParameters!.map((e) => e.toJson()).toList(),
      },
    };
  }

  factory AlgorithmMetadata.fromJson(Map<String, dynamic> json) =>
      _$AlgorithmMetadataFromJson(json);
}
