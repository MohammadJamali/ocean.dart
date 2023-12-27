import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:web3dart/web3dart.dart';

class ContractUtils {
  /// Returns the abi JSON for a contract name.
  static Map<String, dynamic> getContractDefinition(String contractName) {
    var pathToFile = path.join(
      'bin/contracts/artifacts',
      '$contractName.json',
    );
    pathToFile = File(pathToFile).absolute.path;

    if (!File(pathToFile).existsSync()) {
      throw Exception("Contract name does not exist in artifacts.");
    }

    final jsonString = File(pathToFile).readAsStringSync();
    return json.decode(jsonString);
  }

  /// Loads a contract using its name and address
  static DeployedContract loadContract(
    Web3Client web3,
    String contractName,
    EthereumAddress address,
  ) {
    final contractDefinition = getContractDefinition(contractName);
    // final bytecode = contractDefinition["bytecode"];

    final abi = ContractAbi.fromJson(contractDefinition["abi"], contractName);
    // EthereumAddress.fromHex(hex)

    final contract = DeployedContract(abi, address);
    return contract;
  }

  static Map<String, dynamic> getContractsAddressesAllNetworks(
    Map<String, dynamic> config,
  ) {
    final addressFile = config['ADDRESS_FILE'];
    if (addressFile == null || !File(addressFile).existsSync()) {
      throw Exception("Could not find address_file=$addressFile.");
    }

    final jsonString = File(addressFile).readAsStringSync();
    return json.decode(jsonString);
  }

  static Map<String, dynamic> getContractsAddresses(
    Map<String, dynamic> config,
  ) {
    final networkName = config['NETWORK_NAME'];
    final addresses = getContractsAddressesAllNetworks(config);

    final networkAddresses = addresses[networkName];
    if (networkAddresses == null) {
      throw Exception("Address not found for network_name=$networkName.");
    }

    return _checksumContractAddresses(networkAddresses);
  }

  static Map<String, dynamic> _checksumContractAddresses(
    Map<String, dynamic> networkAddresses,
  ) {
    for (var element in networkAddresses.entries) {
      if (element.key == 'chainId') continue;
      if (element.value is int) continue;

      if (element.value is Map<String, dynamic>) {
        element.value.forEach((k, v) {
          element.value[k] = EthereumAddress.fromHex(v.toLowerCase()).hex;
        });
      } else {
        networkAddresses[element.key] =
            EthereumAddress.fromHex(element.value.toLowerCase()).hex;
      }
    }

    return networkAddresses;
  }
}
