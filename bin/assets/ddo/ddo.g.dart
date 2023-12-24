// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ddo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DDOImpl _$$DDOImplFromJson(Map<String, dynamic> json) => _$DDOImpl(
      did: json['did'] as String?,
      context: (json['context'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['https://w3id.org/did/v1'],
      chainId: json['chainId'] as int?,
      nftAddress: json['nftAddress'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      credentials: (json['credentials'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => e as Map<String, dynamic>)
                .toList()),
      ),
      nft: json['nft'] as Map<String, dynamic>?,
      datatokens: (json['datatokens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      event: json['event'] as Map<String, dynamic>?,
      stats: json['stats'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$DDOImplToJson(_$DDOImpl instance) => <String, dynamic>{
      'did': instance.did,
      'context': instance.context,
      'chainId': instance.chainId,
      'nftAddress': instance.nftAddress,
      'metadata': instance.metadata,
      'services': instance.services,
      'credentials': instance.credentials,
      'nft': instance.nft,
      'datatokens': instance.datatokens,
      'event': instance.event,
      'stats': instance.stats,
    };
