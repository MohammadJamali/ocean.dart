import 'package:web3dart/web3dart.dart';

import 'clef.dart';
import 'contract_utils.dart';

typedef Future<dynamic> FunctionWrapper(
    List<dynamic> args, Map<String, dynamic> kwargs);

FunctionWrapper functionWrapper(DeployedContract contract, Web3Client web3,
    ContractFunction contractFunctions, String funcName) {
  // // Direct function calls
  // if (contract.findFunctionsByName(funcName).isNotEmpty) {
  //   return (List<dynamic> args, Map<String, dynamic> kwargs) async {
  //     return await contract.call(funcName, args, kwargs);
  //   };
  // }

  // Contract functions
  wrap(List<dynamic> args, Map<String, dynamic> kwargs) async {
    List<dynamic> args2 = List.from(args);
    Map<String, dynamic>? txDict;

    // Retrieve tx dict from either args or kwargs
    if (args.isNotEmpty && args.last is Map<String, dynamic>) {
      txDict = args.last["from"] != null ? args.removeLast() : null;
    }

    if (kwargs.containsKey("tx_dict")) {
      txDict = kwargs["tx_dict"]["from"] != null ? kwargs["tx_dict"] : null;
      kwargs.remove("tx_dict");
    }

    // Use addresses instead of wallets when doing the call
    args2 = args2
        .map((arg) => (arg is EthereumAddress) ? arg : arg.address)
        .toList();

    ContractFunction func = contract.findFunctionsByName(funcName).first;
    dynamic result = func.encodeCall(args2);
    // dynamic result = await func.call(args2, kwargs);
    String funcSignature = 'abiToSignature(result.abi)';

    // View/pure functions don't need "from" key in txDict
    if (txDict == null &&
        result.abi["stateMutability"] != "view" &&
        result.abi["stateMutability"] != "pure") {
      throw Exception("Needs txDict with 'from' key.");
    }

    // If it's a view/pure function, just call it
    if (result.abi["stateMutability"] == "view" ||
        result.abi["stateMutability"] == "pure") {
      return await result.call();
    } else {
      // If it's a transaction, build and send it
      EthereumAddress wallet = txDict!["from"];
      Map<String, dynamic> txDict2 = Map.from(txDict);
      txDict2["nonce"] = await web3.getTransactionCount(wallet);
      txDict2["from"] = txDict["from"].toString();

      result = await result.sendTransaction(txDict2);

      // Sign with wallet private key and send transaction
      if (wallet is ClefAccount) {
        result.forEach((k, v) {
          result[k] = (v is BigInt) ? '0x${v.toRadixString(16)}' : v;
        });

        dynamic rawSignedTx = await (wallet as ClefAccount)
            .provider
            .makeRPCCall("account_signTransaction", [result, funcSignature]);

        rawSignedTx = rawSignedTx["result"]["raw"];
      } else {
        // dynamic signedTx = await web3.signTransaction(
        //     result, (wallet as ClefAccount).privateKey!);
        dynamic signedTx = await web3.signTransaction(result, '' as dynamic);
        dynamic rawSignedTx = signedTx['rawTransaction'];

        await web3.sendRawTransaction(rawSignedTx);
      }

      // dynamic receipt =
      //     await web3.waitForTransactionReceipt(result.transactionHash);

      // return receipt;
      return 'receipt';
    }
  }

  return wrap;
}

class ContractBase {
  final String contractName;
  final Map<String, dynamic> configDict;
  final EthereumAddress address;
  late DeployedContract contract;

  ContractBase({
    required this.contractName,
    required this.configDict,
    required this.address,
  }) {
    contract = ContractUtils.loadContract(
      configDict['web3_instance'],
      contractName,
      address,
    );

    final transferable = contract.functions
        .map((func) => func.name)
        .where((name) => !name.startsWith('_'))
        .toList();

    for (final function in transferable) {
      final wrapperFunction = functionWrapper(
        contract,
        configDict['web3_instance'],
        contract.function(function),
        function,
      );
      // ignore: invalid_use_of_protected_member
      (this as dynamic).function = wrapperFunction;
    }
  }

  @override
  String toString() => '$contractName @ ${address.hex}';

  static EthereumAddress toChecksumAddress(String address) {
    return EthereumAddress.fromHex(address.toLowerCase());
  }

  String getEventSignature(String eventName) {
    final event = contract.event(eventName);
    if (event == null) {
      throw ArgumentError(
          'Event $eventName not found in $contractName contract.');
    }

    final sigStr =
        '$eventName(${event.components.map((param) => param.parameter.type).join(',')})';
    final hashed = EthereumAddress.fromHex(sigStr).hex;
    return hashed;
  }

  List<dynamic> getLogs(
    String eventName, {
    int fromBlock = 0,
    dynamic toBlock = 'latest',
  }) {
    // final topic = getEventSignature(eventName);
    final web3 = configDict['web3_instance'] as Web3Client;

    final filter = FilterOptions.events(
      contract: contract,
      event: contract.event(eventName),
      fromBlock: BlockNum.exact(fromBlock),
      toBlock: BlockNum.exact(toBlock),
      // topics: [topic],
    );

    final events = <dynamic>[];

    web3.getLogs(filter).asStream().listen((logs) async {
      for (final log in logs) {
        final receipt = await web3.getTransactionReceipt(log.transactionHash!);
        final event = contract.event(eventName);
        for (final FilterEvent receiptLog in receipt?.logs ?? []) {
          final processedEvents =
              event.decodeResults(receiptLog.topics!, receiptLog.data!);
          events.addAll(processedEvents);
        }
      }
    });

    return events;
  }

  // Function _functionWrapper(
  //     DeployedContract contract, Web3Client web3, ContractFunction func) {
  //   return (List<dynamic> args, Map<String, dynamic> txDict) async {
  //     // Implement function logic here
  //     // Note: You'll need to adapt the logic based on your specific requirements and available Dart packages
  //   };
  // }
}

// For the sake of this example, I've provided a basic structure.
// Implementing the complete functionality would require further details and adaptation based on available Dart libraries and tools.
