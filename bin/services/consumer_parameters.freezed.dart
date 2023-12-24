// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'consumer_parameters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConsumerParameters _$ConsumerParametersFromJson(Map<String, dynamic> json) {
  return _ConsumerParameters.fromJson(json);
}

/// @nodoc
mixin _$ConsumerParameters {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  bool get required => throw _privateConstructorUsedError;
  String get defaultVal => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String>? get options => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConsumerParametersCopyWith<ConsumerParameters> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConsumerParametersCopyWith<$Res> {
  factory $ConsumerParametersCopyWith(
          ConsumerParameters value, $Res Function(ConsumerParameters) then) =
      _$ConsumerParametersCopyWithImpl<$Res, ConsumerParameters>;
  @useResult
  $Res call(
      {String name,
      String type,
      String label,
      bool required,
      String defaultVal,
      String description,
      List<String>? options});
}

/// @nodoc
class _$ConsumerParametersCopyWithImpl<$Res, $Val extends ConsumerParameters>
    implements $ConsumerParametersCopyWith<$Res> {
  _$ConsumerParametersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? label = null,
    Object? required = null,
    Object? defaultVal = null,
    Object? description = null,
    Object? options = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultVal: null == defaultVal
          ? _value.defaultVal
          : defaultVal // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConsumerParametersImplCopyWith<$Res>
    implements $ConsumerParametersCopyWith<$Res> {
  factory _$$ConsumerParametersImplCopyWith(_$ConsumerParametersImpl value,
          $Res Function(_$ConsumerParametersImpl) then) =
      __$$ConsumerParametersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String type,
      String label,
      bool required,
      String defaultVal,
      String description,
      List<String>? options});
}

/// @nodoc
class __$$ConsumerParametersImplCopyWithImpl<$Res>
    extends _$ConsumerParametersCopyWithImpl<$Res, _$ConsumerParametersImpl>
    implements _$$ConsumerParametersImplCopyWith<$Res> {
  __$$ConsumerParametersImplCopyWithImpl(_$ConsumerParametersImpl _value,
      $Res Function(_$ConsumerParametersImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
    Object? label = null,
    Object? required = null,
    Object? defaultVal = null,
    Object? description = null,
    Object? options = freezed,
  }) {
    return _then(_$ConsumerParametersImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      required: null == required
          ? _value.required
          : required // ignore: cast_nullable_to_non_nullable
              as bool,
      defaultVal: null == defaultVal
          ? _value.defaultVal
          : defaultVal // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConsumerParametersImpl implements _ConsumerParameters {
  const _$ConsumerParametersImpl(
      {required this.name,
      required this.type,
      required this.label,
      required this.required,
      required this.defaultVal,
      required this.description,
      final List<String>? options})
      : _options = options;

  factory _$ConsumerParametersImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConsumerParametersImplFromJson(json);

  @override
  final String name;
  @override
  final String type;
  @override
  final String label;
  @override
  final bool required;
  @override
  final String defaultVal;
  @override
  final String description;
  final List<String>? _options;
  @override
  List<String>? get options {
    final value = _options;
    if (value == null) return null;
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ConsumerParameters(name: $name, type: $type, label: $label, required: $required, defaultVal: $defaultVal, description: $description, options: $options)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsumerParametersImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.required, required) ||
                other.required == required) &&
            (identical(other.defaultVal, defaultVal) ||
                other.defaultVal == defaultVal) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._options, _options));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, type, label, required,
      defaultVal, description, const DeepCollectionEquality().hash(_options));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConsumerParametersImplCopyWith<_$ConsumerParametersImpl> get copyWith =>
      __$$ConsumerParametersImplCopyWithImpl<_$ConsumerParametersImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConsumerParametersImplToJson(
      this,
    );
  }
}

abstract class _ConsumerParameters implements ConsumerParameters {
  const factory _ConsumerParameters(
      {required final String name,
      required final String type,
      required final String label,
      required final bool required,
      required final String defaultVal,
      required final String description,
      final List<String>? options}) = _$ConsumerParametersImpl;

  factory _ConsumerParameters.fromJson(Map<String, dynamic> json) =
      _$ConsumerParametersImpl.fromJson;

  @override
  String get name;
  @override
  String get type;
  @override
  String get label;
  @override
  bool get required;
  @override
  String get defaultVal;
  @override
  String get description;
  @override
  List<String>? get options;
  @override
  @JsonKey(ignore: true)
  _$$ConsumerParametersImplCopyWith<_$ConsumerParametersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
