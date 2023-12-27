import 'package:web3dart/web3dart.dart';

import '../ocean/util.dart';
import '../web3_internal/constants.dart';
import '../web3_internal/contract_base.dart';

class Dispenser extends ContractBase {
  Dispenser(
    Map<String, dynamic> configDict,
    EthereumAddress address,
  ) : super(
          contractName: "Dispenser",
          configDict: configDict,
          address: address,
        );
}

class DispenserArguments {
  final dynamic maxTokens;
  final dynamic maxBalance;
  final bool withMint;
  final String allowedSwapper;

  DispenserArguments({
    this.maxTokens = MAX_UINT256,
    this.maxBalance = MAX_UINT256,
    this.withMint = true,
    this.allowedSwapper = ZERO_ADDRESS,
  });

  List<dynamic> toTuple(Map<String, dynamic> configDict) {
    final dispenserAddress = get_address_of_type(configDict, 'Dispenser');
    return [
      ContractBase.toChecksumAddress(dispenserAddress),
      maxTokens,
      maxBalance,
      withMint,
      allowedSwapper,
    ];
  }
}

class DispenserStatus {
  bool active;
  String ownerAddress;
  bool isMinter;
  int maxTokens;
  int maxBalance;
  int balance;
  String allowedSwapper;

  DispenserStatus(List<dynamic> statusTuple) {
    active = statusTuple[0];
    ownerAddress = statusTuple[1];
    isMinter = statusTuple[2];
    maxTokens = statusTuple[3];
    maxBalance = statusTuple[4];
    balance = statusTuple[5];
    allowedSwapper = statusTuple[6];
  }

  @override
  String toString() {
    final stringBuffer = StringBuffer();
    stringBuffer.write('DispenserStatus: ');
    stringBuffer.write('  active = $active\n');
    stringBuffer.write('  ownerAddress = $ownerAddress\n');
    stringBuffer.write('  balance (of tokens) = ${_strWithWei(balance)}\n');
    stringBuffer.write('  isMinter (can mint more tokens?) = $isMinter\n');
    stringBuffer
        .write('  maxTokens (to dispense) = ${_strWithWei(maxTokens)}\n');
    stringBuffer
        .write('  maxBalance (of requester) = ${_strWithWei(maxBalance)}\n');
    if (allowedSwapper.toLowerCase() == ZERO_ADDRESS.toLowerCase()) {
      stringBuffer.write('  allowedSwapper = anyone can request\n');
    } else {
      stringBuffer.write('  allowedSwapper = $allowedSwapper\n');
    }
    return stringBuffer.toString();
  }
}

String _strWithWei(int xWei) {
  return '${fromWei(BigInt.from(xWei))} ($xWei wei)';
}
