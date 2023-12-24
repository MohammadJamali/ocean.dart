// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'algorithm_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AlgorithmMetadataImpl _$$AlgorithmMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$AlgorithmMetadataImpl(
      url: json['url'] as String,
      rawcode: json['rawcode'] as String,
      language: json['language'] as String,
      format: json['format'] as String,
      version: json['version'] as String,
      containerEntryPoint: json['containerEntryPoint'] as String,
      containerImage: json['containerImage'] as String,
      containerTag: json['containerTag'] as String,
      containerChecksum: json['containerChecksum'] as String,
      consumerParameters: (json['consumerParameters'] as List<dynamic>?)
          ?.map((e) => ConsumerParameters.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AlgorithmMetadataImplToJson(
        _$AlgorithmMetadataImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'rawcode': instance.rawcode,
      'language': instance.language,
      'format': instance.format,
      'version': instance.version,
      'containerEntryPoint': instance.containerEntryPoint,
      'containerImage': instance.containerImage,
      'containerTag': instance.containerTag,
      'containerChecksum': instance.containerChecksum,
      'consumerParameters': instance.consumerParameters,
    };
