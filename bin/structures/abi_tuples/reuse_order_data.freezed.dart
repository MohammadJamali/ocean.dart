// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reuse_order_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReuseOrderData _$ReuseOrderDataFromJson(Map<String, dynamic> json) {
  return _ReuseOrderData.fromJson(json);
}

/// @nodoc
mixin _$ReuseOrderData {
  String get tokenAddress => throw _privateConstructorUsedError;
  String get orderTxId => throw _privateConstructorUsedError;
  (List<int>, List<int>) get providerFees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReuseOrderDataCopyWith<ReuseOrderData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReuseOrderDataCopyWith<$Res> {
  factory $ReuseOrderDataCopyWith(
          ReuseOrderData value, $Res Function(ReuseOrderData) then) =
      _$ReuseOrderDataCopyWithImpl<$Res, ReuseOrderData>;
  @useResult
  $Res call(
      {String tokenAddress,
      String orderTxId,
      (List<int>, List<int>) providerFees});
}

/// @nodoc
class _$ReuseOrderDataCopyWithImpl<$Res, $Val extends ReuseOrderData>
    implements $ReuseOrderDataCopyWith<$Res> {
  _$ReuseOrderDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenAddress = null,
    Object? orderTxId = null,
    Object? providerFees = null,
  }) {
    return _then(_value.copyWith(
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      orderTxId: null == orderTxId
          ? _value.orderTxId
          : orderTxId // ignore: cast_nullable_to_non_nullable
              as String,
      providerFees: null == providerFees
          ? _value.providerFees
          : providerFees // ignore: cast_nullable_to_non_nullable
              as (List<int>, List<int>),
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReuseOrderDataImplCopyWith<$Res>
    implements $ReuseOrderDataCopyWith<$Res> {
  factory _$$ReuseOrderDataImplCopyWith(_$ReuseOrderDataImpl value,
          $Res Function(_$ReuseOrderDataImpl) then) =
      __$$ReuseOrderDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tokenAddress,
      String orderTxId,
      (List<int>, List<int>) providerFees});
}

/// @nodoc
class __$$ReuseOrderDataImplCopyWithImpl<$Res>
    extends _$ReuseOrderDataCopyWithImpl<$Res, _$ReuseOrderDataImpl>
    implements _$$ReuseOrderDataImplCopyWith<$Res> {
  __$$ReuseOrderDataImplCopyWithImpl(
      _$ReuseOrderDataImpl _value, $Res Function(_$ReuseOrderDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenAddress = null,
    Object? orderTxId = null,
    Object? providerFees = null,
  }) {
    return _then(_$ReuseOrderDataImpl(
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      orderTxId: null == orderTxId
          ? _value.orderTxId
          : orderTxId // ignore: cast_nullable_to_non_nullable
              as String,
      providerFees: null == providerFees
          ? _value.providerFees
          : providerFees // ignore: cast_nullable_to_non_nullable
              as (List<int>, List<int>),
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReuseOrderDataImpl implements _ReuseOrderData {
  const _$ReuseOrderDataImpl(
      {required this.tokenAddress,
      required this.orderTxId,
      required this.providerFees});

  factory _$ReuseOrderDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReuseOrderDataImplFromJson(json);

  @override
  final String tokenAddress;
  @override
  final String orderTxId;
  @override
  final (List<int>, List<int>) providerFees;

  @override
  String toString() {
    return 'ReuseOrderData(tokenAddress: $tokenAddress, orderTxId: $orderTxId, providerFees: $providerFees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReuseOrderDataImpl &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.orderTxId, orderTxId) ||
                other.orderTxId == orderTxId) &&
            (identical(other.providerFees, providerFees) ||
                other.providerFees == providerFees));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, tokenAddress, orderTxId, providerFees);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReuseOrderDataImplCopyWith<_$ReuseOrderDataImpl> get copyWith =>
      __$$ReuseOrderDataImplCopyWithImpl<_$ReuseOrderDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReuseOrderDataImplToJson(
      this,
    );
  }
}

abstract class _ReuseOrderData implements ReuseOrderData {
  const factory _ReuseOrderData(
          {required final String tokenAddress,
          required final String orderTxId,
          required final (List<int>, List<int>) providerFees}) =
      _$ReuseOrderDataImpl;

  factory _ReuseOrderData.fromJson(Map<String, dynamic> json) =
      _$ReuseOrderDataImpl.fromJson;

  @override
  String get tokenAddress;
  @override
  String get orderTxId;
  @override
  (List<int>, List<int>) get providerFees;
  @override
  @JsonKey(ignore: true)
  _$$ReuseOrderDataImplCopyWith<_$ReuseOrderDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
