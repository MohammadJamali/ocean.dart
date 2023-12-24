import 'dart:typed_data';

class Datatoken2 extends DatatokenBase {
  static const String CONTRACT_NAME = "ERC20TemplateEnterprise";

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
    if (consumer == null) {
      consumer = getFromAddress(txDict);
    }

    List exchanges = getExchanges();
    assert(exchanges.isNotEmpty, "there are no fixed rate exchanges for this datatoken");

    // import now, to avoid circular import
    from ocean_lib.models.fixed_rate_exchange import OneExchange;

    if (consumeMarketFees == null) {
      consumeMarketFees = TokenFeeInfo();
    }

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
    if (consumeMarketFees == null) {
      consumeMarketFees = TokenFeeInfo();
    }

    if (consumer == null) {
      consumer = getFromAddress(txDict);
    }

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
