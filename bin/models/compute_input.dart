import 'package:freezed_annotation/freezed_annotation.dart';

import '../assets/ddo/ddo.dart';
import '../services/service.dart';
import '../web3_internal/constants.dart';

@freezed
class ComputeInput with _$ComputeInput {
  const factory ComputeInput({
    required DDO ddo,
    required Service service,
    @Default(null) dynamic transferTxId,
    @Default(<String, dynamic>{}) Map<String, dynamic> userdata,
    @Default(ZERO_ADDRESS) String consumeMarketOrderFeeToken,
    @Default(0) int consumeMarketOrderFeeAmount,
  }) = _ComputeInput;

  factory ComputeInput.fromJson(Map<String, dynamic> json) =>
      _$ComputeInputFromJson(json);
}
