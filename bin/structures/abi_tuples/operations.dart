import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_convert/uint8_list_converter.dart';

part 'operations.freezed.dart';
part 'operations.g.dart';

@freezed
class Operations with _$Operations {
  const factory Operations({
    @Uint8ListConverter() required Uint8List exchangeId,
    required String source,
    required OperationType operation,
    required String tokenIn,
    required int amountsIn,
    required String tokenOut,
    required int amountsOut,
    required int maxPrice,
    required int swapMarketFee,
    required int marketFeeAddress,
  }) = _Operations;

  factory Operations.fromJson(Map<String, dynamic> json) =>
      _$OperationsFromJson(json);
}

enum OperationType {
  SwapExactIn,
  SwapExactOut,
  FixedRate,
  Dispenser,
}
