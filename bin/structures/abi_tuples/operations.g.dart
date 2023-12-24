// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OperationsImpl _$$OperationsImplFromJson(Map<String, dynamic> json) =>
    _$OperationsImpl(
      exchangeId:
          const Uint8ListConverter().fromJson(json['exchangeId'] as List<int>),
      source: json['source'] as String,
      operation: $enumDecode(_$OperationTypeEnumMap, json['operation']),
      tokenIn: json['tokenIn'] as String,
      amountsIn: json['amountsIn'] as int,
      tokenOut: json['tokenOut'] as String,
      amountsOut: json['amountsOut'] as int,
      maxPrice: json['maxPrice'] as int,
      swapMarketFee: json['swapMarketFee'] as int,
      marketFeeAddress: json['marketFeeAddress'] as int,
    );

Map<String, dynamic> _$$OperationsImplToJson(_$OperationsImpl instance) =>
    <String, dynamic>{
      'exchangeId': const Uint8ListConverter().toJson(instance.exchangeId),
      'source': instance.source,
      'operation': _$OperationTypeEnumMap[instance.operation]!,
      'tokenIn': instance.tokenIn,
      'amountsIn': instance.amountsIn,
      'tokenOut': instance.tokenOut,
      'amountsOut': instance.amountsOut,
      'maxPrice': instance.maxPrice,
      'swapMarketFee': instance.swapMarketFee,
      'marketFeeAddress': instance.marketFeeAddress,
    };

const _$OperationTypeEnumMap = {
  OperationType.SwapExactIn: 'SwapExactIn',
  OperationType.SwapExactOut: 'SwapExactOut',
  OperationType.FixedRate: 'FixedRate',
  OperationType.Dispenser: 'Dispenser',
};
