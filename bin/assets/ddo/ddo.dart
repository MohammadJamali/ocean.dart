import 'dart:collection';

import '../../data_provider/fileinfo_provider.dart';
import '../../ocean/util.dart';
import '../../services/service.dart';
import '../credentials.dart';

class DDO with AddressCredentialMixin {
  String? did;
  List<String> context;
  int? chainId;
  String? nftAddress;
  Map<String, dynamic>? metadata;
  String version;
  List<dynamic> services;
  Map<String, List<Map<String, dynamic>>> credentials;
  Map<String, dynamic>? nft;
  List<dynamic>? datatokens;
  Map<String, dynamic>? event;
  Map<String, dynamic>? stats;

  DDO({
    this.did,
    List<String>? context,
    this.chainId,
    this.nftAddress,
    Map<String, dynamic>? metadata,
    List<dynamic>? services,
    Map<String, List<Map<String, dynamic>>>? credentials,
    this.nft,
    this.datatokens,
    this.event,
    this.stats,
  })  : context = context ?? ["https://w3id.org/did/v1"],
        version = "4.1.0",
        services = services ?? [],
        credentials = credentials ?? {};

  bool get requiresAddressCredential => requiresCredential();

  List<String> get allowedAddresses =>
      getAddressesOfClass(credentials, accessClass: "allow");

  List<String> get deniedAddresses =>
      getAddressesOfClass(credentials, accessClass: "deny");

  void addAddressToAllowList(String address) =>
      addAddressToAccessClass(credentials, address, accessClass: "allow");

  void addAddressToDenyList(String address) =>
      addAddressToAccessClass(credentials, address, accessClass: "deny");

  void removeAddressFromAllowList(String address) =>
      removeAddressFromAccessClass(credentials, address, accessClass: "allow");

  void removeAddressFromDenyList(String address) =>
      removeAddressFromAccessClass(credentials, address, accessClass: "deny");

  static DDO fromDict(Map<String, dynamic> dictionary) {
    var values = LinkedHashMap.from(dictionary);

    var id = values.remove("id");
    var context = values.remove("@context");
    var chainId = values.remove("chainId");
    var nftAddress = values.remove("nftAddress");
    var metadata = values.remove("metadata");

    var services = values.containsKey("services")
        ? values["services"].map((value) => Service.fromJson(value)).toList()
        : [];

    var credentials = values.remove("credentials");
    var nft = values.remove("nft");
    var datatokens = values.remove("datatokens");
    var event = values.remove("event");
    var stats = values.remove("stats");

    if (id == null) {
      return UnavailableDDO();
    }

    return DDO(
      did: id,
      context: context,
      chainId: chainId,
      nftAddress: nftAddress,
      metadata: metadata,
      services: services,
      credentials: credentials,
      nft: nft,
      datatokens: datatokens,
      event: event,
      stats: stats,
    );
  }

  Map<String, dynamic> asDictionary() {
    var data = {
      "@context": context,
      "id": did,
      "version": version,
      "chainId": chainId,
      "nftAddress": nftAddress,
    };

    if (metadata != null) {
      data["metadata"] = metadata;
    }

    if (credentials.isNotEmpty) {
      data["credentials"] = credentials;
    }

    if (nft != null) {
      data["nft"] = nft;
    }

    if (datatokens != null) {
      data["datatokens"] = datatokens;
    }

    if (event != null) {
      data["event"] = event;
    }

    if (stats != null) {
      data["stats"] = stats;
    }

    if (services.isNotEmpty) {
      data["stats"] = services;
    }

    return data;
  }

  void addService(Service service) {
    service.encryptFiles(nftAddress!, chainId!);

    print(
        "Adding service with service type ${service.serviceType} with did $did");
    services.add(service);
  }

  void createComputeService(
    String serviceId,
    String serviceEndpoint,
    String datatokenAddress,
    List<dynamic> files, {
    Map<String, dynamic>? computeValues,
    int timeout = 3600,
  }) {
    computeValues ??= {
      "allowRawAlgorithm": false,
      "allowNetworkAccess": true,
      "publisherTrustedAlgorithms": [],
      "publisherTrustedAlgorithmPublishers": [],
    };

    var computeService = Service(
      serviceId: serviceId,
      serviceType: "compute",
      serviceEndpoint: serviceEndpoint,
      datatoken: datatokenAddress,
      files: files,
      timeout: timeout,
      computeValues: computeValues,
    );

    addService(computeService);
  }

  Service? getServiceById(String serviceId) {
    return services.firstWhere(
      (service) => service.id == serviceId,
      orElse: () => null,
    );
  }

  Service? getServiceByIndex(int serviceIndex) {
    return (serviceIndex < services.length) ? services[serviceIndex] : null;
  }

  int? getIndexOfService(Service service) {
    var index =
        services.indexWhere((thisService) => thisService.id == service.id);
    return (index != -1) ? index : null;
  }

  Map<String, dynamic>? generateTrustedAlgorithms() {
    var fileInfoProvider = FileInfoProvider();
    var resp = fileInfoProvider.fileinfo(did, getServiceByIndex(0),
        withChecksum: true);
    var filesChecksum = [
      for (var respItem in resp.json()) respItem["checksum"]
    ];
    var container = metadata!["algorithm"]["container"];
    return {
      "did": did,
      "filesChecksum": filesChecksum.join(),
      "containerSectionChecksum": createChecksum(
        container["entrypoint"] + container["checksum"],
      ),
    };
  }

  bool get isDisabled =>
      metadata == null || nft != null && ![0, 5].contains(nft!['state']);
}

class UnavailableDDO extends DDO {}
