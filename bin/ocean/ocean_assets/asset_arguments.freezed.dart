// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_arguments.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AssetArguments<T> _$AssetArgumentsFromJson<T>(Map<String, dynamic> json) {
  return _AssetArguments<T>.fromJson(json);
}

/// @nodoc
mixin _$AssetArguments<T> {
  bool get waitForAqua => throw _privateConstructorUsedError;
  int? get dtTemplateIndex => throw _privateConstructorUsedError;
  T? get pricingSchemaArgs => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  bool get withCompute => throw _privateConstructorUsedError;
  Map<String, dynamic>? get computeValues => throw _privateConstructorUsedError;
  Map<String, dynamic>? get credentials => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssetArgumentsCopyWith<T, AssetArguments<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetArgumentsCopyWith<T, $Res> {
  factory $AssetArgumentsCopyWith(
          AssetArguments<T> value, $Res Function(AssetArguments<T>) then) =
      _$AssetArgumentsCopyWithImpl<T, $Res, AssetArguments<T>>;
  @useResult
  $Res call(
      {bool waitForAqua,
      int? dtTemplateIndex,
      T? pricingSchemaArgs,
      Map<String, dynamic>? metadata,
      bool withCompute,
      Map<String, dynamic>? computeValues,
      Map<String, dynamic>? credentials});
}

/// @nodoc
class _$AssetArgumentsCopyWithImpl<T, $Res, $Val extends AssetArguments<T>>
    implements $AssetArgumentsCopyWith<T, $Res> {
  _$AssetArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waitForAqua = null,
    Object? dtTemplateIndex = freezed,
    Object? pricingSchemaArgs = freezed,
    Object? metadata = freezed,
    Object? withCompute = null,
    Object? computeValues = freezed,
    Object? credentials = freezed,
  }) {
    return _then(_value.copyWith(
      waitForAqua: null == waitForAqua
          ? _value.waitForAqua
          : waitForAqua // ignore: cast_nullable_to_non_nullable
              as bool,
      dtTemplateIndex: freezed == dtTemplateIndex
          ? _value.dtTemplateIndex
          : dtTemplateIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      pricingSchemaArgs: freezed == pricingSchemaArgs
          ? _value.pricingSchemaArgs
          : pricingSchemaArgs // ignore: cast_nullable_to_non_nullable
              as T?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      withCompute: null == withCompute
          ? _value.withCompute
          : withCompute // ignore: cast_nullable_to_non_nullable
              as bool,
      computeValues: freezed == computeValues
          ? _value.computeValues
          : computeValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      credentials: freezed == credentials
          ? _value.credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssetArgumentsImplCopyWith<T, $Res>
    implements $AssetArgumentsCopyWith<T, $Res> {
  factory _$$AssetArgumentsImplCopyWith(_$AssetArgumentsImpl<T> value,
          $Res Function(_$AssetArgumentsImpl<T>) then) =
      __$$AssetArgumentsImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call(
      {bool waitForAqua,
      int? dtTemplateIndex,
      T? pricingSchemaArgs,
      Map<String, dynamic>? metadata,
      bool withCompute,
      Map<String, dynamic>? computeValues,
      Map<String, dynamic>? credentials});
}

/// @nodoc
class __$$AssetArgumentsImplCopyWithImpl<T, $Res>
    extends _$AssetArgumentsCopyWithImpl<T, $Res, _$AssetArgumentsImpl<T>>
    implements _$$AssetArgumentsImplCopyWith<T, $Res> {
  __$$AssetArgumentsImplCopyWithImpl(_$AssetArgumentsImpl<T> _value,
      $Res Function(_$AssetArgumentsImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waitForAqua = null,
    Object? dtTemplateIndex = freezed,
    Object? pricingSchemaArgs = freezed,
    Object? metadata = freezed,
    Object? withCompute = null,
    Object? computeValues = freezed,
    Object? credentials = freezed,
  }) {
    return _then(_$AssetArgumentsImpl<T>(
      waitForAqua: null == waitForAqua
          ? _value.waitForAqua
          : waitForAqua // ignore: cast_nullable_to_non_nullable
              as bool,
      dtTemplateIndex: freezed == dtTemplateIndex
          ? _value.dtTemplateIndex
          : dtTemplateIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      pricingSchemaArgs: freezed == pricingSchemaArgs
          ? _value.pricingSchemaArgs
          : pricingSchemaArgs // ignore: cast_nullable_to_non_nullable
              as T?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      withCompute: null == withCompute
          ? _value.withCompute
          : withCompute // ignore: cast_nullable_to_non_nullable
              as bool,
      computeValues: freezed == computeValues
          ? _value._computeValues
          : computeValues // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      credentials: freezed == credentials
          ? _value._credentials
          : credentials // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetArgumentsImpl<T> implements _AssetArguments<T> {
  const _$AssetArgumentsImpl(
      {this.waitForAqua = true,
      this.dtTemplateIndex = 1,
      this.pricingSchemaArgs,
      final Map<String, dynamic>? metadata,
      this.withCompute = false,
      final Map<String, dynamic>? computeValues,
      final Map<String, dynamic>? credentials})
      : _metadata = metadata,
        _computeValues = computeValues,
        _credentials = credentials;

  factory _$AssetArgumentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetArgumentsImplFromJson(json);

  @override
  @JsonKey()
  final bool waitForAqua;
  @override
  @JsonKey()
  final int? dtTemplateIndex;
  @override
  final T? pricingSchemaArgs;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool withCompute;
  final Map<String, dynamic>? _computeValues;
  @override
  Map<String, dynamic>? get computeValues {
    final value = _computeValues;
    if (value == null) return null;
    if (_computeValues is EqualUnmodifiableMapView) return _computeValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _credentials;
  @override
  Map<String, dynamic>? get credentials {
    final value = _credentials;
    if (value == null) return null;
    if (_credentials is EqualUnmodifiableMapView) return _credentials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'AssetArguments<$T>(waitForAqua: $waitForAqua, dtTemplateIndex: $dtTemplateIndex, pricingSchemaArgs: $pricingSchemaArgs, metadata: $metadata, withCompute: $withCompute, computeValues: $computeValues, credentials: $credentials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetArgumentsImpl<T> &&
            (identical(other.waitForAqua, waitForAqua) ||
                other.waitForAqua == waitForAqua) &&
            (identical(other.dtTemplateIndex, dtTemplateIndex) ||
                other.dtTemplateIndex == dtTemplateIndex) &&
            const DeepCollectionEquality()
                .equals(other.pricingSchemaArgs, pricingSchemaArgs) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.withCompute, withCompute) ||
                other.withCompute == withCompute) &&
            const DeepCollectionEquality()
                .equals(other._computeValues, _computeValues) &&
            const DeepCollectionEquality()
                .equals(other._credentials, _credentials));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      waitForAqua,
      dtTemplateIndex,
      const DeepCollectionEquality().hash(pricingSchemaArgs),
      const DeepCollectionEquality().hash(_metadata),
      withCompute,
      const DeepCollectionEquality().hash(_computeValues),
      const DeepCollectionEquality().hash(_credentials));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetArgumentsImplCopyWith<T, _$AssetArgumentsImpl<T>> get copyWith =>
      __$$AssetArgumentsImplCopyWithImpl<T, _$AssetArgumentsImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetArgumentsImplToJson<T>(
      this,
    );
  }
}

abstract class _AssetArguments<T> implements AssetArguments<T> {
  const factory _AssetArguments(
      {final bool waitForAqua,
      final int? dtTemplateIndex,
      final T? pricingSchemaArgs,
      final Map<String, dynamic>? metadata,
      final bool withCompute,
      final Map<String, dynamic>? computeValues,
      final Map<String, dynamic>? credentials}) = _$AssetArgumentsImpl<T>;

  factory _AssetArguments.fromJson(Map<String, dynamic> json) =
      _$AssetArgumentsImpl<T>.fromJson;

  @override
  bool get waitForAqua;
  @override
  int? get dtTemplateIndex;
  @override
  T? get pricingSchemaArgs;
  @override
  Map<String, dynamic>? get metadata;
  @override
  bool get withCompute;
  @override
  Map<String, dynamic>? get computeValues;
  @override
  Map<String, dynamic>? get credentials;
  @override
  @JsonKey(ignore: true)
  _$$AssetArgumentsImplCopyWith<T, _$AssetArgumentsImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
