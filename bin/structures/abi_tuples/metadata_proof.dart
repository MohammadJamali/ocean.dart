import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/json_convert/uint8_list_converter.dart';

part 'metadata_proof.freezed.dart';
part 'metadata_proof.g.dart';

@freezed
class MetadataProof with _$MetadataProof {
  const factory MetadataProof({
    required String validatorAddress,
    required int v,
    @Uint8ListConverter() required Uint8List r,
    @Uint8ListConverter() required Uint8List s,
  }) = _MetadataProof;

  factory MetadataProof.fromJson(Map<String, dynamic> json) =>
      _$MetadataProofFromJson(json);
}
