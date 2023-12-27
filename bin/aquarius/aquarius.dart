import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../assets/ddo/ddo.dart';
import '../utils/logger.dart';

class Aquarius {
  String baseUrl;

  late final http.Client client;

  Aquarius(this.baseUrl) {
    client = http.Client();
  }

  static Future<Aquarius> getInstance(String baseUrl) async {
    final object = Aquarius(baseUrl);

    if (baseUrl.isEmpty) {
      throw ArgumentError('Invalid URL');
    }

    // :HACK:
    if (baseUrl.contains("/api/aquarius/assets")) {
      baseUrl = baseUrl.split("/api/aquarius/assets")[0];
    }

    try {
      final response = await object.client.get(Uri.parse(baseUrl));
      if (response.statusCode != 200) {
        throw Exception('Invalid or unresponsive aquarius url $baseUrl');
      }
    } catch (e) {
      throw Exception('Error connecting to aquarius url $baseUrl: $e');
    }

    baseUrl = '$baseUrl/api/aquarius/assets';

    logger.d('Aquarius connected at $baseUrl');
    logger.d('Aquarius API documentation at $baseUrl/api/v1/docs');
    logger.d('Metadata assets (DDOs) at $baseUrl');

    return object;
  }

  Future<DDO?> getDdo(String did) async {
    final response = await client.get(Uri.parse('$baseUrl/ddo/$did'));
    if (response.statusCode == 200) {
      return DDO.fromDict(json.decode(response.body));
    }
    return null;
  }

  Future<bool> ddoExists(String did) async {
    final response = await client.get(Uri.parse('$baseUrl/ddo/$did'));
    return !response.body.contains('Asset DID $did not found in Elasticsearch');
  }

  Future<Map<String, dynamic>> getDdoMetadata(String did) async {
    final response = await client.get(Uri.parse('$baseUrl/metadata/$did'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return {};
  }

  /// Search using a query.
  ///
  /// Currently implemented is the MongoDB query model to search for documents according to:
  /// https://docs.mongodb.com/manual/tutorial/query-documents/
  ///
  /// And an Elastic Search driver, which implements a basic parser to convert the query into
  /// elastic search format.
  ///
  /// Example: query_search({"price":[0,10]})
  ///
  /// :param search_query: Python dictionary, query following elasticsearch syntax
  /// :return: List of DDO
  Future<List<dynamic>> querySearch(Map<String, dynamic> searchQuery) async {
    final response = await client.post(
      Uri.parse('$baseUrl/query'),
      headers: {'content-type': 'application/json'},
      body: json.encode(searchQuery),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['hits']['hits'];
    }
    throw ArgumentError('Unable to search for DDO: ${response.body}');
  }

  /// Does the DDO conform to the Ocean DDO schema?
  /// Schema definition: https://docs.oceanprotocol.com/core-concepts/did-ddo
  ///
  Future<(bool, dynamic)> validateDdo(DDO ddo) async {
    final data = json.encode(ddo.toJson());
    final response = await client.post(
      Uri.parse('$baseUrl/ddo/validate'),
      headers: {'content-type': 'application/octet-stream'},
      body: data,
    );
    final parsedResponse = json.decode(response.body);
    if (parsedResponse['hash'] != null) {
      return (true, parsedResponse);
    }
    return (false, parsedResponse);
  }

  Future<DDO?> waitForDdo(String did, {int timeout = 60}) async {
    final startTime = DateTime.now().millisecondsSinceEpoch;
    while (DateTime.now().millisecondsSinceEpoch - startTime < timeout * 1000) {
      final ddo = await getDdo(did);
      if (ddo != null) return ddo;
      await Future.delayed(Duration(milliseconds: 200));
    }
    return null;
  }

  Future<DDO?> waitForDdoUpdate(DDO ddo, String tx, {int timeout = 60}) async {
    if (ddo.did == null) {
      throw Exception('did is empty.');
    }

    final startTime = DateTime.now().millisecondsSinceEpoch;
    while (DateTime.now().millisecondsSinceEpoch - startTime < timeout * 1000) {
      try {
        final updatedDdo = await getDdo(ddo.did!);
        if (updatedDdo?.event?['tx'] == tx) {
          logger.d(
              'Transaction matching the given tx id detected in metadata store.');
          return updatedDdo;
        }
      } catch (e) {
        logger.e(e);
      }
      await Future.delayed(Duration(milliseconds: 200));
    }
    return null;
  }
}
