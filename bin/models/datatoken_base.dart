import 'dart:typed_data';

import 'package:web3dart/web3dart.dart';

import '../ocean/util.dart';
import '../services/service.dart';
import '../structures/file_objects.dart';
import '../utils/logger.dart';
import '../web3_internal/constants.dart';
import '../web3_internal/contract_base.dart';
import 'data_nft.dart';
import 'datatoken1.dart';
import 'datatoken2.dart';
import 'dispenser.dart';
import 'fixed_rate_exchange.dart';

class TokenFeeInfo {
  String address;
  String token;
  int amount;

  TokenFeeInfo({String? address, String? token, int? amount})
      : address = address?.toLowerCase() ?? ZERO_ADDRESS,
        token = token?.toLowerCase() ?? ZERO_ADDRESS,
        amount = amount ?? 0;

  List<dynamic> toTuple() {
    return [address, token, amount];
  }

  factory TokenFeeInfo.fromTuple(List<dynamic> tuple) {
    return TokenFeeInfo(address: tuple[0], token: tuple[1], amount: tuple[2]);
  }

  @override
  String toString() {
    return 'TokenFeeInfo: \n'
        '  address = $address\n'
        '  token = $token\n'
        '  amount = $amount\n';
  }
}

class DatatokenArguments {
  String name;
  String symbol;
  int templateIndex;
  String? minter;
  String? feeManager;
  TokenFeeInfo publishMarketOrderFees;
  List<Uint8List> bytess;
  List<dynamic>? services;
  List<FilesType>? files;
  List<Map<String, dynamic>>? consumerParameters;
  int cap;

  DatatokenArguments({
    String name = 'Datatoken 1',
    String symbol = 'DT1',
    int templateIndex = 1,
    String? minter,
    String? feeManager,
    TokenFeeInfo? publishMarketOrderFees,
    List<Uint8List>? bytess,
    List<dynamic>? services,
    List<FilesType>? files,
    List<Map<String, dynamic>>? consumerParameters,
    int? cap,
  })  : cap = cap ?? 115792089237316195423570985008687907853269984665640564039457584007913129639935,
        name = name,
        symbol = symbol,
        templateIndex = templateIndex,
        minter = minter,
        feeManager = feeManager,
        publishMarketOrderFees = publishMarketOrderFees ?? TokenFeeInfo(),
        bytess = bytess ?? [Uint8List(0)],
        services = services,
        files = files,
        consumerParameters = consumerParameters;

  Datatoken createDatatoken(DataNFT dataNft, Map<String, dynamic> txDict, {bool withServices = false}) {
    final configDict = dataNft.configDict;
    final oceanAddress = getOceanTokenAddress(configDict);
    final initialList = dataNft.getTokensList();

    final walletAddress = getFromAddress(txDict);

    if (publishMarketOrderFees.address == ZERO_ADDRESS && publishMarketOrderFees.token == ZERO_ADDRESS) {
      publishMarketOrderFees = TokenFeeInfo(address: walletAddress, token: oceanAddress);
    }

    dataNft.createERC20(
      templateIndex,
      [name, symbol],
      [
        ContractBase.toChecksumAddress(minter ?? walletAddress),
        ContractBase.toChecksumAddress(feeManager ?? walletAddress),
        publishMarketOrderFees.address,
        publishMarketOrderFees.token,
      ],
      [cap, publishMarketOrderFees.amount],
      bytess,
      txDict,
    );

    final newElements = [for (final item in dataNft.getTokensList()) if (!initialList.contains(item)) item];
    assert(newElements.length == 1, 'New datatoken has no address');

    final datatoken = DatatokenBase.getTyped(configDict, newElements[0]);

    logger.i('Successfully created datatoken with address ${datatoken.address}.');

    if (withServices) {
      services ??= [
        datatoken.buildAccessService(
          serviceId: '0',
          serviceEndpoint: configDict['PROVIDER_URL'],
          files: files,
          consumerParameters: consumerParameters,
        ),
      ];
    }

    return datatoken;
  }
}

class DatatokenRoles extends IntEnum {
  static const MINTER = DatatokenRoles(0);
  static const PAYMENT_MANAGER = DatatokenRoles(1);

  const DatatokenRoles(int value) : super(value);
}

class DatatokenBase extends ContractBase {
  static const int BASE = 10^18;
  static const double BASE_COMMUNITY_FEE_PERCENTAGE = BASE / 1000;
  static const double BASE_MARKET_FEE_PERCENTAGE = BASE / 1000;

  DatatokenBase({
    String? contractName,
  required  Map<String, dynamic> configDict,
    required EthereumAddress address,
  }) : super(
          contractName: contractName ?? "ERC20Template",
          configDict: configDict,
          address: address,
        );

  static DatatokenBase getTyped(Map<String, dynamic> config, String address) {
    final datatoken = Datatoken1(config, address);

    try {
      final templateId = datatoken.getId();
    } catch (e) {
      return Datatoken2(config, address);
    }

    return datatoken;
  }

  Future<String> startOrder(
    String consumer,
    int serviceIndex,
    Map<String, dynamic> providerFees,
    Map<String, dynamic> txDict, {
    TokenFeeInfo? consumeMarketFees,
  }) async {
    consumeMarketFees ??= TokenFeeInfo();

    return await startOrder(
      checksumAddr(consumer),
      serviceIndex,
      [
        checksumAddr(providerFees["providerFeeAddress"]),
        checksumAddr(providerFees["providerFeeToken"]),
        int.parse(providerFees["providerFeeAmount"]),
        providerFees["v"],
        providerFees["r"],
        providerFees["s"],
        providerFees["validUntil"],
        providerFees["providerData"],
      ],
      consumeMarketFees.toTuple(),
      txDict,
    );
  }

  Future<String> reuseOrder(
    dynamic orderTxId,
    Map<String, dynamic> providerFees,
    Map<String, dynamic> txDict,
  ) async {
    return await reuseOrder(
      orderTxId,
      [
        checksumAddr(providerFees["providerFeeAddress"]),
        checksumAddr(providerFees["providerFeeToken"]),
        int.parse(providerFees["providerFeeAmount"]),
        providerFees["v"],
        providerFees["r"],
        providerFees["s"],
        providerFees["validUntil"],
        providerFees["providerData"],
      ],
      txDict,
    );
  }

  Future<List> getStartOrderLogs({
    String? consumerAddress,
    int fromBlock = 0,
    dynamic toBlock = "latest",
  }) async {
    final topic0 = getEventSignature("OrderStarted");
    var topics = [topic0];
    if (consumerAddress != null) {
      final topic1 = "0x000000000000000000000000${consumerAddress.substring(2).toLowerCase()}";
      topics = [topic0, topic1];
    }

    final web3 = configDict["web3_instance"] as Web3Client;
    final eventFilter = web3.filter(
      {
        "topics": topics,
        "toBlock": toBlock,
        "fromBlock": fromBlock,
      },
    );

    final orders = [];

    for (final log in eventFilter.getAllEntries()) {
      final receipt = await web3.getTransactionReceipt(log.transactionHash);
      final processedEvents = contract.events.OrderStarted().processReceipt(receipt, errors: DISCARD);
      for (final processedEvent in processedEvents) {
        orders.add(processedEvent);
      }
    }

    return orders;
  }

  Future<dynamic> createExchange(Map<String, dynamic> txDict, [List<dynamic>? args, Map<String, dynamic>? kwargs]) async {
    final exchangeArgs = getArgsObject(args, kwargs, ExchangeArguments());
    final argsTuple = exchangeArgs.toTuple(configDict, txDict, decimals());

    final tx = createFixedRate(argsTuple + [txDict]);

    final event = contract.events.NewFixedRate().processReceipt(tx, errors: DISCARD)[0];
    final exchangeId = event.args.exchangeId;
    final FRE = _FRE();
    final exchange = OneExchange(FRE, exchangeId);

    return kwargs != null && kwargs["fullInfo"] ? (exchange, tx) : exchange;
  }

  List<dynamic> getExchanges({bool onlyActive = true}) {
    final exchanges = [];
    final addrsAndExchangeIds = getFixedRates();
    final FRE = _FRE();

    exchanges.addAll([
      OneExchange(
        FixedRateExchange(configDict, address),
        exchangeId,
      )
      for (final List<String> [address, exchangeId] in addrsAndExchangeIds
    ]);

    if (!onlyActive) {
      return exchanges;
    }

    return [for (final exchange in exchanges) if (exchange.isActive()) exchange];
  }

  FixedRateExchange _FRE() {
    final FREAddress = getAddressOfType(configDict, "FixedPrice");
    return FixedRateExchange(configDict, FREAddress);
  }
    Future<dynamic> createDispenser(Map<String, dynamic> txDict, [List<dynamic>? args, Map<String, dynamic>? kwargs]) async {
    // already created, so nothing to do
    if (dispenserStatus().active) {
      return;
    }

    final dispenserArgs = getArgsObject(args, kwargs, DispenserArguments());
    final argsTuple = dispenserArgs.toTuple(configDict);

    // do contract tx
    final tx = createDispenser([...argsTuple, txDict]);

    return tx;
  }

  List<dynamic> getDispensers({bool onlyActive = true}) {
    final dispensers = [];
    final addrs = getDispensers();
    
    dispensers.addAll([Dispenser(configDict, address) for final address in addrs]);

    if (!onlyActive) {
      return dispensers;
    }

    return [for (final disp in dispensers) if (disp.status(address)) disp];
  }

  Future<dynamic> dispense(dynamic amount, Map<String, dynamic> txDict) async {
    // args for contract tx
    final datatokenAddr = address;
    final fromAddr = getFromAddress(txDict);

    // do contract tx
    final tx = _oceanDispenser().dispense(datatokenAddr, amount, fromAddr, txDict);
    return tx;
  }

  dynamic dispenserStatus() {
    return DispenserStatus(_oceanDispenser().status(address));
  }

  dynamic _oceanDispenser() {
    return Dispenser(configDict, getAddressOfType(configDict, "Dispenser"));
  }

  Service buildAccessService(String serviceId, String serviceEndpoint, List<FilesType> files, {int timeout = 3600, List<dynamic>? consumerParameters}) {
    return Service(
      serviceId: serviceId,
      serviceType: ServiceTypes.ASSET_ACCESS,
      serviceEndpoint: serviceEndpoint,
      datatoken: address,
      files: files,
      timeout: timeout,
      consumerParameters: consumerParameters,
    );
  }

  dynamic getPublishMarketOrderFees() {
    return TokenFeeInfo.fromTuple(getPublishingMarketFee());
  }
Future<dynamic> getFromPricingSchemaAndOrder(List<dynamic> args, Map<String, dynamic> kwargs) async {
    final dispensers = dispenserStatus().active;
    final exchanges = getExchanges();

    if (!dispensers && !exchanges) {
      throw ArgumentError("No pricing schemas found");
    }

    if (dispensers) {
      kwargs.remove("consume_market_swap_fee_amount");
      kwargs.remove("consume_market_swap_fee_address");

      return await dispenseAndOrder(args, kwargs);
    }

    final exchange = getExchanges()[0];
    kwargs["exchange"] = exchange;

    var consumeMarketFees = kwargs["consume_market_fees"];
    if (consumeMarketFees == null) {
      consumeMarketFees = TokenFeeInfo();
    }

    final wallet = kwargs["tx_dict"]["from"] as EthereumAddress;
    final amtNeeded = exchange.BTNeeded(EtherAmount.fromUnitAndValue(EtherUnit.ether, 1), consumeMarketFees.amount);
    final baseToken = DatatokenBase.getTyped(exchange._FRE.configDict, exchange.details.baseToken);
    final baseTokenBalance = await baseToken.balanceOf(wallet);

    if (baseTokenBalance < amtNeeded.getInWei) {
      throw ArgumentError(
        "Your token balance $baseTokenBalance ${baseToken.symbol()} is not sufficient "
        "to execute the requested service. This service "
        "requires $amtNeeded ${baseToken.symbol()}.",
      );
    }

    EthereumAddress approveAddress;
    if (getId() == 1) {
      approveAddress = exchange.address;
      kwargs.remove("consume_market_swap_fee_amount");
      kwargs.remove("consume_market_swap_fee_address");
    } else {
      approveAddress = address;
      kwargs["max_base_token_amount"] = amtNeeded.getInWei;
    }

    await baseToken.approve(
      approveAddress,
      amtNeeded.getInWei,
      credentials: WalletCallCredentials.fromAddress(wallet),
    );

    return await buyDTAndOrder(args, kwargs);
  }
}

class MockERC20 extends DatatokenBase {
  static const CONTRACT_NAME = 'MockERC20';

  @override
  int getId() {
    return 1;
  }
}

class MockOcean extends DatatokenBase {
  static const CONTRACT_NAME = 'MockOcean';

  @override
  int getId() {
    return 1;
  }
}
