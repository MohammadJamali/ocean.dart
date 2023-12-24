// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stakes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StakesImpl _$$StakesImplFromJson(Map<String, dynamic> json) => _$StakesImpl(
      poolAddress: json['poolAddress'] as String,
      tokenAmountIn: json['tokenAmountIn'] as int,
      minPoolAmountOut: json['minPoolAmountOut'] as int,
    );

Map<String, dynamic> _$$StakesImplToJson(_$StakesImpl instance) =>
    <String, dynamic>{
      'poolAddress': instance.poolAddress,
      'tokenAmountIn': instance.tokenAmountIn,
      'minPoolAmountOut': instance.minPoolAmountOut,
    };
