import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../web3_internal/clef.dart';

class DataServiceProviderBase {
  final http.Client _httpClient = http.Client();
  var providerInfo;

  http.Client getHttpClient() {
    return _httpClient;
  }

  (int, String) signMessage(wallet, String msg, String providerUri) {
    var (path, url) = buildEndpoint("nonce", providerUri);
    var nonceResponse = _httpMethod(
      path,
      url: url,
      params: {'userAddress': wallet.address},
    );

    var currentNonce = 0;
    if (nonceResponse == null ||
        !nonceResponse.containsKey('status_code') ||
        nonceResponse['status_code'] != 200 ||
        !nonceResponse.containsKey('nonce')) {
      currentNonce = 0;
    } else {
      currentNonce = (nonceResponse['nonce'] as double).ceil();
    }

    var nonce = currentNonce + 1;
    print('signing message with nonce $nonce: $msg, account=${wallet.address}');

    if (wallet is ClefAccount) {
      return (nonce, signWithClef('$msg$nonce', wallet));
    }

    return (nonce, signWithKey('$msg$nonce', wallet.privateKey.toHex()));
  }

  String getUrl(Map<String, dynamic> configDict) {
    return _removeSlash(configDict['PROVIDER_URL']);
  }

  (String, String) buildEndpoint(String path, String providerUri) {
    var uri = Uri.parse(providerUri);
    var url = Uri(
      scheme: uri.scheme,
      host: uri.host,
      port: uri.port,
      path: '${uri.path}/$path',
    );
    return (path.toUpperCase(), url.toString());
  }

  dynamic _httpMethod(String method,
      {String? url, Map<String, dynamic>? params}) {
    var response;
    switch (method) {
      case 'GET':
        response = _httpClient.get(Uri.parse(url!));
        break;
      // Add more cases for other HTTP methods if needed
    }
    return response;
  }

  String _removeSlash(String? input) {
    return input?.replaceAll(RegExp(r'/+$'), '') ?? '';
  }

  Map<String, List<String>> getServiceEndpoints(String providerUri) {
    var providerInfo = _httpMethod('GET', url: providerUri).json();
    return providerInfo['serviceEndpoints'].cast<String, List<String>>();
  }

  String? getC2DEnvironments(String providerUri, int chainId) {
    try {
      var (path, url) = buildEndpoint(
          'computeEnvironments', providerUri, {'chainId': chainId});
      var environments = _httpMethod(path, url: url).json();

      if (!environments.containsKey('$chainId')) {
        logger.warning(
            'You might be using an older provider. ocean.py can not verify the chain id.');
        return environments.toString();
      }

      return environments['$chainId'];
    } catch (e) {
      // Handle exceptions
    }

    return null;
  }

  String? getProviderAddress(String providerUri, int chainId) {
    try {
      var providerInfo = _httpMethod('GET', url: providerUri).json();

      if (providerInfo.containsKey('providerAddress')) {
        logger.warning(
            'You might be using an older provider. ocean.py can not verify the chain id.');
        return providerInfo['providerAddress'];
      }

      return providerInfo['providerAddresses']['$chainId'];
    } catch (e) {
      // Handle exceptions
    }

    return null;
  }

  String getRootUri(String serviceEndpoint) {
    var providerUri = serviceEndpoint;

    if (providerUri.contains('/api')) {
      var i = providerUri.indexOf('/api');
      providerUri = providerUri.substring(0, i);
    }

    var parts = providerUri.split('/');

    if (parts.length < 2) {
      throw InvalidURL('InvalidURL $serviceEndpoint.');
    }

    if (parts[parts.length - 2] == 'services') {
      providerUri = parts.sublist(0, parts.length - 2).join('/');
    }

    var result = _removeSlash(providerUri);

    if (result.isEmpty) {
      throw InvalidURL('InvalidURL $serviceEndpoint.');
    }

    try {
      var rootResult = parts.sublist(0, 3).join('/');
      var response = _httpMethod('GET', url: rootResult).json();

      if (!response.containsKey('providerAddresses')) {
        if (response.containsKey('providerAddress')) {
          logger.warning(
              'You might be using an older provider. ocean.py can not verify the chain id.');
        } else {
          throw InvalidURL(
              'Invalid Provider URL $serviceEndpoint, no providerAddresses.');
        }
      }
    } catch (e) {
      throw InvalidURL('InvalidURL $serviceEndpoint.');
    }

    return result;
  }

  bool isValidProvider(String providerUri) {
    try {
      getRootUri(providerUri);
    } on InvalidUrlException {
      return false;
    }
    return true;
  }

  (String, String) buildEndpoint(String serviceName, String providerUri,
      {Map<String, dynamic>? params}) {
    providerUri = getRootUri(providerUri);
    var serviceEndpoints = getServiceEndpoints(providerUri);

    var method = serviceEndpoints[serviceName]!.item1;
    var url = Uri.parse(serviceEndpoints[serviceName]!.item2);
    url = Uri(
      scheme: url.scheme,
      host: url.host,
      port: url.port,
      path: '${url.path}/$serviceName',
    );

    if (params != null) {
      var req = http.Request('GET', url);
      req.bodyFields = params;
      url = Uri.parse(req.url.toString());
    }

    return (method, url.toString());
  }

  void writeFile(http.Response response, destinationFolder, int index) {
    if (response.statusCode != 200) {
      print('consume failed: ${response.reasonPhrase}');
      return;
    }

    var file = File('$destinationFolder/file$index');
    file.writeAsBytesSync(response.bodyBytes);
    print('Saved downloaded file in ${file.path}');
  }

  bool validateContentDisposition(String header) {
    var pattern = RegExp(r"\\|\.\.|/");
    return !pattern.hasMatch(header);
  }

  String? getFileName(http.Response response) {
    try {
      if (!validateContentDisposition(
          response.headers['content-disposition']!)) {
        print(
            'Invalid content disposition format. It was not possible to get the file name.');
        return null;
      }

      var match = RegExp(r"attachment;filename=(.+)")
          .firstMatch(response.headers['content-disposition']!);
      return match?.group(1);
    } catch (e) {
      print('It was not possible to get the file name. $e');
      return null;
    }
  }

  dynamic _httpMethod(String method,
      {String? url, Map<String, dynamic>? params}) {
    var response;
    switch (method) {
      case 'GET':
        response = _httpClient.get(Uri.parse(url!));
        break;
      // Add more cases for other HTTP methods if needed
    }
    return response;
  }

  dynamic httpMethod(
      String method, List<dynamic> args, Map<String, dynamic> kwargs) {
    try {
      return Function.apply(
        Function.apply(_httpClient, [method.toLowerCase()]),
        args,
        kwargs,
      );
    } catch (e) {
      print('Error invoking http method $method: args=$args, kwargs=$kwargs');
      rethrow;
    }
  }

  void checkResponse(
      response, String endpointName, String endpoint, dynamic payload,
      {List<int>? successCodes, Type exceptionType = DataProviderException}) {
    if (response == null ||
        response is! http.Response ||
        response.statusCode == null) {
      if (response is http.Response && response.statusCode == 400) {
        var error = jsonDecode(response.body)['error'] ??
            jsonDecode(response.body)['errors'] ??
            'unknown error';
        throw DataProviderException('$endpointName failed: $error');
      }

      var responseContent = response?.body ?? '<none>';
      throw DataProviderException(
          'Failed to get a response for request: $endpointName=$endpoint, payload=$payload, response is $responseContent');
    }

    if (successCodes == null) {
      successCodes = [200];
    }

    if (!successCodes.contains(response.statusCode)) {
      var msg =
          'request failed at the $endpointName$endpoint, reason ${response.body}, status ${response.statusCode}';
      print(msg);
      throw exceptionType(msg);
    }
  }
}

String urljoin(List<String> args) {
  var trailingSlash = args.last.endsWith('/') ? '/' : '';

  return args.map((x) => x.trim('/')).join('/') + trailingSlash;
}

String removeSlash(String path) {
  path = path.endsWith('/') ? path.substring(0, path.length - 1) : path;
  path = path.startsWith('/') ? path.substring(1) : path;

  return path;
}
