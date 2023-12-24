import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset_arguments.freezed.dart';
part 'asset_arguments.g.dart';

@freezed
class AssetArguments with _$AssetArguments {
  factory AssetArguments({
    @Default(true) bool waitForAqua,
    @Default(1) int dtTemplateIndex,
    PricingSchemaArgs?
        pricingSchemaArgs, // Define this class based on the possible types (DispenserArguments, ExchangeArguments)
    Map<String, dynamic>? metadata,
    @Default(false) bool withCompute,
    Map<String, dynamic>? computeValues,
    Map<String, dynamic>? credentials,
  }) = _AssetArguments;

  factory AssetArguments.fromJson(Map<String, dynamic> json) =>
      _$AssetArgumentsFromJson(json);
}
