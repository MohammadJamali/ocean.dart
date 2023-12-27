import '../ocean/util.dart';
import '../web3_internal/constants.dart';
import '../web3_internal/contract_base.dart';
import 'datatoken_base.dart';
import 'fixed_rate_exchange.dart';

class Datatoken1 extends DatatokenBase {
  static const CONTRACT_NAME = "ERC20Template";

  static const BASE = 10**18;
  static const BASE_COMMUNITY_FEE_PERCENTAGE = BASE / 1000;
  static const BASE_MARKET_FEE_PERCENTAGE = BASE / 1000;

  Future<String> dispenseAndOrder(
    Map<String, dynamic> providerFees,
    Map<String, dynamic> txDict, {
    String? consumer,
    int serviceIndex = 1,
    dynamic consumeMarketFees,
  }) async {
    consumer ??= getFromAddress(txDict);
    consumeMarketFees ??= TokenFeeInfo();

    String buyerAddr = getFromAddress(txDict);

    double bal = fromWei(balanceOf(buyerAddr));
    if (bal < 1.0) {
      List dispensers = getDispensers();

      assert(dispensers.isNotEmpty, "there are no dispensers for this datatoken");
      var dispenser = dispensers[0];

      // catch key failure modes
      var st = dispenser.status(address);
      bool active = st[0], allowedSwapper = st[6];
      if (!active) {
        throw ArgumentError("No active dispenser for datatoken");
      }
      if (allowedSwapper != ZERO_ADDRESS && allowedSwapper != buyerAddr) {
        throw ArgumentError("Not allowed. allowedSwapper=$allowedSwapper");
      }

      // Try to dispense. If other issues, they'll pop out
      dispenser.dispense(address, toWei(1), buyerAddr, txDict);
    }

    return await startOrder(
      consumer: ContractBase.toChecksumAddress(consumer),
      serviceIndex: serviceIndex,
      providerFees: providerFees,
      consumeMarketFees: consumeMarketFees,
      txDict: txDict,
    );
  }

  Future<String> buyDtAndOrder(
    Map<String, dynamic> providerFees,
    dynamic exchange,
    Map<String, dynamic> txDict, {
    String? consumer,
    int serviceIndex = 1,
    dynamic consumeMarketFees,
  }) async {
    consumer ??= getFromAddress(txDict);

    List exchanges = getExchanges();
    assert(exchanges.isNotEmpty, "there are no fixed rate exchanges for this datatoken");

    consumeMarketFees ??= TokenFeeInfo();

    if (exchange is! OneExchange) {
      exchange = exchanges[0];
    }

    exchange.buyDt(
      datatokenAmt: toWei(1),
      consumeMarketFeeAddr: consumeMarketFees.address,
      consumeMarketFee: consumeMarketFees.amount,
      txDict: txDict,
    );

    return await startOrder(
      consumer: ContractBase.toChecksumAddress(consumer),
      serviceIndex: serviceIndex,
      providerFees: providerFees,
      consumeMarketFees: consumeMarketFees,
      txDict: txDict,
    );
  }
}
