import 'package:freezed_annotation/freezed_annotation.dart';

part 'stakes.freezed.dart';
part 'stakes.g.dart';

@freezed
class Stakes with _$Stakes {
  const factory Stakes({
    required String poolAddress,
    required int tokenAmountIn,
    required int minPoolAmountOut,
  }) = _Stakes;

  factory Stakes.fromJson(Map<String, dynamic> json) => _$StakesFromJson(json);
}
