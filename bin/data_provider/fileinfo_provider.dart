import 'package:http/http.dart' as http;

import 'base.dart';

class FileInfoProvider extends DataServiceProviderBase {
  static http.Response fileInfo(
    String did,
    dynamic service, {
    bool withChecksum = false,
    Map<String, dynamic>? userdata,
  }) {
    var (method, url) = buildEndpoint('fileinfo', service['serviceEndpoint']);
    var payload = {'did': did, 'serviceId': service['id']};

    if (userdata != null) {
      payload['userdata'] = userdata;
    }

    if (withChecksum) {
      payload['checksum'] = 1;
    }

    var response = httpMethod(method, url, json: payload);

    checkResponse(response, 'fileInfoEndpoint', url, payload);

    print('Retrieved asset files successfully FileInfoEndpoint $url from did '
        '$did with service id ${service['id']}');
    return response;
  }
}
