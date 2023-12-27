import 'package:web3dart/web3dart.dart';

import '../ocean/util.dart';
import '../web3_internal/constants.dart';
import '../web3_internal/contract_base.dart';
import 'datatoken_base.dart';

class Datatoken2 extends DatatokenBase {
  Datatoken2(
    Map<String, dynamic> configDict,
    EthereumAddress address,
  ) : super(
          contractName: "ERC20TemplateEnterprise",
          configDict: configDict,
          address: address,
        );

  String buyDtAndOrder(
    Map<String, dynamic> providerFees,
    dynamic exchange,
    Map<String, dynamic> txDict, {
    String? consumer,
    int serviceIndex = 1,
    dynamic consumeMarketFees,
    dynamic maxBaseTokenAmount,
    dynamic consumeMarketSwapFeeAmount = 0,
    String consumeMarketSwapFeeAddress = ZERO_ADDRESS,
  }) {
    consumer ??= getFromAddress(txDict);

    List exchanges = getExchanges();
    assert(exchanges.isNotEmpty,
        "there are no fixed rate exchanges for this datatoken");

    consumeMarketFees ??= TokenFeeInfo();
    if (maxBaseTokenAmount == null) {
      var amtNeeded = exchange.BTNeeded(toWei(1), consumeMarketFees.amount);
      maxBaseTokenAmount = amtNeeded;
    }

    return buyFromFreAndOrder(
      [
        ContractBase.toChecksumAddress(consumer),
        serviceIndex,
        [
          checksumAddr(providerFees["providerFeeAddress"]),
          checksumAddr(providerFees["providerFeeToken"]),
          providerFees["providerFeeAmount"],
          providerFees["v"],
          providerFees["r"],
          providerFees["s"],
          providerFees["validUntil"],
          providerFees["providerData"],
        ],
        consumeMarketFees.toTuple(),
      ],
      [
        ContractBase.toChecksumAddress(exchange.address),
        exchange.exchangeId,
        maxBaseTokenAmount,
        consumeMarketSwapFeeAmount,
        ContractBase.toChecksumAddress(consumeMarketSwapFeeAddress),
      ],
      txDict,
    );
  }

  String dispenseAndOrder(
    Map<String, dynamic> providerFees,
    Map<String, dynamic> txDict, {
    String? consumer,
    int serviceIndex = 1,
    dynamic consumeMarketFees,
  }) {
    consumeMarketFees ??= TokenFeeInfo();

    consumer ??= getFromAddress(txDict);

    List dispensers = getDispensers();
    assert(dispensers.isNotEmpty, "there are no dispensers for this datatoken");
    var dispenser = dispensers[0];

    return buyFromDispenserAndOrder(
      [
        ContractBase.toChecksumAddress(consumer),
        serviceIndex,
        [
          checksumAddr(providerFees["providerFeeAddress"]),
          checksumAddr(providerFees["providerFeeToken"]),
          providerFees["providerFeeAmount"],
          providerFees["v"],
          providerFees["r"],
          providerFees["s"],
          providerFees["validUntil"],
          providerFees["providerData"],
        ],
        consumeMarketFees.toTuple(),
      ],
      ContractBase.toChecksumAddress(dispenser.address),
      txDict,
    );
  }
}

// Add necessary classes and methods based on your requirements.
