// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderData _$OrderDataFromJson(Map<String, dynamic> json) {
  return _OrderData.fromJson(json);
}

/// @nodoc
mixin _$OrderData {
  String get tokenAddress => throw _privateConstructorUsedError;
  String get consumer => throw _privateConstructorUsedError;
  int get serviceIndex => throw _privateConstructorUsedError;
  (List<int>, List<int>) get providerFees => throw _privateConstructorUsedError;
  (List<int>, List<int>) get consumeFees => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderDataCopyWith<OrderData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDataCopyWith<$Res> {
  factory $OrderDataCopyWith(OrderData value, $Res Function(OrderData) then) =
      _$OrderDataCopyWithImpl<$Res, OrderData>;
  @useResult
  $Res call(
      {String tokenAddress,
      String consumer,
      int serviceIndex,
      (List<int>, List<int>) providerFees,
      (List<int>, List<int>) consumeFees});
}

/// @nodoc
class _$OrderDataCopyWithImpl<$Res, $Val extends OrderData>
    implements $OrderDataCopyWith<$Res> {
  _$OrderDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenAddress = null,
    Object? consumer = null,
    Object? serviceIndex = null,
    Object? providerFees = null,
    Object? consumeFees = null,
  }) {
    return _then(_value.copyWith(
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      consumer: null == consumer
          ? _value.consumer
          : consumer // ignore: cast_nullable_to_non_nullable
              as String,
      serviceIndex: null == serviceIndex
          ? _value.serviceIndex
          : serviceIndex // ignore: cast_nullable_to_non_nullable
              as int,
      providerFees: null == providerFees
          ? _value.providerFees
          : providerFees // ignore: cast_nullable_to_non_nullable
              as (List<int>, List<int>),
      consumeFees: null == consumeFees
          ? _value.consumeFees
          : consumeFees // ignore: cast_nullable_to_non_nullable
              as (List<int>, List<int>),
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OrderDataImplCopyWith<$Res>
    implements $OrderDataCopyWith<$Res> {
  factory _$$OrderDataImplCopyWith(
          _$OrderDataImpl value, $Res Function(_$OrderDataImpl) then) =
      __$$OrderDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tokenAddress,
      String consumer,
      int serviceIndex,
      (List<int>, List<int>) providerFees,
      (List<int>, List<int>) consumeFees});
}

/// @nodoc
class __$$OrderDataImplCopyWithImpl<$Res>
    extends _$OrderDataCopyWithImpl<$Res, _$OrderDataImpl>
    implements _$$OrderDataImplCopyWith<$Res> {
  __$$OrderDataImplCopyWithImpl(
      _$OrderDataImpl _value, $Res Function(_$OrderDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenAddress = null,
    Object? consumer = null,
    Object? serviceIndex = null,
    Object? providerFees = null,
    Object? consumeFees = null,
  }) {
    return _then(_$OrderDataImpl(
      tokenAddress: null == tokenAddress
          ? _value.tokenAddress
          : tokenAddress // ignore: cast_nullable_to_non_nullable
              as String,
      consumer: null == consumer
          ? _value.consumer
          : consumer // ignore: cast_nullable_to_non_nullable
              as String,
      serviceIndex: null == serviceIndex
          ? _value.serviceIndex
          : serviceIndex // ignore: cast_nullable_to_non_nullable
              as int,
      providerFees: null == providerFees
          ? _value.providerFees
          : providerFees // ignore: cast_nullable_to_non_nullable
              as (List<int>, List<int>),
      consumeFees: null == consumeFees
          ? _value.consumeFees
          : consumeFees // ignore: cast_nullable_to_non_nullable
              as (List<int>, List<int>),
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderDataImpl implements _OrderData {
  const _$OrderDataImpl(
      {required this.tokenAddress,
      required this.consumer,
      required this.serviceIndex,
      required this.providerFees,
      required this.consumeFees});

  factory _$OrderDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderDataImplFromJson(json);

  @override
  final String tokenAddress;
  @override
  final String consumer;
  @override
  final int serviceIndex;
  @override
  final (List<int>, List<int>) providerFees;
  @override
  final (List<int>, List<int>) consumeFees;

  @override
  String toString() {
    return 'OrderData(tokenAddress: $tokenAddress, consumer: $consumer, serviceIndex: $serviceIndex, providerFees: $providerFees, consumeFees: $consumeFees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderDataImpl &&
            (identical(other.tokenAddress, tokenAddress) ||
                other.tokenAddress == tokenAddress) &&
            (identical(other.consumer, consumer) ||
                other.consumer == consumer) &&
            (identical(other.serviceIndex, serviceIndex) ||
                other.serviceIndex == serviceIndex) &&
            (identical(other.providerFees, providerFees) ||
                other.providerFees == providerFees) &&
            (identical(other.consumeFees, consumeFees) ||
                other.consumeFees == consumeFees));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, tokenAddress, consumer,
      serviceIndex, providerFees, consumeFees);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderDataImplCopyWith<_$OrderDataImpl> get copyWith =>
      __$$OrderDataImplCopyWithImpl<_$OrderDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderDataImplToJson(
      this,
    );
  }
}

abstract class _OrderData implements OrderData {
  const factory _OrderData(
      {required final String tokenAddress,
      required final String consumer,
      required final int serviceIndex,
      required final (List<int>, List<int>) providerFees,
      required final (List<int>, List<int>) consumeFees}) = _$OrderDataImpl;

  factory _OrderData.fromJson(Map<String, dynamic> json) =
      _$OrderDataImpl.fromJson;

  @override
  String get tokenAddress;
  @override
  String get consumer;
  @override
  int get serviceIndex;
  @override
  (List<int>, List<int>) get providerFees;
  @override
  (List<int>, List<int>) get consumeFees;
  @override
  @JsonKey(ignore: true)
  _$$OrderDataImplCopyWith<_$OrderDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
