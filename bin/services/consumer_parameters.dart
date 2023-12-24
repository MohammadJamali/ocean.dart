import 'package:freezed_annotation/freezed_annotation.dart';

part 'consumer_parameters.freezed.dart';
part 'consumer_parameters.g.dart';

@freezed
class ConsumerParameters with _$ConsumerParameters {
  const factory ConsumerParameters({
    required String name,
    required String type,
    required String label,
    required bool required,
    required String defaultVal,
    required String description,
    List<String>? options,
  }) = _ConsumerParameters;

  factory ConsumerParameters.fromJson(Map<String, dynamic> json) =>
      _$ConsumerParametersFromJson(json);
}
