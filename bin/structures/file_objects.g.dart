// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UrlFileImpl _$$UrlFileImplFromJson(Map<String, dynamic> json) =>
    _$UrlFileImpl(
      url: json['url'] as String,
      method: json['method'] as String?,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      type: json['type'] as String? ?? 'url',
    );

Map<String, dynamic> _$$UrlFileImplToJson(_$UrlFileImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'method': instance.method,
      'headers': instance.headers,
      'type': instance.type,
    };

_$IpfsFileImpl _$$IpfsFileImplFromJson(Map<String, dynamic> json) =>
    _$IpfsFileImpl(
      hash: json['hash'] as String,
      type: json['type'] as String? ?? 'ipfs',
    );

Map<String, dynamic> _$$IpfsFileImplToJson(_$IpfsFileImpl instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'type': instance.type,
    };

_$GraphqlQueryImpl _$$GraphqlQueryImplFromJson(Map<String, dynamic> json) =>
    _$GraphqlQueryImpl(
      url: json['url'] as String,
      query: json['query'] as String,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      type: json['type'] as String? ?? 'graphql',
    );

Map<String, dynamic> _$$GraphqlQueryImplToJson(_$GraphqlQueryImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'query': instance.query,
      'headers': instance.headers,
      'type': instance.type,
    };

_$SmartContractCallImpl _$$SmartContractCallImplFromJson(
        Map<String, dynamic> json) =>
    _$SmartContractCallImpl(
      address: json['address'] as String,
      chainId: json['chainId'] as int,
      abi: json['abi'] as Map<String, dynamic>,
      type: json['type'] as String? ?? 'smartcontract',
    );

Map<String, dynamic> _$$SmartContractCallImplToJson(
        _$SmartContractCallImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'chainId': instance.chainId,
      'abi': instance.abi,
      'type': instance.type,
    };

_$ArweaveFileImpl _$$ArweaveFileImplFromJson(Map<String, dynamic> json) =>
    _$ArweaveFileImpl(
      transactionId: json['transactionId'] as String,
      type: json['type'] as String? ?? 'arweave',
    );

Map<String, dynamic> _$$ArweaveFileImplToJson(_$ArweaveFileImpl instance) =>
    <String, dynamic>{
      'transactionId': instance.transactionId,
      'type': instance.type,
    };
