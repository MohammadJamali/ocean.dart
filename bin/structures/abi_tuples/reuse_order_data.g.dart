// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reuse_order_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReuseOrderDataImpl _$$ReuseOrderDataImplFromJson(Map<String, dynamic> json) =>
    _$ReuseOrderDataImpl(
      tokenAddress: json['tokenAddress'] as String,
      orderTxId: json['orderTxId'] as String,
      providerFees: _$recordConvert(
        json['providerFees'],
        ($jsonValue) => (
          ($jsonValue[r'$1'] as List<dynamic>).map((e) => e as int).toList(),
          ($jsonValue[r'$2'] as List<dynamic>).map((e) => e as int).toList(),
        ),
      ),
    );

Map<String, dynamic> _$$ReuseOrderDataImplToJson(
        _$ReuseOrderDataImpl instance) =>
    <String, dynamic>{
      'tokenAddress': instance.tokenAddress,
      'orderTxId': instance.orderTxId,
      'providerFees': {
        r'$1': instance.providerFees.$1,
        r'$2': instance.providerFees.$2,
      },
    };

$Rec _$recordConvert<$Rec>(
  Object? value,
  $Rec Function(Map) convert,
) =>
    convert(value as Map<String, dynamic>);
