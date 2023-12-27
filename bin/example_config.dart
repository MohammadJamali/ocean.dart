import 'dart:io';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:path/path.dart';
import 'package:web3dart/web3dart.dart';

class ConfigDefaults {
  static const DEFAULT_METADATA_CACHE_URI = "http://172.15.0.5:5000";
  static const METADATA_CACHE_URI = "https://v4.aquarius.oceanprotocol.com";
  static const DEFAULT_PROVIDER_URL = "http://172.15.0.4:8030";

  static const configDefaults = {
    "METADATA_CACHE_URI": DEFAULT_METADATA_CACHE_URI,
    "PROVIDER_URL": DEFAULT_PROVIDER_URL,
    "DOWNLOADS_PATH": "consume-downloads",
  };
}

class ProviderPerNetwork {
  static const Map<int, String> providerPerNetwork = {
    1: "https://v4.provider.mainnet.oceanprotocol.com",
    5: "https://v4.provider.goerli.oceanprotocol.com",
    10: "https://v4.provider.oceanprotocol.com",
    56: "https://v4.provider.bsc.oceanprotocol.com",
    137: "https://v4.provider.polygon.oceanprotocol.com",
    246: "https://v4.provider.energyweb.oceanprotocol.com",
    1285: "https://v4.provider.moonriver.oceanprotocol.com",
    1287: "https://v4.provider.moonbase.oceanprotocol.com",
    80001: "https://v4.provider.mumbai.oceanprotocol.com",
    58008: "https://v4.provider.oceanprotocol.com",
    8996: ConfigDefaults.DEFAULT_PROVIDER_URL,
  };
}

class NamePerNetwork {
  static const Map<int, String> namePerNetwork = {
    1: "mainnet",
    5: "goerli",
    10: "optimism",
    56: "bsc",
    137: "polygon",
    246: "energyweb",
    1285: "moonriver",
    1287: "moonbase",
    80001: "mumbai",
    58008: "sepolia",
    8996: "development",
  };
}

Future<Map<String, dynamic>> getOceanConfig(String networkUrl) async {
  if (networkUrl.isEmpty) {
    networkUrl = "http://localhost:8545";
  }

  final configDict = Map<String, dynamic>.from(ConfigDefaults.configDefaults);
  final client = getWeb3(networkUrl);
  configDict["web3_instance"] = client;
  configDict["CHAIN_ID"] = await client.getNetworkId();

  final chainId = configDict["CHAIN_ID"];
  if (!ProviderPerNetwork.providerPerNetwork.containsKey(chainId)) {
    throw ArgumentError(
        "The chain id for the specific RPC could not be fetched!");
  }

  configDict["PROVIDER_URL"] = ProviderPerNetwork.providerPerNetwork[chainId];
  configDict["NETWORK_NAME"] = NamePerNetwork.namePerNetwork[chainId];

  if (chainId != 8996) {
    configDict["METADATA_CACHE_URI"] = ConfigDefaults.METADATA_CACHE_URI;
  }

  if (Platform.environment.containsKey("ADDRESS_FILE")) {
    final baseFile = Platform.environment["ADDRESS_FILE"]!;
    final addressFile = File(path.normalize(baseFile)).absolute.path;
    assert(File(addressFile).existsSync(),
        "Could not find address_file=$addressFile.");
    configDict["ADDRESS_FILE"] = addressFile;
  } else if (chainId == 8996) {
    final baseFile = "assets/address.json";
    final addressFile = File(path.normalize(baseFile)).absolute.path;
    assert(File(addressFile).existsSync(),
        "Could not find address_file=$addressFile.");
    configDict["ADDRESS_FILE"] = addressFile;
  } else {
    final addressFile = File(path.normalize(join(
      File(File.fromUri(Uri.file(Platform.script.toFilePath())).absolute.path)
          .parent
          .path,
      "..",
      "assets",
      "address.json",
    ))).absolute.path;
    assert(File(addressFile).existsSync(),
        "Could not find address_file=$addressFile.");
    configDict["ADDRESS_FILE"] = addressFile;
  }

  return configDict;
}

Web3Client getWeb3(String networkUrl) => Web3Client(networkUrl, Client());
