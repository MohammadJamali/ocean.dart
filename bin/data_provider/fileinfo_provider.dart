import 'package:http/http.dart' as http;

import 'base.dart';

class FileInfoProvider extends DataServiceProviderBase {
  static http.Client _httpClient = http.Client();
  static var providerInfo;

  static http.Client getHttpClient() {
    return _httpClient;
  }

  static void setHttpClient(http.Client httpClient) {
    _httpClient = httpClient;
  }

  static http.Response fileInfo(String did, dynamic service,
      {bool withChecksum = false, Map<String, dynamic>? userdata}) {
    var endpoint = buildEndpoint('fileinfo', service['serviceEndpoint']);
    var payload = {'did': did, 'serviceId': service['id']};

    if (userdata != null) {
      payload['userdata'] = userdata;
    }

    if (withChecksum) {
      payload['checksum'] = 1;
    }

    var response = httpMethod(endpoint.item1, endpoint.item2, json: payload);

    checkResponse(response, 'fileInfoEndpoint', endpoint.item2, payload);

    print(
        'Retrieved asset files successfully FileInfoEndpoint ${endpoint.item2} from did $did with service id ${service['id']}');
    return response;
  }
}
