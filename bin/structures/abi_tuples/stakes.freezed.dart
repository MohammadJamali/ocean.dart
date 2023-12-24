// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stakes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Stakes _$StakesFromJson(Map<String, dynamic> json) {
  return _Stakes.fromJson(json);
}

/// @nodoc
mixin _$Stakes {
  String get poolAddress => throw _privateConstructorUsedError;
  int get tokenAmountIn => throw _privateConstructorUsedError;
  int get minPoolAmountOut => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StakesCopyWith<Stakes> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StakesCopyWith<$Res> {
  factory $StakesCopyWith(Stakes value, $Res Function(Stakes) then) =
      _$StakesCopyWithImpl<$Res, Stakes>;
  @useResult
  $Res call({String poolAddress, int tokenAmountIn, int minPoolAmountOut});
}

/// @nodoc
class _$StakesCopyWithImpl<$Res, $Val extends Stakes>
    implements $StakesCopyWith<$Res> {
  _$StakesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? tokenAmountIn = null,
    Object? minPoolAmountOut = null,
  }) {
    return _then(_value.copyWith(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAmountIn: null == tokenAmountIn
          ? _value.tokenAmountIn
          : tokenAmountIn // ignore: cast_nullable_to_non_nullable
              as int,
      minPoolAmountOut: null == minPoolAmountOut
          ? _value.minPoolAmountOut
          : minPoolAmountOut // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StakesImplCopyWith<$Res> implements $StakesCopyWith<$Res> {
  factory _$$StakesImplCopyWith(
          _$StakesImpl value, $Res Function(_$StakesImpl) then) =
      __$$StakesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String poolAddress, int tokenAmountIn, int minPoolAmountOut});
}

/// @nodoc
class __$$StakesImplCopyWithImpl<$Res>
    extends _$StakesCopyWithImpl<$Res, _$StakesImpl>
    implements _$$StakesImplCopyWith<$Res> {
  __$$StakesImplCopyWithImpl(
      _$StakesImpl _value, $Res Function(_$StakesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? poolAddress = null,
    Object? tokenAmountIn = null,
    Object? minPoolAmountOut = null,
  }) {
    return _then(_$StakesImpl(
      poolAddress: null == poolAddress
          ? _value.poolAddress
          : poolAddress // ignore: cast_nullable_to_non_nullable
              as String,
      tokenAmountIn: null == tokenAmountIn
          ? _value.tokenAmountIn
          : tokenAmountIn // ignore: cast_nullable_to_non_nullable
              as int,
      minPoolAmountOut: null == minPoolAmountOut
          ? _value.minPoolAmountOut
          : minPoolAmountOut // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StakesImpl implements _Stakes {
  const _$StakesImpl(
      {required this.poolAddress,
      required this.tokenAmountIn,
      required this.minPoolAmountOut});

  factory _$StakesImpl.fromJson(Map<String, dynamic> json) =>
      _$$StakesImplFromJson(json);

  @override
  final String poolAddress;
  @override
  final int tokenAmountIn;
  @override
  final int minPoolAmountOut;

  @override
  String toString() {
    return 'Stakes(poolAddress: $poolAddress, tokenAmountIn: $tokenAmountIn, minPoolAmountOut: $minPoolAmountOut)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StakesImpl &&
            (identical(other.poolAddress, poolAddress) ||
                other.poolAddress == poolAddress) &&
            (identical(other.tokenAmountIn, tokenAmountIn) ||
                other.tokenAmountIn == tokenAmountIn) &&
            (identical(other.minPoolAmountOut, minPoolAmountOut) ||
                other.minPoolAmountOut == minPoolAmountOut));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, poolAddress, tokenAmountIn, minPoolAmountOut);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StakesImplCopyWith<_$StakesImpl> get copyWith =>
      __$$StakesImplCopyWithImpl<_$StakesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StakesImplToJson(
      this,
    );
  }
}

abstract class _Stakes implements Stakes {
  const factory _Stakes(
      {required final String poolAddress,
      required final int tokenAmountIn,
      required final int minPoolAmountOut}) = _$StakesImpl;

  factory _Stakes.fromJson(Map<String, dynamic> json) = _$StakesImpl.fromJson;

  @override
  String get poolAddress;
  @override
  int get tokenAmountIn;
  @override
  int get minPoolAmountOut;
  @override
  @JsonKey(ignore: true)
  _$$StakesImplCopyWith<_$StakesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
