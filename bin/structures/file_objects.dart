import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_objects.freezed.dart';
part 'file_objects.g.dart';

@freezed
class UrlFile extends FilesType with _$UrlFile {
  const factory UrlFile({
    required String url,
    String? method,
    Map<String, String>? headers,
    @Default('url') String type,
  }) = _UrlFile;

  factory UrlFile.fromJson(Map<String, dynamic> json) =>
      _$UrlFileFromJson(json);
}

@freezed
class IpfsFile extends FilesType with _$IpfsFile {
  const factory IpfsFile({
    required String hash,
    @Default('ipfs') String type,
  }) = _IpfsFile;

  factory IpfsFile.fromJson(Map<String, dynamic> json) =>
      _$IpfsFileFromJson(json);
}

@freezed
class GraphqlQuery extends FilesType with _$GraphqlQuery {
  const factory GraphqlQuery({
    required String url,
    required String query,
    Map<String, String>? headers,
    @Default('graphql') String type,
  }) = _GraphqlQuery;

  factory GraphqlQuery.fromJson(Map<String, dynamic> json) =>
      _$GraphqlQueryFromJson(json);
}

@freezed
class SmartContractCall extends FilesType with _$SmartContractCall {
  const factory SmartContractCall({
    required String address,
    required int chainId,
    required Map<String, dynamic> abi,
    @Default('smartcontract') String type,
  }) = _SmartContractCall;

  factory SmartContractCall.fromJson(Map<String, dynamic> json) =>
      _$SmartContractCallFromJson(json);
}

@freezed
class ArweaveFile extends FilesType with _$ArweaveFile {
  const factory ArweaveFile({
    required String transactionId,
    @Default('arweave') String type,
  }) = _ArweaveFile;

  factory ArweaveFile.fromJson(Map<String, dynamic> json) =>
      _$ArweaveFileFromJson(json);
}

abstract class FilesType {}

FilesType filesTypeFactory(Map<String, dynamic> fileObj) {
  switch (fileObj["type"]) {
    case "url":
      return UrlFile(
        url: fileObj["url"],
        method: fileObj.containsKey("method") ? fileObj["method"] : "GET",
        headers: fileObj["headers"]?.cast<String, String>(),
      );
    case "arweave":
      return ArweaveFile(transactionId: fileObj["transactionId"]);
    case "ipfs":
      return IpfsFile(hash: fileObj["hash"]);
    case "graphql":
      return GraphqlQuery(
          url: fileObj["url"],
          query: fileObj["query"],
          headers: fileObj["headers"]?.cast<String, String>());
    case "smartcontract":
      return SmartContractCall(
          address: fileObj["address"],
          chainId: fileObj["chainId"],
          abi: fileObj["abi"]?.cast<String, dynamic>());
    default:
      throw Exception("Unrecognized file type");
  }
}
