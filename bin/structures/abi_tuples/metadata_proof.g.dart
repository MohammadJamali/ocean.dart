// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metadata_proof.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MetadataProofImpl _$$MetadataProofImplFromJson(Map<String, dynamic> json) =>
    _$MetadataProofImpl(
      validatorAddress: json['validatorAddress'] as String,
      v: json['v'] as int,
      r: const Uint8ListConverter().fromJson(json['r'] as List<int>),
      s: const Uint8ListConverter().fromJson(json['s'] as List<int>),
    );

Map<String, dynamic> _$$MetadataProofImplToJson(_$MetadataProofImpl instance) =>
    <String, dynamic>{
      'validatorAddress': instance.validatorAddress,
      'v': instance.v,
      'r': const Uint8ListConverter().toJson(instance.r),
      's': const Uint8ListConverter().toJson(instance.s),
    };
