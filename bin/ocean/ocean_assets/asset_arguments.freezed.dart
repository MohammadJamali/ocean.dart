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

AssetArguments _$AssetArgumentsFromJson(Map<String, dynamic> json) {
  return _AssetArguments.fromJson(json);
}

/// @nodoc
mixin _$AssetArguments {
  bool get waitForAqua => throw _privateConstructorUsedError;
  int get dtTemplateIndex => throw _privateConstructorUsedError;
  PricingSchemaArgs? get pricingSchemaArgs =>
      throw _privateConstructorUsedError; // Define this class based on the possible types (DispenserArguments, ExchangeArguments)
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  bool get withCompute => throw _privateConstructorUsedError;
  Map<String, dynamic>? get computeValues => throw _privateConstructorUsedError;
  Map<String, dynamic>? get credentials => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssetArgumentsCopyWith<AssetArguments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetArgumentsCopyWith<$Res> {
  factory $AssetArgumentsCopyWith(
          AssetArguments value, $Res Function(AssetArguments) then) =
      _$AssetArgumentsCopyWithImpl<$Res, AssetArguments>;
  @useResult
  $Res call(
      {bool waitForAqua,
      int dtTemplateIndex,
      PricingSchemaArgs? pricingSchemaArgs,
      Map<String, dynamic>? metadata,
      bool withCompute,
      Map<String, dynamic>? computeValues,
      Map<String, dynamic>? credentials});
}

/// @nodoc
class _$AssetArgumentsCopyWithImpl<$Res, $Val extends AssetArguments>
    implements $AssetArgumentsCopyWith<$Res> {
  _$AssetArgumentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waitForAqua = null,
    Object? dtTemplateIndex = null,
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
      dtTemplateIndex: null == dtTemplateIndex
          ? _value.dtTemplateIndex
          : dtTemplateIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pricingSchemaArgs: freezed == pricingSchemaArgs
          ? _value.pricingSchemaArgs
          : pricingSchemaArgs // ignore: cast_nullable_to_non_nullable
              as PricingSchemaArgs?,
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
abstract class _$$AssetArgumentsImplCopyWith<$Res>
    implements $AssetArgumentsCopyWith<$Res> {
  factory _$$AssetArgumentsImplCopyWith(_$AssetArgumentsImpl value,
          $Res Function(_$AssetArgumentsImpl) then) =
      __$$AssetArgumentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool waitForAqua,
      int dtTemplateIndex,
      PricingSchemaArgs? pricingSchemaArgs,
      Map<String, dynamic>? metadata,
      bool withCompute,
      Map<String, dynamic>? computeValues,
      Map<String, dynamic>? credentials});
}

/// @nodoc
class __$$AssetArgumentsImplCopyWithImpl<$Res>
    extends _$AssetArgumentsCopyWithImpl<$Res, _$AssetArgumentsImpl>
    implements _$$AssetArgumentsImplCopyWith<$Res> {
  __$$AssetArgumentsImplCopyWithImpl(
      _$AssetArgumentsImpl _value, $Res Function(_$AssetArgumentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? waitForAqua = null,
    Object? dtTemplateIndex = null,
    Object? pricingSchemaArgs = freezed,
    Object? metadata = freezed,
    Object? withCompute = null,
    Object? computeValues = freezed,
    Object? credentials = freezed,
  }) {
    return _then(_$AssetArgumentsImpl(
      waitForAqua: null == waitForAqua
          ? _value.waitForAqua
          : waitForAqua // ignore: cast_nullable_to_non_nullable
              as bool,
      dtTemplateIndex: null == dtTemplateIndex
          ? _value.dtTemplateIndex
          : dtTemplateIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pricingSchemaArgs: freezed == pricingSchemaArgs
          ? _value.pricingSchemaArgs
          : pricingSchemaArgs // ignore: cast_nullable_to_non_nullable
              as PricingSchemaArgs?,
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
class _$AssetArgumentsImpl implements _AssetArguments {
  _$AssetArgumentsImpl(
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
  final int dtTemplateIndex;
  @override
  final PricingSchemaArgs? pricingSchemaArgs;
// Define this class based on the possible types (DispenserArguments, ExchangeArguments)
  final Map<String, dynamic>? _metadata;
// Define this class based on the possible types (DispenserArguments, ExchangeArguments)
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
    return 'AssetArguments(waitForAqua: $waitForAqua, dtTemplateIndex: $dtTemplateIndex, pricingSchemaArgs: $pricingSchemaArgs, metadata: $metadata, withCompute: $withCompute, computeValues: $computeValues, credentials: $credentials)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetArgumentsImpl &&
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
  _$$AssetArgumentsImplCopyWith<_$AssetArgumentsImpl> get copyWith =>
      __$$AssetArgumentsImplCopyWithImpl<_$AssetArgumentsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetArgumentsImplToJson(
      this,
    );
  }
}

abstract class _AssetArguments implements AssetArguments {
  factory _AssetArguments(
      {final bool waitForAqua,
      final int dtTemplateIndex,
      final PricingSchemaArgs? pricingSchemaArgs,
      final Map<String, dynamic>? metadata,
      final bool withCompute,
      final Map<String, dynamic>? computeValues,
      final Map<String, dynamic>? credentials}) = _$AssetArgumentsImpl;

  factory _AssetArguments.fromJson(Map<String, dynamic> json) =
      _$AssetArgumentsImpl.fromJson;

  @override
  bool get waitForAqua;
  @override
  int get dtTemplateIndex;
  @override
  PricingSchemaArgs? get pricingSchemaArgs;
  @override // Define this class based on the possible types (DispenserArguments, ExchangeArguments)
  Map<String, dynamic>? get metadata;
  @override
  bool get withCompute;
  @override
  Map<String, dynamic>? get computeValues;
  @override
  Map<String, dynamic>? get credentials;
  @override
  @JsonKey(ignore: true)
  _$$AssetArgumentsImplCopyWith<_$AssetArgumentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
