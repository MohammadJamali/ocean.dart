// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_objects.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UrlFile _$UrlFileFromJson(Map<String, dynamic> json) {
  return _UrlFile.fromJson(json);
}

/// @nodoc
mixin _$UrlFile {
  String get url => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;
  Map<String, String>? get headers => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UrlFileCopyWith<UrlFile> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlFileCopyWith<$Res> {
  factory $UrlFileCopyWith(UrlFile value, $Res Function(UrlFile) then) =
      _$UrlFileCopyWithImpl<$Res, UrlFile>;
  @useResult
  $Res call(
      {String url, String? method, Map<String, String>? headers, String type});
}

/// @nodoc
class _$UrlFileCopyWithImpl<$Res, $Val extends UrlFile>
    implements $UrlFileCopyWith<$Res> {
  _$UrlFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? method = freezed,
    Object? headers = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UrlFileImplCopyWith<$Res> implements $UrlFileCopyWith<$Res> {
  factory _$$UrlFileImplCopyWith(
          _$UrlFileImpl value, $Res Function(_$UrlFileImpl) then) =
      __$$UrlFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url, String? method, Map<String, String>? headers, String type});
}

/// @nodoc
class __$$UrlFileImplCopyWithImpl<$Res>
    extends _$UrlFileCopyWithImpl<$Res, _$UrlFileImpl>
    implements _$$UrlFileImplCopyWith<$Res> {
  __$$UrlFileImplCopyWithImpl(
      _$UrlFileImpl _value, $Res Function(_$UrlFileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? method = freezed,
    Object? headers = freezed,
    Object? type = null,
  }) {
    return _then(_$UrlFileImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UrlFileImpl implements _UrlFile {
  const _$UrlFileImpl(
      {required this.url,
      this.method,
      final Map<String, String>? headers,
      this.type = 'url'})
      : _headers = headers;

  factory _$UrlFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UrlFileImplFromJson(json);

  @override
  final String url;
  @override
  final String? method;
  final Map<String, String>? _headers;
  @override
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'UrlFile(url: $url, method: $method, headers: $headers, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UrlFileImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, method,
      const DeepCollectionEquality().hash(_headers), type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UrlFileImplCopyWith<_$UrlFileImpl> get copyWith =>
      __$$UrlFileImplCopyWithImpl<_$UrlFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UrlFileImplToJson(
      this,
    );
  }
}

abstract class _UrlFile implements UrlFile {
  const factory _UrlFile(
      {required final String url,
      final String? method,
      final Map<String, String>? headers,
      final String type}) = _$UrlFileImpl;

  factory _UrlFile.fromJson(Map<String, dynamic> json) = _$UrlFileImpl.fromJson;

  @override
  String get url;
  @override
  String? get method;
  @override
  Map<String, String>? get headers;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$UrlFileImplCopyWith<_$UrlFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IpfsFile _$IpfsFileFromJson(Map<String, dynamic> json) {
  return _IpfsFile.fromJson(json);
}

/// @nodoc
mixin _$IpfsFile {
  String get hash => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IpfsFileCopyWith<IpfsFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IpfsFileCopyWith<$Res> {
  factory $IpfsFileCopyWith(IpfsFile value, $Res Function(IpfsFile) then) =
      _$IpfsFileCopyWithImpl<$Res, IpfsFile>;
  @useResult
  $Res call({String hash, String type});
}

/// @nodoc
class _$IpfsFileCopyWithImpl<$Res, $Val extends IpfsFile>
    implements $IpfsFileCopyWith<$Res> {
  _$IpfsFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IpfsFileImplCopyWith<$Res>
    implements $IpfsFileCopyWith<$Res> {
  factory _$$IpfsFileImplCopyWith(
          _$IpfsFileImpl value, $Res Function(_$IpfsFileImpl) then) =
      __$$IpfsFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String hash, String type});
}

/// @nodoc
class __$$IpfsFileImplCopyWithImpl<$Res>
    extends _$IpfsFileCopyWithImpl<$Res, _$IpfsFileImpl>
    implements _$$IpfsFileImplCopyWith<$Res> {
  __$$IpfsFileImplCopyWithImpl(
      _$IpfsFileImpl _value, $Res Function(_$IpfsFileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? type = null,
  }) {
    return _then(_$IpfsFileImpl(
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IpfsFileImpl implements _IpfsFile {
  const _$IpfsFileImpl({required this.hash, this.type = 'ipfs'});

  factory _$IpfsFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$IpfsFileImplFromJson(json);

  @override
  final String hash;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'IpfsFile(hash: $hash, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IpfsFileImpl &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, hash, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IpfsFileImplCopyWith<_$IpfsFileImpl> get copyWith =>
      __$$IpfsFileImplCopyWithImpl<_$IpfsFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IpfsFileImplToJson(
      this,
    );
  }
}

abstract class _IpfsFile implements IpfsFile {
  const factory _IpfsFile({required final String hash, final String type}) =
      _$IpfsFileImpl;

  factory _IpfsFile.fromJson(Map<String, dynamic> json) =
      _$IpfsFileImpl.fromJson;

  @override
  String get hash;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$IpfsFileImplCopyWith<_$IpfsFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

GraphqlQuery _$GraphqlQueryFromJson(Map<String, dynamic> json) {
  return _GraphqlQuery.fromJson(json);
}

/// @nodoc
mixin _$GraphqlQuery {
  String get url => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  Map<String, String>? get headers => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GraphqlQueryCopyWith<GraphqlQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GraphqlQueryCopyWith<$Res> {
  factory $GraphqlQueryCopyWith(
          GraphqlQuery value, $Res Function(GraphqlQuery) then) =
      _$GraphqlQueryCopyWithImpl<$Res, GraphqlQuery>;
  @useResult
  $Res call(
      {String url, String query, Map<String, String>? headers, String type});
}

/// @nodoc
class _$GraphqlQueryCopyWithImpl<$Res, $Val extends GraphqlQuery>
    implements $GraphqlQueryCopyWith<$Res> {
  _$GraphqlQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? query = null,
    Object? headers = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      headers: freezed == headers
          ? _value.headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GraphqlQueryImplCopyWith<$Res>
    implements $GraphqlQueryCopyWith<$Res> {
  factory _$$GraphqlQueryImplCopyWith(
          _$GraphqlQueryImpl value, $Res Function(_$GraphqlQueryImpl) then) =
      __$$GraphqlQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url, String query, Map<String, String>? headers, String type});
}

/// @nodoc
class __$$GraphqlQueryImplCopyWithImpl<$Res>
    extends _$GraphqlQueryCopyWithImpl<$Res, _$GraphqlQueryImpl>
    implements _$$GraphqlQueryImplCopyWith<$Res> {
  __$$GraphqlQueryImplCopyWithImpl(
      _$GraphqlQueryImpl _value, $Res Function(_$GraphqlQueryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? query = null,
    Object? headers = freezed,
    Object? type = null,
  }) {
    return _then(_$GraphqlQueryImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      headers: freezed == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GraphqlQueryImpl implements _GraphqlQuery {
  const _$GraphqlQueryImpl(
      {required this.url,
      required this.query,
      final Map<String, String>? headers,
      this.type = 'graphql'})
      : _headers = headers;

  factory _$GraphqlQueryImpl.fromJson(Map<String, dynamic> json) =>
      _$$GraphqlQueryImplFromJson(json);

  @override
  final String url;
  @override
  final String query;
  final Map<String, String>? _headers;
  @override
  Map<String, String>? get headers {
    final value = _headers;
    if (value == null) return null;
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'GraphqlQuery(url: $url, query: $query, headers: $headers, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GraphqlQueryImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, query,
      const DeepCollectionEquality().hash(_headers), type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GraphqlQueryImplCopyWith<_$GraphqlQueryImpl> get copyWith =>
      __$$GraphqlQueryImplCopyWithImpl<_$GraphqlQueryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GraphqlQueryImplToJson(
      this,
    );
  }
}

abstract class _GraphqlQuery implements GraphqlQuery {
  const factory _GraphqlQuery(
      {required final String url,
      required final String query,
      final Map<String, String>? headers,
      final String type}) = _$GraphqlQueryImpl;

  factory _GraphqlQuery.fromJson(Map<String, dynamic> json) =
      _$GraphqlQueryImpl.fromJson;

  @override
  String get url;
  @override
  String get query;
  @override
  Map<String, String>? get headers;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$GraphqlQueryImplCopyWith<_$GraphqlQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SmartContractCall _$SmartContractCallFromJson(Map<String, dynamic> json) {
  return _SmartContractCall.fromJson(json);
}

/// @nodoc
mixin _$SmartContractCall {
  String get address => throw _privateConstructorUsedError;
  int get chainId => throw _privateConstructorUsedError;
  Map<String, dynamic> get abi => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SmartContractCallCopyWith<SmartContractCall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartContractCallCopyWith<$Res> {
  factory $SmartContractCallCopyWith(
          SmartContractCall value, $Res Function(SmartContractCall) then) =
      _$SmartContractCallCopyWithImpl<$Res, SmartContractCall>;
  @useResult
  $Res call(
      {String address, int chainId, Map<String, dynamic> abi, String type});
}

/// @nodoc
class _$SmartContractCallCopyWithImpl<$Res, $Val extends SmartContractCall>
    implements $SmartContractCallCopyWith<$Res> {
  _$SmartContractCallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? chainId = null,
    Object? abi = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      abi: null == abi
          ? _value.abi
          : abi // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SmartContractCallImplCopyWith<$Res>
    implements $SmartContractCallCopyWith<$Res> {
  factory _$$SmartContractCallImplCopyWith(_$SmartContractCallImpl value,
          $Res Function(_$SmartContractCallImpl) then) =
      __$$SmartContractCallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String address, int chainId, Map<String, dynamic> abi, String type});
}

/// @nodoc
class __$$SmartContractCallImplCopyWithImpl<$Res>
    extends _$SmartContractCallCopyWithImpl<$Res, _$SmartContractCallImpl>
    implements _$$SmartContractCallImplCopyWith<$Res> {
  __$$SmartContractCallImplCopyWithImpl(_$SmartContractCallImpl _value,
      $Res Function(_$SmartContractCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? chainId = null,
    Object? abi = null,
    Object? type = null,
  }) {
    return _then(_$SmartContractCallImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int,
      abi: null == abi
          ? _value._abi
          : abi // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SmartContractCallImpl implements _SmartContractCall {
  const _$SmartContractCallImpl(
      {required this.address,
      required this.chainId,
      required final Map<String, dynamic> abi,
      this.type = 'smartcontract'})
      : _abi = abi;

  factory _$SmartContractCallImpl.fromJson(Map<String, dynamic> json) =>
      _$$SmartContractCallImplFromJson(json);

  @override
  final String address;
  @override
  final int chainId;
  final Map<String, dynamic> _abi;
  @override
  Map<String, dynamic> get abi {
    if (_abi is EqualUnmodifiableMapView) return _abi;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_abi);
  }

  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'SmartContractCall(address: $address, chainId: $chainId, abi: $abi, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartContractCallImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            const DeepCollectionEquality().equals(other._abi, _abi) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, address, chainId,
      const DeepCollectionEquality().hash(_abi), type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartContractCallImplCopyWith<_$SmartContractCallImpl> get copyWith =>
      __$$SmartContractCallImplCopyWithImpl<_$SmartContractCallImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SmartContractCallImplToJson(
      this,
    );
  }
}

abstract class _SmartContractCall implements SmartContractCall {
  const factory _SmartContractCall(
      {required final String address,
      required final int chainId,
      required final Map<String, dynamic> abi,
      final String type}) = _$SmartContractCallImpl;

  factory _SmartContractCall.fromJson(Map<String, dynamic> json) =
      _$SmartContractCallImpl.fromJson;

  @override
  String get address;
  @override
  int get chainId;
  @override
  Map<String, dynamic> get abi;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$SmartContractCallImplCopyWith<_$SmartContractCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArweaveFile _$ArweaveFileFromJson(Map<String, dynamic> json) {
  return _ArweaveFile.fromJson(json);
}

/// @nodoc
mixin _$ArweaveFile {
  String get transactionId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArweaveFileCopyWith<ArweaveFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArweaveFileCopyWith<$Res> {
  factory $ArweaveFileCopyWith(
          ArweaveFile value, $Res Function(ArweaveFile) then) =
      _$ArweaveFileCopyWithImpl<$Res, ArweaveFile>;
  @useResult
  $Res call({String transactionId, String type});
}

/// @nodoc
class _$ArweaveFileCopyWithImpl<$Res, $Val extends ArweaveFile>
    implements $ArweaveFileCopyWith<$Res> {
  _$ArweaveFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArweaveFileImplCopyWith<$Res>
    implements $ArweaveFileCopyWith<$Res> {
  factory _$$ArweaveFileImplCopyWith(
          _$ArweaveFileImpl value, $Res Function(_$ArweaveFileImpl) then) =
      __$$ArweaveFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transactionId, String type});
}

/// @nodoc
class __$$ArweaveFileImplCopyWithImpl<$Res>
    extends _$ArweaveFileCopyWithImpl<$Res, _$ArweaveFileImpl>
    implements _$$ArweaveFileImplCopyWith<$Res> {
  __$$ArweaveFileImplCopyWithImpl(
      _$ArweaveFileImpl _value, $Res Function(_$ArweaveFileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? type = null,
  }) {
    return _then(_$ArweaveFileImpl(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArweaveFileImpl implements _ArweaveFile {
  const _$ArweaveFileImpl({required this.transactionId, this.type = 'arweave'});

  factory _$ArweaveFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArweaveFileImplFromJson(json);

  @override
  final String transactionId;
  @override
  @JsonKey()
  final String type;

  @override
  String toString() {
    return 'ArweaveFile(transactionId: $transactionId, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArweaveFileImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, transactionId, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArweaveFileImplCopyWith<_$ArweaveFileImpl> get copyWith =>
      __$$ArweaveFileImplCopyWithImpl<_$ArweaveFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArweaveFileImplToJson(
      this,
    );
  }
}

abstract class _ArweaveFile implements ArweaveFile {
  const factory _ArweaveFile(
      {required final String transactionId,
      final String type}) = _$ArweaveFileImpl;

  factory _ArweaveFile.fromJson(Map<String, dynamic> json) =
      _$ArweaveFileImpl.fromJson;

  @override
  String get transactionId;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$ArweaveFileImplCopyWith<_$ArweaveFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
