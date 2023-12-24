import 'package:freezed_annotation/freezed_annotation.dart';

part 'reuse_order_data.freezed.dart';
part 'reuse_order_data.g.dart';

@freezed
class ReuseOrderData with _$ReuseOrderData {
  const factory ReuseOrderData({
    required String tokenAddress,
    required String orderTxId,
    required (List<int>, List<int>) providerFees,
  }) = _ReuseOrderData;

  factory ReuseOrderData.fromJson(Map<String, dynamic> json) =>
      _$ReuseOrderDataFromJson(json);
}
