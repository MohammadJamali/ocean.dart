import 'dart:convert';
import 'package:http/http.dart' as http;

import '../structures/algorithm_metadata.dart';
import 'base.dart';

class DataServiceProvider extends DataServiceProviderBase {
  http.Client _httpClient = http.Client();
  var providerInfo;

  http.Response initialize(String did, dynamic service, String consumerAddress,
      {Map<String, dynamic>? userdata}) {
    var (path, url) = buildEndpoint(
      'initialize',
      service['serviceEndpoint'],
    );
    var payload = {
      'documentId': did,
      'serviceId': service['id'],
      'consumerAddress': consumerAddress,
    };

    if (userdata != null) {
      payload['userdata'] = jsonEncode(userdata);
    }

    var response = httpMethod(path, url, params: payload);

    checkResponse(response, 'initializeEndpoint', url, payload);

    print('Service initialized successfully initializeEndpoint ${url}');
    return response;
  }

  http.Response initializeCompute(
      List<Map<String, dynamic>> datasets,
      Map<String, dynamic> algorithmData,
      String serviceEndpoint,
      String consumerAddress,
      String computeEnvironment,
      int validUntil) {
    var (path, url) = buildEndpoint('initializeCompute', serviceEndpoint);
    var payload = {
      'datasets': datasets,
      'algorithm': algorithmData,
      'compute': {
        'env': computeEnvironment,
        'validUntil': validUntil,
      },
      'consumerAddress': consumerAddress,
    };

    var response = httpMethod(
      path,
      url,
      data: jsonEncode(payload),
      headers: {'content-type': 'application/json'},
    );

    checkResponse(response, 'initializeComputeEndpoint', url, payload);

    print('Service initialized successfully initializeComputeEndpoint ${url}');
    return response;
  }

  void download(String did, dynamic service, dynamic txId,
      dynamic consumerWallet, dynamic destinationFolder,
      {int? index, Map<String, dynamic>? userdata}) {
    var serviceEndpoint = service['service_endpoint'];
    var fileinfoResponse =
        FileInfoProvider.fileinfo(did, service, userdata: userdata);

    var files = json.decode(fileinfoResponse.body);
    var indexes = List<int>.generate(files.length, (i) => i);

    if (index != null) {
      assert(index is int, 'index has to be an integer.');
      assert(index >= 0, 'index has to be 0 or a positive integer.');
      assert(index < files.length,
          'index cannot be bigger than the number of files');
      indexes = [index];
    }

    var (path, url) = buildEndpoint('download', serviceEndpoint);
    var payload = {
      'documentId': did,
      'serviceId': service['id'],
      'consumerAddress': consumerWallet['address'],
      'transferTxId': txId,
    };

    if (userdata != null) {
      payload['userdata'] = jsonEncode(userdata);
    }

    for (var i in indexes) {
      payload['fileIndex'] = i;
      var signatureTuple = DataServiceProvider.signMessage(consumerWallet, did,
          providerUri: serviceEndpoint);
      payload['nonce'] = signatureTuple.item1;
      payload['signature'] = signatureTuple.item2;
      var response = httpMethod(
        path,
        url,
        params: payload,
        stream: true,
        timeout: Duration(seconds: 3),
      );

      checkResponse(response, 'downloadEndpoint', url, payload);

      writefile(response, destinationFolder, i);

      print('DDO downloaded successfully downloadEndpoint ${url}');
    }
  }

  Map<String, dynamic> startComputeJob(dynamic datasetComputeService,
      dynamic consumer, dynamic dataset, String computeEnvironment,
      {dynamic algorithm,
      dynamic algorithmMeta,
      String? algorithmCustomData,
      List<dynamic>? inputDatasets}) {
    assert(algorithm != null || algorithmMeta != null,
        'either an algorithm or an algorithmMeta must be provided.');
    assert(datasetComputeService['type'] == 'CLOUD_COMPUTE',
        'invalid compute service');

    var payload = _prepareComputePayload(
        consumer: consumer,
        dataset: dataset,
        computeEnvironment: computeEnvironment,
        datasetComputeService: datasetComputeService,
        algorithm: algorithm,
        algorithmMeta: algorithmMeta,
        algorithmCustomData: algorithmCustomData,
        inputDatasets: inputDatasets);

    print('invoke start compute endpoint with this url: $payload');
    var (path, url) = buildEndpoint(
        'computeStart', datasetComputeService['service_endpoint']);
    var response = httpMethod(
      path,
      url,
      data: jsonEncode(payload),
      headers: {'content-type': 'application/json'},
    );

    print(
        'got DataProvider execute response: ${response.body} with status-code ${response.statusCode}');

    checkResponse(response, 'computeStartEndpoint', url, payload, [200, 201]);

    try {
      var jobInfo = json.decode(utf8.decode(response.bodyBytes));
      return jobInfo[0] ?? jobInfo;
    } on NoSuchMethodError catch (err) {
      print('Failed to extract jobId from response: $err');
      throw ArgumentError('Failed to extract jobId from response: $err');
    } on FormatException catch (err) {
      print('Failed to parse response json: $err');
      throw ArgumentError('Failed to parse response json: $err');
    }
  }

  Map<String, dynamic> stopComputeJob(String did, String jobId,
      dynamic datasetComputeService, dynamic consumer) {
    var (path, url) =
        buildEndpoint('computeStop', datasetComputeService['service_endpoint']);
    return _sendComputeRequest('put', did, jobId, url, consumer);
  }

  Map<String, String> deleteComputeJob(String did, String jobId,
      dynamic datasetComputeService, dynamic consumer) {
    var (path, url) = buildEndpoint(
        'computeDelete', datasetComputeService['service_endpoint']);
    return _sendComputeRequest(path, did, jobId, url, consumer);
  }

  Map<String, dynamic> computeJobStatus(String did, String jobId,
      dynamic datasetComputeService, dynamic consumer) {
    var (path, url) = buildEndpoint(
        'computeStatus', datasetComputeService['service_endpoint']);
    return _sendComputeRequest(path, did, jobId, url, consumer);
  }

  Future<List<int>> computeJobResult(String jobId, int index,
      dynamic datasetComputeService, dynamic consumer) async {
    var signatureTuple = signMessage(
        consumer, '${consumer['address']}$jobId$index',
        providerUri: datasetComputeService['service_endpoint']);
    var params = {
      'signature': signatureTuple.item2,
      'nonce': signatureTuple.item1,
      'jobId': jobId,
      'index': index,
      'consumerAddress': consumer['address'],
    };

    var (path, url) = buildEndpoint(
        'computeResult', datasetComputeService['service_endpoint']);
    var response = await httpMethod(path, url, params: params);

    checkResponse(response, 'jobResultEndpoint', url, params);

    return response.bodyBytes;
  }

  List<Map<String, dynamic>> computeJobResultLogs(dynamic ddo, String jobId,
      dynamic datasetComputeService, dynamic consumer,
      {String logType = 'output'}) {
    var status =
        computeJobStatus(ddo['did'], jobId, datasetComputeService, consumer);
    var functionResult = <Map<String, dynamic>>[];
    for (var i = 0; i < status['results'].length; i++) {
      var result = null;
      var resultType = status['results'][i]['type'];
      result = computeJobResult(jobId, i, datasetComputeService, consumer);

      // Extract algorithm output
      if (resultType == logType) {
        functionResult.add({'index': i, 'result': result});
      }
    }
    return functionResult;
  }

  Map<String, dynamic> _sendComputeRequest(String httpMethod, String did,
      String jobId, String serviceEndpoint, dynamic consumer) {
    var signatureTuple = signMessage(
        consumer, '${consumer['address']}$jobId$did',
        providerUri: serviceEndpoint);

    var payload = {
      'consumerAddress': consumer['address'],
      'documentId': did,
      'jobId': jobId,
      'nonce': signatureTuple.item1,
      'signature': signatureTuple.item2,
    };

    var req = PreparedRequest();
    req.prepareUrl(serviceEndpoint, payload);

    print('invoke compute endpoint with this url: ${req.url}');
    var response = _httpMethod(httpMethod, req.url);

    print(
        'got provider execute response: ${response.body} with status-code ${response.statusCode} ');

    checkResponse(response, 'compute Endpoint', req.url, payload);

    var respContent = json.decode(utf8.decode(response.bodyBytes));

    if (respContent is List) {
      return respContent[0];
    }

    return respContent;
  }

  Map<String, dynamic> _prepareComputePayload(dynamic consumer, dynamic dataset,
      dynamic datasetComputeService, String computeEnvironment,
      {dynamic algorithm,
      dynamic algorithmMeta,
      String? algorithmCustomData,
      List<dynamic>? inputDatasets}) {
    assert(algorithm != null || algorithmMeta != null,
        'either an algorithm did or an algorithm meta must be provided.');

    if (algorithmMeta != null) {
      assert(algorithmMeta is AlgorithmMetadata,
          'expecting a AlgorithmMetadata type for `algorithm_meta`, got ${algorithmMeta.runtimeType}');
    }

    inputDatasets = inputDatasets ?? [];
    var _inputDatasets = <Map<String, dynamic>>[];
    for (var _input in inputDatasets) {
      for (var reqKey in ['did', 'transfer_tx_id', 'service_id']) {
        assert(_input[reqKey] != null,
            'The received dataset does not have a $reqKey.');
      }
    }

    // TODO: is the nonce correct here?
    // Should it be the one from the compute service or a dataset?
    var signatureTuple = signMessage(
        consumer, '${consumer['address']}${dataset['did']}',
        providerUri: datasetComputeService['service_endpoint']);

    var payload = {
      'dataset': {
        'documentId': dataset['did'],
        'serviceId': dataset['service_id'],
        'transferTxId': dataset['transfer_tx_id'],
      },
      'environment': computeEnvironment,
      'algorithm': {},
      'signature': signatureTuple.item2,
      'nonce': signatureTuple.item1,
      'consumerAddress': consumer['address'],
      'additionalInputs': _inputDatasets,
    };

    if (dataset['userdata'] != null) {
      payload['dataset']['userdata'] = dataset['userdata'];
    }

    if (algorithm != null) {
      payload['algorithm'] = {
        'documentId': algorithm['did'],
        'serviceId': algorithm['service_id'],
        'transferTxId': algorithm['transfer_tx_id'],
      };

      if (algorithm['userdata'] != null) {
        payload['algorithm']['userdata'] = algorithm['userdata'];
      }

      if (algorithmCustomData != null) {
        payload['algorithm']['algocustomdata'] = algorithmCustomData;
      }
    } else {
      payload['algorithm'] = algorithmMeta.asDictionary();
    }

    return payload;
  }

  bool checkSingleFileInfo(Map<String, dynamic> urlObject, String providerUri) {
    var (path, url) = buildEndpoint('fileinfo', providerUri);
    var response =
        _httpMethod(methodpath, methodurl, body: jsonEncode(urlObject));

    if (response.statusCode != 200) {
      return false;
    }

    return (response.body as List).any((fileInfo) => fileInfo['valid'] == true);
  }

  bool checkAssetFileInfo(String did, String serviceId, String providerUri,
      {Map<String, dynamic>? userdata}) {
    if (did.isEmpty) {
      return false;
    }

    var (path, url) = buildEndpoint('fileinfo', providerUri);
    var data = {'did': did, 'serviceId': serviceId};

    if (userdata != null) {
      data['userdata'] = userdata;
    }

    var response = _httpMethod(methodpath, methodurl, body: jsonEncode(data));

    if (response == null || response.statusCode != 200) {
      return false;
    }

    return (response.body as List).any((fileInfo) => fileInfo['valid'] == true);
  }
}
