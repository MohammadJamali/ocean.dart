import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/dispenser.dart';
import '../../models/fixed_rate_exchange.dart';

part 'asset_arguments.freezed.dart';
part 'asset_arguments.g.dart';

@freezed
class AssetArguments<T> with _$AssetArguments {
  const factory AssetArguments({
    @Default(true) bool waitForAqua,
    @Default(1) int? dtTemplateIndex,
    T? pricingSchemaArgs,
    Map<String, dynamic>? metadata,
    @Default(false) bool withCompute,
    Map<String, dynamic>? computeValues,
    Map<String, dynamic>? credentials,
  }) = _AssetArguments<T>;

  factory AssetArguments.fromJson(Map<String, dynamic> json) =>
      _$AssetArgumentsFromJson<T>(json);
}

mixin ExchangeAssetArguments implements AssetArguments<ExchangeArguments> {}

mixin DispenserAssetArguments implements AssetArguments<DispenserArguments> {}
