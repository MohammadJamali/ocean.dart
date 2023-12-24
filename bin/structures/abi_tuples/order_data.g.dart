// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderDataImpl _$$OrderDataImplFromJson(Map<String, dynamic> json) =>
    _$OrderDataImpl(
      tokenAddress: json['tokenAddress'] as String,
      consumer: json['consumer'] as String,
      serviceIndex: json['serviceIndex'] as int,
      providerFees: _$recordConvert(
        json['providerFees'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as List<dynamic>).map((e) => e as int).toList(),
          ($jsonValue[r'$2'] as List<dynamic>).map((e) => e as int).toList(),
        ),
      ),
      consumeFees: _$recordConvert(
        json['consumeFees'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as List<dynamic>).map((e) => e as int).toList(),
          ($jsonValue[r'$2'] as List<dynamic>).map((e) => e as int).toList(),
        ),
      ),
    );

Map<String, dynamic> _$$OrderDataImplToJson(_$OrderDataImpl instance) =>
    <String, dynamic>{
      'tokenAddress': instance.tokenAddress,
      'consumer': instance.consumer,
      'serviceIndex': instance.serviceIndex,
      'providerFees': {
        r'$1': instance.providerFees.$1,
        r'$2': instance.providerFees.$2,
      },
      'consumeFees': {
        r'$1': instance.consumeFees.$1,
        r'$2': instance.consumeFees.$2,
      },
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
