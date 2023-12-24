import 'dart:convert';
import 'package:http/http.dart' as http;

import 'base.dart';

class DataEncryptor extends DataServiceProviderBase {
  static Future<http.Response> encrypt(
    dynamic objectsToEncrypt,
    String providerUri,
    int chainId,
  ) async {
    late List<int> payload;

    if (objectsToEncrypt is Map) {
      var data = json.encode(objectsToEncrypt);
      payload = utf8.encode(data);
    } else if (objectsToEncrypt is String) {
      payload = utf8.encode(objectsToEncrypt);
    } else if (objectsToEncrypt is List<int>) {
      payload = objectsToEncrypt;
    } else {
      throw ArgumentError('Unsupported type for objectsToEncrypt');
    }

    var endpoint = buildEndpoint('encrypt', providerUri, {'chainId': chainId});
    var response = await httpMethod(
      endpoint.item1,
      endpoint.item2,
      data: payload,
      headers: {'Content-type': 'application/octet-stream'},
    );

    checkResponse(response, 'encryptEndpoint', endpoint.item2, payload, [201],
        OceanEncryptAssetUrlsError);

    print(
        'Asset urls encrypted successfully, encrypted urls str: ${response.body}, encryptedEndpoint ${endpoint.item2}');

    return response;
  }
}
