import 'dart:convert';

import 'package:web3dart/web3dart.dart';

import '../assets/ddo/ddo.dart';
import '../data_provider/data_service_provider.dart';
import '../models/compute_input.dart';
import '../models/data_nft.dart';
import '../models/data_nft_factory.dart';
import '../models/datatoken_base.dart';
import '../models/dispenser.dart';
import '../models/factory_router.dart';
import '../models/fixed_rate_exchange.dart';
import '../models/models.dart';
import '../services/service.dart';
import '../utils/logger.dart';
import 'ocean_assets/ocean_assets.dart';
import 'ocean_compute.dart' as ocompute;
import 'util.dart';

class Ocean {
  final Map<String, dynamic> configDict;
  OceanAssets assets;
  ocompute.OceanCompute compute;

  // Initialize Ocean class.
  // Usage: Make a new Ocean instance
  //
  // `ocean = Ocean({...})`
  //
  // This class provides the main top-level functions in ocean protocol:
  // 1. Publish assets metadata and associated services
  //     - Each asset is assigned a unique DID and a DID Document (DDO)
  //     - The DDO contains the asset's services including the metadata
  //     - The DID is registered on-chain with a URL of the metadata store
  //       to retrieve the DDO from
  //
  //     `ddo = ocean.assets.create(metadata, publisher_wallet)`
  //
  // 2. Discover/Search ddos via the current configured metadata store (Aquarius)
  //
  //     - Usage:
  //     `ddos_list = ocean.assets.search('search text')`
  //
  // An instance of Ocean is parameterized by a `Config` instance.
  //
  // :param config_dict: variable definitions
  // :param data_provider: `DataServiceProvider` instance
  Ocean(this.configDict) {
    _validateConfig();

    assets = OceanAssets(configDict, dataProvider);
    compute = ocompute.OceanCompute(configDict, dataProvider);

    logger.d('Ocean instance initialized');
  }

  void _validateConfig() {
    Map<String, String> configErrors = {};

    if (!configDict.containsKey('web3_instance')) {
      configErrors['web3_instance'] = 'required';
    }

    if (!configDict.containsKey('NETWORK_NAME')) {
      configErrors['NETWORK_NAME'] = 'required';
    }

    if (configErrors.isNotEmpty) {
      throw Exception(jsonEncode(configErrors));
    }
  }

  String get oceanAddress => getOceanTokenAddress(configDict);
  DatatokenBase get oceanToken => getDatatoken(oceanAddress);

  // Translate other properties and methods
  DataNFTFactoryContract get dataNFTFactory {
    return DataNFTFactoryContract(configDict, _addr('ERC721Factory'));
  }

  Dispenser get dispenser {
    return Dispenser(configDict, _addr('Dispenser'));
  }

  FixedRateExchange get fixedRateExchange {
    return FixedRateExchange(configDict, _addr('FixedPrice'));
  }

  FactoryRouter get factoryRouter {
    return FactoryRouter(configDict, _addr('Router'));
  }

  DataNFT getNftToken(String tokenAddress) {
    return DataNFT(configDict, tokenAddress);
  }

  DatatokenBase getDatatoken(String tokenAddress) {
    return DatatokenBase.getTyped(configDict, tokenAddress);
  }

  List<Map<String, dynamic>> getUserOrders(String address, String datatoken) {
    DatatokenBase dt = DatatokenBase.getTyped(configDict, datatoken);
    List<Map<String, dynamic>> orders = [];

    for (var log in dt.getStartOrderLogs(address)) {
      Map<String, dynamic> a = {
        ...log.args,
        "amount": int.parse(log.args['amount'].toString()),
        "address": log.address,
        "transactionHash": log.transactionHash
      };
      orders.add(a);
    }

    return orders;
  }

  Map<String, dynamic> retrieveProviderFees(
    DDO ddo,
    Service accessService,
    dynamic publisherWallet,
  ) {
    var initializeResponse = DataServiceProvider.initialize(
        ddo.did, accessService,
        consumerAddress: publisherWallet.address);
    var initializeData = jsonDecode(
        initializeResponse); // Assuming initializeResponse is a JSON string
    return initializeData["providerFee"];
  }

  Map<String, dynamic> retrieveProviderFeesForCompute(
      List<ComputeInput> datasets,
      dynamic algorithmData,
      String consumerAddress,
      String computeEnvironment,
      int validUntil) {
    var initializeComputeResponse = DataServiceProvider.initializeCompute(
      datasets.map((e) => e.asDictionary()).toList(),
      algorithmData.asDictionary(),
      datasets.first.service.serviceEndpoint,
      consumerAddress,
      computeEnvironment,
      validUntil,
    );
    return jsonDecode(
        initializeComputeResponse); // Assuming initializeComputeResponse is a JSON string
  }

  DFRewards get dfRewards {
    return DFRewards(configDict, _addr('DFRewards'));
  }

  DFStrategyV1 get dfStrategyV1 {
    return DFStrategyV1(configDict, _addr('DFStrategyV1'));
  }

  SmartWalletChecker get smartWalletChecker {
    return SmartWalletChecker(configDict, _addr('SmartWalletChecker'));
  }

  VeAllocate get veAllocate {
    return VeAllocate(configDict, _addr('veAllocate'));
  }

  VeDelegation get veDelegation {
    return VeDelegation(configDict, _addr('veDelegation'));
  }

  VeFeeDistributor get veFeeDistributor {
    return VeFeeDistributor(configDict, _addr('veFeeDistributor'));
  }

  VeFeeEstimate get veFeeEstimate {
    return VeFeeEstimate(configDict, _addr('veFeeEstimate'));
  }

  VeOcean get veOcean {
    return VeOcean(configDict, _addr('veOCEAN'));
  }

  VeOcean get veOCEAN => veOcean;

  Map<String, dynamic> get configDict => configDict;

  String _addr(String typeStr) {
    return getAddressOfType(
        configDict, typeStr); // Assuming getAddressOfType is defined
  }

  dynamic walletBalance(Wallet w) {
    return (configDict['web3_instance'] as Web3Client).getBalance(w.address);
  }
}
