// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consumer_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConsumerParametersImpl _$$ConsumerParametersImplFromJson(
        Map<String, dynamic> json) =>
    _$ConsumerParametersImpl(
      name: json['name'] as String,
      type: json['type'] as String,
      label: json['label'] as String,
      required: json['required'] as bool,
      defaultVal: json['defaultVal'] as String,
      description: json['description'] as String,
      options:
          (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ConsumerParametersImplToJson(
        _$ConsumerParametersImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'type': instance.type,
      'label': instance.label,
      'required': instance.required,
      'defaultVal': instance.defaultVal,
      'description': instance.description,
      'options': instance.options,
    };
