// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metadata_proof.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MetadataProof _$MetadataProofFromJson(Map<String, dynamic> json) {
  return _MetadataProof.fromJson(json);
}

/// @nodoc
mixin _$MetadataProof {
  String get validatorAddress => throw _privateConstructorUsedError;
  int get v => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List get r => throw _privateConstructorUsedError;
  @Uint8ListConverter()
  Uint8List get s => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MetadataProofCopyWith<MetadataProof> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetadataProofCopyWith<$Res> {
  factory $MetadataProofCopyWith(
          MetadataProof value, $Res Function(MetadataProof) then) =
      _$MetadataProofCopyWithImpl<$Res, MetadataProof>;
  @useResult
  $Res call(
      {String validatorAddress,
      int v,
      @Uint8ListConverter() Uint8List r,
      @Uint8ListConverter() Uint8List s});
}

/// @nodoc
class _$MetadataProofCopyWithImpl<$Res, $Val extends MetadataProof>
    implements $MetadataProofCopyWith<$Res> {
  _$MetadataProofCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? validatorAddress = null,
    Object? v = null,
    Object? r = null,
    Object? s = null,
  }) {
    return _then(_value.copyWith(
      validatorAddress: null == validatorAddress
          ? _value.validatorAddress
          : validatorAddress // ignore: cast_nullable_to_non_nullable
              as String,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int,
      r: null == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MetadataProofImplCopyWith<$Res>
    implements $MetadataProofCopyWith<$Res> {
  factory _$$MetadataProofImplCopyWith(
          _$MetadataProofImpl value, $Res Function(_$MetadataProofImpl) then) =
      __$$MetadataProofImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String validatorAddress,
      int v,
      @Uint8ListConverter() Uint8List r,
      @Uint8ListConverter() Uint8List s});
}

/// @nodoc
class __$$MetadataProofImplCopyWithImpl<$Res>
    extends _$MetadataProofCopyWithImpl<$Res, _$MetadataProofImpl>
    implements _$$MetadataProofImplCopyWith<$Res> {
  __$$MetadataProofImplCopyWithImpl(
      _$MetadataProofImpl _value, $Res Function(_$MetadataProofImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? validatorAddress = null,
    Object? v = null,
    Object? r = null,
    Object? s = null,
  }) {
    return _then(_$MetadataProofImpl(
      validatorAddress: null == validatorAddress
          ? _value.validatorAddress
          : validatorAddress // ignore: cast_nullable_to_non_nullable
              as String,
      v: null == v
          ? _value.v
          : v // ignore: cast_nullable_to_non_nullable
              as int,
      r: null == r
          ? _value.r
          : r // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as Uint8List,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MetadataProofImpl implements _MetadataProof {
  const _$MetadataProofImpl(
      {required this.validatorAddress,
      required this.v,
      @Uint8ListConverter() required this.r,
      @Uint8ListConverter() required this.s});

  factory _$MetadataProofImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetadataProofImplFromJson(json);

  @override
  final String validatorAddress;
  @override
  final int v;
  @override
  @Uint8ListConverter()
  final Uint8List r;
  @override
  @Uint8ListConverter()
  final Uint8List s;

  @override
  String toString() {
    return 'MetadataProof(validatorAddress: $validatorAddress, v: $v, r: $r, s: $s)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetadataProofImpl &&
            (identical(other.validatorAddress, validatorAddress) ||
                other.validatorAddress == validatorAddress) &&
            (identical(other.v, v) || other.v == v) &&
            const DeepCollectionEquality().equals(other.r, r) &&
            const DeepCollectionEquality().equals(other.s, s));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      validatorAddress,
      v,
      const DeepCollectionEquality().hash(r),
      const DeepCollectionEquality().hash(s));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MetadataProofImplCopyWith<_$MetadataProofImpl> get copyWith =>
      __$$MetadataProofImplCopyWithImpl<_$MetadataProofImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetadataProofImplToJson(
      this,
    );
  }
}

abstract class _MetadataProof implements MetadataProof {
  const factory _MetadataProof(
      {required final String validatorAddress,
      required final int v,
      @Uint8ListConverter() required final Uint8List r,
      @Uint8ListConverter() required final Uint8List s}) = _$MetadataProofImpl;

  factory _MetadataProof.fromJson(Map<String, dynamic> json) =
      _$MetadataProofImpl.fromJson;

  @override
  String get validatorAddress;
  @override
  int get v;
  @override
  @Uint8ListConverter()
  Uint8List get r;
  @override
  @Uint8ListConverter()
  Uint8List get s;
  @override
  @JsonKey(ignore: true)
  _$$MetadataProofImplCopyWith<_$MetadataProofImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
