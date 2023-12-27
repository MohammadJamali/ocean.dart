import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../structures/abi_tuples/order_data.dart';
import '../structures/abi_tuples/reuse_order_data.dart';
import '../web3_internal/contract_base.dart';
import 'data_nft.dart';
import 'datatoken_base.dart';
import 'erc721_token_factory_base.dart';

class DataNFTFactoryContract extends ERC721TokenFactoryBase {
  DataNFTFactoryContract(
    Map<String, dynamic> configDict,
    EthereumAddress address,
  ) : super(
          contractName: "ERC721Factory",
          configDict: configDict,
          address: address,
        );

  @override
  bool verifyNFT(String nftAddress) {
    DataNFTContract dataNFTContract = DataNFTContract(configDict, nftAddress);
    try {
      dataNFTContract.getId();
      return true;
    } on BadFunctionCallOutput {
      return false;
    }
  }

  @override
  dynamic create(Map<String, dynamic> txDict,
      [List<dynamic>? args, Map<String, dynamic>? kwargs]) {
    DataNFTArguments dataNFTArgs =
        getArgsObject(args, kwargs, DataNFTArguments);

    return dataNFTArgs.deployContract(configDict, txDict);
  }

  @override
  String startMultipleTokenOrder(
      List<OrderData> orders, Map<String, dynamic> txDict) {
    for (OrderData order in orders) {
      order.tokenAddress = ContractBase.toChecksumAddress(order.tokenAddress);
      order.consumer = ContractBase.toChecksumAddress(order.consumer);
      order.providerFees[0] =
          ContractBase.toChecksumAddress(order.providerFees[0]);
      order.providerFees[1] =
          ContractBase.toChecksumAddress(order.providerFees[1]);
      order.consumeFees[0] =
          ContractBase.toChecksumAddress(order.consumeFees[0]);
      order.consumeFees[1] =
          ContractBase.toChecksumAddress(order.consumeFees[1]);
    }

    return startMultipleTokenOrder(orders, txDict);
  }

  @override
  String reuseMultipleTokenOrder(
      List<ReuseOrderData> reuseOrders, Map<String, dynamic> txDict) {
    for (ReuseOrderData order in reuseOrders) {
      order.tokenAddress = ContractBase.toChecksumAddress(order.tokenAddress);
      order.providerFees[0] =
          ContractBase.toChecksumAddress(order.providerFees[0]);
      order.providerFees[1] =
          ContractBase.toChecksumAddress(order.providerFees[1]);
    }

    return reuseMultipleTokenOrder(reuseOrders, txDict);
  }

  @override
  String createWithERC20(
      dataNFTArgs, datatokenArgs, Map<String, dynamic> txDict) {
    String walletAddress = get(txDict);
    var receipt = createNftWithErc20(
      [
        dataNFTArgs.name,
        dataNFTArgs.symbol,
        dataNFTArgs.templateIndex,
        dataNFTArgs.uri,
        dataNFTArgs.transferable,
        ContractBase.toChecksumAddress(dataNFTArgs.owner ?? walletAddress),
      ],
      [
        datatokenArgs.templateIndex,
        [datatokenArgs.name, datatokenArgs.symbol],
        [
          ContractBase.toChecksumAddress(datatokenArgs.minter ?? walletAddress),
          ContractBase.toChecksumAddress(
              datatokenArgs.feeManager ?? walletAddress),
          ContractBase.toChecksumAddress(
              datatokenArgs.publishMarketOrderFees.address),
          ContractBase.toChecksumAddress(
              datatokenArgs.publishMarketOrderFees.token),
        ],
        [datatokenArgs.cap, datatokenArgs.publishMarketOrderFees.amount],
        datatokenArgs.bytess,
      ],
      txDict,
    );

    var registeredNFTEvent = contract.events.NFTCreated().processReceipt(
          receipt,
          errors: DISCARD,
        )[0];
    var dataNFTAddress = registeredNFTEvent.args.newTokenAddress;
    var dataNFTToken = DataNFT(configDict, dataNFTAddress);

    var registeredTokenEvent = contract.events.TokenCreated().processReceipt(
          receipt,
          errors: DISCARD,
        )[0];
    var datatokenAddress = registeredTokenEvent.args.newTokenAddress;
    var datatoken = DatatokenBase.getTyped(configDict, datatokenAddress);

    return [dataNFTToken, datatoken];
  }

  String createWithErc20AndFixedRate(
    dataNftArgs,
    datatokenArgs,
    fixedPriceArgs,
    Map<String, dynamic> txDict,
  ) {
    String walletAddress = getFromAddress(txDict);

    var receipt = createNftWithErc20WithFixedRate(
      [
        dataNftArgs.name,
        dataNftArgs.symbol,
        dataNftArgs.templateIndex,
        dataNftArgs.uri,
        dataNftArgs.transferable,
        ContractBase.toChecksumAddress(dataNftArgs.owner ?? walletAddress),
      ],
      [
        datatokenArgs.templateIndex,
        [datatokenArgs.name, datatokenArgs.symbol],
        [
          ContractBase.toChecksumAddress(datatokenArgs.minter ?? walletAddress),
          ContractBase.toChecksumAddress(
              datatokenArgs.feeManager ?? walletAddress),
          ContractBase.toChecksumAddress(
              datatokenArgs.publishMarketOrderFees.address),
          ContractBase.toChecksumAddress(
              datatokenArgs.publishMarketOrderFees.token),
        ],
        [datatokenArgs.cap, datatokenArgs.publishMarketOrderFees.amount],
        datatokenArgs.bytess,
      ],
      fixedPriceArgs.toTuple(configDict, txDict),
      txDict,
    );

    var registeredNFTEvent = contract.events.NFTCreated().processReceipt(
          receipt,
          errors: DISCARD,
        )[0];
    var dataNFTAddress = registeredNFTEvent.args.newTokenAddress;
    var dataNFTToken = DataNFT(configDict, dataNFTAddress);

    var registeredTokenEvent = contract.events.TokenCreated().processReceipt(
          receipt,
          errors: DISCARD,
        )[0];
    var datatokenAddress = registeredTokenEvent.args.newTokenAddress;
    var datatoken = DatatokenBase.getTyped(configDict, datatokenAddress);

    var registeredFixedRateEvent =
        (contract.events.NewFixedRate().processReceipt(
              receipt,
              errors: DISCARD,
            )[0]);
    var exchangeId = registeredFixedRateEvent.args.exchangeId;
    var fixedRateExchange = FixedRateExchange(
      configDict,
      getAddressOfType(configDict, "FixedPrice"),
    );
    var exchange = OneExchange(fixedRateExchange, exchangeId);

    return [dataNFTToken, datatoken, exchange];
  }

  String createWithErc20AndDispenser(
    dataNftArgs,
    datatokenArgs,
    dispenserArgs,
    Map<String, dynamic> txDict,
  ) {
    String walletAddress = getFromAddress(txDict);

    var receipt = createNftWithErc20WithDispenser(
      [
        dataNftArgs.name,
        dataNftArgs.symbol,
        dataNftArgs.templateIndex,
        dataNftArgs.uri,
        dataNftArgs.transferable,
        ContractBase.toChecksumAddress(dataNftArgs.owner ?? walletAddress),
      ],
      [
        datatokenArgs.templateIndex,
        [datatokenArgs.name, datatokenArgs.symbol],
        [
          ContractBase.toChecksumAddress(datatokenArgs.minter ?? walletAddress),
          ContractBase.toChecksumAddress(
              datatokenArgs.feeManager ?? walletAddress),
          ContractBase.toChecksumAddress(
              datatokenArgs.publishMarketOrderFees.address),
          ContractBase.toChecksumAddress(
              datatokenArgs.publishMarketOrderFees.token),
        ],
        [datatokenArgs.cap, datatokenArgs.publishMarketOrderFees.amount],
        datatokenArgs.bytess,
      ],
      dispenserArgs.toTuple(configDict),
      txDict,
    );

    var registeredNFTEvent = contract.events.NFTCreated().processReceipt(
          receipt,
          errors: DISCARD,
        )[0];
    var dataNFTAddress = registeredNFTEvent.args.newTokenAddress;
    var dataNFTToken = DataNFT(configDict, dataNFTAddress);

    var registeredTokenEvent = contract.events.TokenCreated().processReceipt(
          receipt,
          errors: DISCARD,
        )[0];
    var datatokenAddress = registeredTokenEvent.args.newTokenAddress;
    var datatoken = DatatokenBase.getTyped(configDict, datatokenAddress);

    var registeredDispenserEvent =
        (contract.events.DispenserCreated().processReceipt(
              receipt,
              errors: DISCARD,
            )[0]);
    assert(registeredDispenserEvent.args.datatokenAddress == datatokenAddress);

    return [dataNFTToken, datatoken];
  }
  
  String createWithMetadata(
    dataNftArgs,
    int metadataState,
    String metadataDecryptorUrl,
    Uint8List metadataDecryptorAddress,
    Uint8List metadataFlags,
    dynamic metadataData,
    dynamic metadataDataHash,
    List<MetadataProof> metadataProofs,
    Map<String, dynamic> txDict,
  ) {
    String walletAddress = getFromAddress(txDict);

    var receipt = createNftWithMetaData(
      [
        dataNftArgs.name,
        dataNftArgs.symbol,
        dataNftArgs.templateIndex,
        dataNftArgs.uri,
        dataNftArgs.transferable,
        ContractBase.toChecksumAddress(dataNftArgs.owner ?? walletAddress),
      ],
      [
        metadataState,
        metadataDecryptorUrl,
        metadataDecryptorAddress,
        metadataFlags,
        metadataData,
        metadataDataHash,
        metadataProofs,
      ],
      txDict,
    );

    var registeredNFTEvent = contract.events.NFTCreated().processReceipt(
      receipt,
      errors: DISCARD,
    )[0];
    var dataNFTAddress = registeredNFTEvent.args.newTokenAddress;
    var dataNFTToken = DataNFT(configDict, dataNFTAddress);

    return dataNFTToken;
  }

  List searchExchangeByDatatoken(
    FixedRateExchange fixedRateExchange,
    String datatoken, [
    String? exchangeOwner,
  ]) {
    var datatokenContract = DatatokenBase.getTyped(configDict, datatoken);
    var exchangeAddressesAndIds = datatokenContract.getFixedRates();
    return (exchangeOwner == null)
        ? exchangeAddressesAndIds
        : [
            exchangeAddressAndId
            for (exchangeAddressAndId in exchangeAddressesAndIds
            if fixedRateExchange.getExchange(exchangeAddressAndId[1])[0] == exchangeOwner
          ];
  }

  getTokenAddress(receipt) {
    var event = contract.events.NFTCreated().processReceipt(
      receipt,
      errors: DISCARD,
    )[0];
    return event.args.newTokenAddress;
  }

  bool checkDatatoken(String datatokenAddress) {
    return erc20List(datatokenAddress);
  }

  bool checkNFT(String nftAddress) {
    return erc721List(nftAddress) == nftAddress;
  }
}

