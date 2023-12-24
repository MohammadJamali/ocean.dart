import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_data.freezed.dart';
part 'order_data.g.dart';

@freezed
class OrderData with _$OrderData {
  const factory OrderData({
    required String tokenAddress,
    required String consumer,
    required int serviceIndex,
    required (List<int>, List<int>) providerFees,
    required (List<int>, List<int>) consumeFees,
  }) = _OrderData;

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);
}
