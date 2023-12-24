
import 'package:web3dart/web3dart.dart';
import 'dart:convert';


const String ganacheUrl = "http://127.0.0.1:8545";

String getAddressOfType(Map<String, dynamic> configDict, String addressType, [String? key]) {
  final addresses = getContractsAddresses(configDict);
  if (!addresses.containsKey(addressType)) {
    throw KeyError("${addressType} address is not set in the config file");
  }
  final address = addresses[addressType] is! Map
      ? addresses[addressType]
      : (addresses[addressType] as Map).containsKey(key)
      ? addresses[addressType][key]
      : addresses[addressType]["1"];
  return EthereumAddress.fromHex(address.toLowerCase()).hex;
}

String getOceanTokenAddress(Map<String, dynamic> configDict) {
  final addresses = getContractsAddresses(configDict);
  if (addresses.containsKey("Ocean")) {
    return EthereumAddress.fromHex(addresses["Ocean"].toLowerCase()).hex;
  }
  return "";
}

String createChecksum(String text) {
  return Web3Utils.sha256(utf8.encode(text));
}

double fromWei(BigInt amtWei) {
  return amtWei / BigInt.from(1e18);
}

BigInt toWei(double amtEth) {
  return BigInt.from(amtEth * 1e18);
}

String strWithWei(BigInt amtWei) {
  return "${fromWei(amtWei)} (${amtWei.toString()} wei)";
}

String getFromAddress(Map<String, dynamic> txDict) {
  final address = EthereumAddress.fromHex(txDict['from']).hex;
  return address;
}

T getArgsObject<T>(List args, Map<String, dynamic> kwargs, T Function(List, Map<String, dynamic>) argsClassConstructor) {
  T? argsToUse;
  if (args.isNotEmpty && args[0] is T) {
    argsToUse = args[0] as T;
  } else {
    kwargs.forEach((key, value) {
      if (value is T) {
        argsToUse = value;
        return;
      }
    });
  }

  return argsToUse ?? argsClassConstructor(args, kwargs);
}

Future<TransactionReceipt> sendEther(
    Map<String, dynamic> config, EthPrivateKey fromWallet, String toAddress,
    dynamic amount, [int? priorityFee]) async {
  final web3 = config['web3_instance'] as Web3Client;
  final chainId = await web3.getNetworkId();
  if (!EthereumAddress.fromHex(toAddress).isChecksum) {
    toAddress = EthereumAddress.fromHex(toAddress).hexEip55;
  }

  EthereumAddress to = EthereumAddress.fromHex(toAddress);
  BigInt value = amount is int ? BigInt.from(amount) : toWei(amount as double);

  var tx = {
    "from": await fromWallet.extractAddress(),
    "to": to,
    "value": value,
    "chainId": chainId,
    "nonce": await web3.getTransactionCount(await fromWallet.extractAddress()),
    "type": 2,
    "maxPriorityFeePerGas": null,
    "maxFeePerGas": null,
  };

  tx['gas'] = await web3.estimateGas(
      sender: await fromWallet.extractAddress(), to: to, value: value);

  if (priorityFee == null) {
    priorityFee = (await web3.getMaxPriorityFeePerGas()).toInt();
  }

  final baseFee = (await web3.getBlockWithTransactions('latest')).baseFeePerGas!;
  tx['maxPriorityFeePerGas'] = BigInt.from(priorityFee);
  tx['maxFeePerGas'] = baseFee * BigInt.two + BigInt.from(priorityFee);

  final signedTx = await fromWallet.signTransaction(
    Transaction(
      from: await fromWallet.extractAddress(),
      to: to,
      maxGas: tx['gas'],
      maxFeePerGas: tx['maxFeePerGas'],
      maxPriorityFeePerGas: tx['maxPriorityFeePerGas'],
      value: EtherAmount.inWei(value),
      nonce: tx['nonce'],
    ),
    chainId: chainId,
  );

  final txHash = await web3.sendRawTransaction(signedTx);

  return web3.getTransactionReceipt(txHash);
}
