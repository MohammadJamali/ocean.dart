import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:convert';

import '../utils/address.dart';
import '../utils/logger.dart';
import '../web3_internal/contract_utils.dart';

String getAddressOfType(
  Map<String, dynamic> configDict,
  String addressType, [
  String? key,
]) {
  final addresses = ContractUtils.getContractsAddresses(configDict);
  if (!addresses.containsKey(addressType)) {
    throw ArgumentError("$addressType address is not set in the config file");
  }
  final address = addresses[addressType] is! Map
      ? addresses[addressType]
      : (addresses[addressType] as Map).containsKey(key)
          ? addresses[addressType][key]
          : addresses[addressType]["1"];

  return EthereumAddress.fromHex(address.toLowerCase()).hex;
}

String? getOceanTokenAddress(
  Map<String, dynamic> configDict,
) {
  final addresses = ContractUtils.getContractsAddresses(configDict);
  if (addresses.containsKey("Ocean")) {
    return EthereumAddress.fromHex(addresses["Ocean"]!.toLowerCase()).hex;
  }
  return null;
}

String createChecksum(String text) {
  return bytesToHex(
    Uint8List.fromList(sha256.convert(utf8.encode(text)).bytes),
  );
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

T getArgsObject<T>(List args, Map<String, dynamic> kwargs,
    T Function(List, Map<String, dynamic>) argsClassConstructor) {
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

BigInt _feeHistoryPriorityFeeEstimate(Map<String, dynamic> feeHistory) {
  final nonEmptyBlockFees = (feeHistory['reward'] as List<List<double>>)
      .where((fee) => fee[0] != 0)
      .map((fee) => fee[0])
      .toList();

  // prevent division by zero in the extremely unlikely case that all fees within
  // the polled fee history range for the specified percentile are 0
  int divisor = nonEmptyBlockFees.isNotEmpty ? nonEmptyBlockFees.length : 1;

  final priorityFeeAverageForPercentile = BigInt.from(
    (nonEmptyBlockFees.reduce((a, b) => a + b) / divisor).round(),
  );

  final priorityFeeMax = BigInt.from(1500000000); // 1.5 gwei
  final priorityFeeMin = BigInt.from(1000000000); // 1 gwei

  return
      // keep estimated priority fee within a max / min range
      priorityFeeAverageForPercentile > priorityFeeMax
          ? priorityFeeMax
          : priorityFeeAverageForPercentile < priorityFeeMin
              ? priorityFeeMin
              : priorityFeeAverageForPercentile;
}

Future<TransactionReceipt?> sendEther(
  Map<String, dynamic> config,
  EthPrivateKey fromWallet,
  String toAddress,
  dynamic amount, [
  BigInt? priorityFee,
]) async {
  final web3 = config['web3_instance'] as Web3Client;
  final chainId = await web3.getNetworkId();
  if (!isChecksumAddress(toAddress)) {
    toAddress = EthereumAddress.fromHex(toAddress).hexEip55;
  }

  final to = EthereumAddress.fromHex(toAddress);
  final value = amount is int ? BigInt.from(amount) : toWei(amount as double);
  final gas = await web3.estimateGas(
    sender: fromWallet.address,
    to: to,
    value: EtherAmount.fromBigInt(EtherUnit.wei, amount),
  );

  try {
    priorityFee ??= await web3.makeRPCCall('eth_maxPriorityFeePerGas');
  } catch (e) {
    logger.d("There was an issue with the method eth_maxPriorityFeePerGas. "
        "Calculating using eth_feeHistory.");
    priorityFee ??= _feeHistoryPriorityFeeEstimate(
      await web3.getFeeHistory(10, rewardPercentiles: [5.0]),
    );
  }

  final lastBlockInfo = await web3.getBlockInformation(blockNumber: 'latest');
  final baseFee = lastBlockInfo.baseFeePerGas!;
  final maxFeePerGas = baseFee.getInWei * BigInt.two + priorityFee!;
  final nonce = await web3.getTransactionCount(fromWallet.address);

  final signedTx = await web3.signTransaction(
    fromWallet,
    Transaction(
      from: fromWallet.address,
      to: to,
      maxGas: gas.toInt(),
      maxFeePerGas: EtherAmount.inWei(maxFeePerGas),
      maxPriorityFeePerGas: EtherAmount.inWei(priorityFee),
      value: EtherAmount.inWei(value),
      nonce: nonce,
    ),
    chainId: chainId,
  );

  final txHash = await web3.sendRawTransaction(signedTx);

  return await web3.getTransactionReceipt(txHash);
}
