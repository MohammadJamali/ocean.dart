import 'dart:convert';

import 'package:http/http.dart';

import '../agreements/service_types.dart';
import '../data_provider/data_encryptor.dart';
import 'consumer_parameters.dart';

final RegExp snakeCasePattern = RegExp(r'(?<=[a-z])[A-Z]');

String toSnakeCase(String input) {
  return input.replaceAllMapped(snakeCasePattern, (match) {
    return '_${match.group(0)!.toLowerCase()}';
  });
}

class Service {
  final String serviceId;
  final String serviceType;
  final String? serviceEndpoint;
  final String? datatoken;
  dynamic files;
  final int? timeout;
  Map<String, dynamic>? computeValues;
  String? name;
  String? description;
  Map<String, dynamic>? additionalInformation;
  List<dynamic>? consumerParameters;

  Service({
    required this.serviceId,
    required this.serviceType,
    this.serviceEndpoint,
    this.datatoken,
    this.files,
    this.timeout,
    this.computeValues,
    this.name,
    this.description,
    this.additionalInformation,
    this.consumerParameters,
  }) {
    if (consumerParameters != null) {
      consumerParameters = consumerParameters!
          .map((cp) => ConsumerParameters.fromJson(cp))
          .toList();
    }

    if (additionalInformation != null) {
      additionalInformation = additionalInformation;
    }

    if (name == null || description == null) {
      final serviceToDefaultName = {
        'ASSET_ACCESS': 'DEFAULT_ACCESS_NAME',
        'CLOUD_COMPUTE': 'DEFAULT_COMPUTE_NAME',
      };

      if (serviceToDefaultName.containsKey(serviceType)) {
        name = serviceToDefaultName[serviceType];
        description = serviceToDefaultName[serviceType];
      }
    }
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['id'],
      serviceType: json['type'],
      serviceEndpoint: json['serviceEndpoint'],
      datatoken: json['datatokenAddress'],
      files: json['files'],
      timeout: json['timeout'],
      computeValues: json['compute'],
      name: json['name'],
      description: json['description'],
      additionalInformation: json['additionalInformation'],
      consumerParameters: json['consumerParameters'],
    );
  }

  List<Map<String, dynamic>> getTrustedAlgorithms() {
    return computeValues?['publisherTrustedAlgorithms'] ?? [];
  }

  List<String> getTrustedAlgorithmPublishers() {
    return computeValues?['publisherTrustedAlgorithmPublishers'] ?? [];
  }

  List<dynamic> addPublisherTrustedAlgorithm(dynamic algoDdo) {
    if (serviceType != 'CLOUD_COMPUTE') {
      throw AssertionError('Service is not compute type');
    }

    final initialTrustedAlgosV4 = getTrustedAlgorithms();
    final trustedAlgos =
        initialTrustedAlgosV4.where((ta) => ta['did'] != algoDdo.did).toList();

    final generatedTrustedAlgoDict = algoDdo.generateTrustedAlgorithms();
    trustedAlgos.add(generatedTrustedAlgoDict);

    computeValues?['publisherTrustedAlgorithms'] = trustedAlgos;

    return trustedAlgos;
  }

  List<String> addPublisherTrustedAlgorithmPublisher(String publisherAddress) {
    final trustedAlgoPublishers =
        getTrustedAlgorithmPublishers().map((tp) => tp.toLowerCase()).toList();
    publisherAddress = publisherAddress.toLowerCase();

    if (trustedAlgoPublishers.contains(publisherAddress)) {
      return trustedAlgoPublishers;
    }

    trustedAlgoPublishers.add(publisherAddress);
    computeValues?['publisherTrustedAlgorithmPublishers'] =
        trustedAlgoPublishers;

    return trustedAlgoPublishers;
  }

  Map<String, dynamic> asDictionary() {
    final keyNames = {
      'name': 'name',
      'description': 'description',
      'id': 'id',
      'type': 'type',
      'files': 'files',
      'datatokenAddress': 'datatoken',
      'serviceEndpoint': 'serviceEndpoint',
      'timeout': 'timeout',
      'additionalInformation': 'additionalInformation',
      'consumerParameters': 'consumerParameters',
    };

    final values = <String, dynamic>{};

    if (serviceType == 'compute') {
      if (computeValues?.containsKey('compute') == true) {
        values.addAll(computeValues!);
      } else {
        values['compute'] = computeValues;
      }
    }

    for (final entry in keyNames.entries) {
      final key = entry.key;
      final attrName = entry.value;

      var value = toJson()[attrName];

      if (value != null && value is List) {
        value = value.map((v) => v.toJson()).toList();
      }

      values[key] = value;
    }

    return values;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': serviceId,
      'type': serviceType,
      'serviceEndpoint': serviceEndpoint,
      'datatokenAddress': datatoken,
      'files': files,
      'timeout': timeout,
      'compute': computeValues,
      'name': name,
      'description': description,
      'additionalInformation': additionalInformation,
      'consumerParameters': consumerParameters,
    };
  }

  List<Map<String, dynamic>> removePublisherTrustedAlgorithm(String algoDid) {
    List<Map<String, dynamic>> trustedAlgorithms = getTrustedAlgorithms();

    if (trustedAlgorithms.isEmpty) {
      throw ArgumentError(
          "Algorithm $algoDid is not in trusted algorithms of this asset.");
    }

    trustedAlgorithms.removeWhere((ta) => ta['did'] == algoDid);

    List<String>? trustedAlgorithmPublishers = getTrustedAlgorithmPublishers();

    updateComputeValues(
        trustedAlgorithms, trustedAlgorithmPublishers, true, false);

    assert(computeValues!['publisherTrustedAlgorithms'] == trustedAlgorithms,
        'New trusted algorithm was not removed. Failed when updating the list of trusted algorithms.');

    return trustedAlgorithms;
  }

  List<String> removePublisherTrustedAlgorithmPublisher(
      String publisherAddress) {
    List<String> trustedAlgorithmPublishers =
        getTrustedAlgorithmPublishers().map((tp) => tp.toLowerCase()).toList();
    publisherAddress = publisherAddress.toLowerCase();

    if (trustedAlgorithmPublishers.isEmpty) {
      throw ArgumentError(
          "Publisher $publisherAddress is not in trusted algorithm publishers of this asset.");
    }

    trustedAlgorithmPublishers.removeWhere((tp) => tp == publisherAddress);

    List<Map<String, dynamic>> trustedAlgorithms = getTrustedAlgorithms();
    updateComputeValues(
        trustedAlgorithms, trustedAlgorithmPublishers, true, false);

    assert(
        computeValues!['publisherTrustedAlgorithmPublishers'] ==
            trustedAlgorithmPublishers,
        'New trusted algorithm publisher was not removed. Failed when updating the list of trusted algo publishers.');

    return trustedAlgorithmPublishers;
  }

  void updateComputeValues(
    List<Map<String, dynamic>> trustedAlgorithms,
    List<String>? trustedAlgoPublishers,
    bool allowNetworkAccess,
    bool allowRawAlgorithm,
  ) {
    assert(trustedAlgorithms.isEmpty,
        "trustedAlgorithms must be a list of dictionaries");

    assert(serviceType == ServiceTypes.CLOUD_COMPUTE,
        "this asset does not have a compute service.");

    for (var ta in trustedAlgorithms) {
      assert(ta.containsKey('did'),
          "dict in list of trustedAlgorithms is expected to have a `did` key");
    }

    computeValues ??= {};

    computeValues!['publisherTrustedAlgorithms'] = trustedAlgorithms;
    computeValues!['publisherTrustedAlgorithmPublishers'] =
        trustedAlgoPublishers;
    computeValues!['allowNetworkAccess'] = allowNetworkAccess;
    computeValues!['allowRawAlgorithm'] = allowRawAlgorithm;
  }

  Future<Response?> encryptFiles(String nftAddress, int chainId) async {
    if (files != null && files is String) {
      return null;
    }

    final List<Map<String, dynamic>> filesList = (files as List)
        .map((file) => file.toJson())
        .toList() as List<Map<String, dynamic>>;

    final encryptResponse = await DataEncryptor.encrypt({
      'datatokenAddress': datatoken,
      'nftAddress': nftAddress,
      'files': filesList,
    }, serviceEndpoint!, chainId);

    files = utf8.decode(encryptResponse.bodyBytes);
    return null;
  }
}
