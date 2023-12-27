import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:web3dart/web3dart.dart';

import '../../aquarius/aquarius.dart';
import '../../assets/asset_downloader.dart';
import '../../assets/ddo/ddo.dart';
import '../../data_provider/data_encryptor.dart';
import '../../models/compute_input.dart';
import '../../models/data_nft.dart';
import '../../models/data_nft_factory.dart';
import '../../models/datatoken_base.dart';
import '../../models/exception/aquarius_error.dart';
import '../../services/service.dart';
import '../../structures/file_objects.dart';
import '../../utils/logger.dart';
import '../../web3_internal/constants.dart';
import 'asset_arguments.dart';

class OceanAssets {
  final Config _config;
  final int _chainId;
  final String? _metadataCacheUri;
  final DataServiceProvider _dataProvider;
  final String _downloadsPath;
  final Aquarius _aquarius;
  final DataNFTFactoryContract dataNftFactory;

  OceanAssets(this._config, this._dataProvider) {
    _chainId = _config.chainId;
    _metadataCacheUri = _config.metadataCacheUri;
    var currentDirectory = Directory.current.path;
    _downloadsPath =
        _config.downloadsPath ?? join(currentDirectory, 'downloads');
    _aquarius = Aquarius.getInstance(_metadataCacheUri);

    dataNftFactory = DataNFTFactoryContract(
      _config,
      _config.getAddressOfType('ERC721Factory'),
    );
  }

  Future<ValidationResult> validate(DDO ddo) async {
    /// Validate that the DDO is ok to be stored in Aquarius.

    var validation = await _aquarius.validateDdo(ddo);
    if (!validation.isValid) {
      var msg = 'DDO has validation errors: ${validation.errors}';
      logger.e(msg);
      throw FormatException(msg);
    }

    return validation;
  }

  Uint8List encryptDdo(DDO ddo,
      String providerUri, {
        bool encryptFlag = true,
        bool compressFlag = true,
      }) {
    // Process the DDO
    var ddoDict = ddo.toJson();
    var ddoString = json.encode(ddoDict);
    var ddoBytes = utf8.encode(ddoString);
    var ddoHash = createChecksum(ddoString);

    // Plain DDO
    if (!encryptFlag && !compressFlag) {
      var flags = Uint8List.fromList([0]);
      return Uint8List.fromList(ddoBytes + flags + ddoHash.bytes);
    }

    // Only compression, not encrypted
    if (compressFlag && !encryptFlag) {
      var flags = Uint8List.fromList([1]);
      var document = compress(ddoBytes);
      return Uint8List.fromList(document + flags + ddoHash.bytes);
    }

    Uint8List document;

    // Only encryption, not compressed
    if (encryptFlag && !compressFlag) {
      var flags = Uint8List.fromList([2]);
      // Encrypt DDO
      var encryptedDocument = DataEncryptor.encrypt(
        objectsToEncrypt: ddoString,
        providerUri: providerUri,
        chainId: ddo.chainId,
      );
      document =
          encryptedDocument; // This is dummy, replace it with actual functionality
      return Uint8List.fromList(document + flags + ddoHash.bytes);
    }

    // Encrypted & compressed
    var flags = Uint8List.fromList([3]);
    // Compress DDO
    var compressedDocument = compress(ddoBytes);

    // Encrypt DDO
    var encryptedDocument = DataEncryptor.encrypt(
      objectsToEncrypt: compressedDocument,
      providerUri: providerUri,
      chainId: ddo.chainId,
    );

    document =
        encryptedDocument; // This is dummy, replace it with actual functionality

    return Uint8List.fromList(document + flags + ddoHash.bytes);
  }

  void assertDdoMetadata(Map metadata) {
    assert(metadata is Map, "Expected metadata of type Map, got ${metadata
        .runtimeType}");

    var assetType = metadata['type'];

    final allowedAssetTypes = {'dataset', 'algorithm'};
    assert(allowedAssetTypes.contains(
        assetType), "Invalid/unsupported asset type $assetType");

    assert(metadata.containsKey('name'), "Must have name in metadata.");
  }

  Tuple createAlgoAsset(String name,
      String url,
      Map txDict, {
        String image = "oceanprotocol/algo_dockers",
        String tag = "python-branin",
        String checksum = "sha256:8221d20c1c16491d7d56b9657ea09082c0ee4a8ab1a6621fa720da58b09580e4",
        Map? metadata,
        // ... any other parameters that might replace *args and **kwargs
      }) {
    // Assuming AssetArguments and other related classes are already converted into Dart variants
    AssetArguments assetArgs = getAssetArguments(
        metadata, name, txDict, "algorithm");

    if (assetArgs.metadata == null) {
      Map metadata = defaultMetadata(name, txDict, "algorithm");
      metadata['algorithm'] = {
        'language': "python",
        'format': "docker-image",
        'version': "0.1",
        'container': {
          'entrypoint': "python \$ALGO",
          'image': image,
          'tag': tag,
          'checksum': checksum,
        },
      };
      assetArgs.metadata = metadata;
    }

    List<UrlFile> files = [UrlFile(url)];

    return createBundled(files, txDict, assetArgs);
  }

  Tuple createUrlAsset(String name,
      String url,
      Map txDict, {
        Map? metadata,
        // ... any other parameters that might replace *args and **kwargs
      }) {
    // Assuming AssetArguments and other related classes are already converted into Dart variants
    AssetArguments assetArgs = getAssetArguments(metadata, name, txDict);

    List<UrlFile> files = [UrlFile(url)];

    return createBundled(files, txDict, assetArgs);
  }

  Tuple createArweaveAsset(String name, String transactionId, Map txDict) {
    AssetArguments assetArgs = getArgsObject(
        AssetArguments, name: name, txDict: txDict);
    if (assetArgs.metadata == null) {
      assetArgs.metadata = OceanAssets.defaultMetadata(name, txDict);
    }

    List<ArweaveFile> files = [ArweaveFile(transactionId)];

    return createBundled(files, txDict, assetArgs);
  }

  Tuple createGraphqlAsset(String name, String url, String query, Map txDict) {
    AssetArguments assetArgs = getArgsObject(
        AssetArguments, name: name, txDict: txDict);
    if (assetArgs.metadata == null) {
      assetArgs.metadata = OceanAssets.defaultMetadata(name, txDict);
    }

    List<GraphqlQuery> files = [GraphqlQuery(url, query)];

    return createBundled(files, txDict, assetArgs);
  }

  Tuple createOnchainAsset(String name,
      String contractAddress,
      Map contractAbi,
      Map txDict, {
        bool waitForAqua = true,
        int? dtTemplateIndex = 1,
      }) {
    int chainId = _chainId;
    SmartContractCall onchainData = SmartContractCall(
        contractAddress, chainId, contractAbi);
    List<SmartContractCall> files = [onchainData];

    AssetArguments assetArgs = getArgsObject(
        AssetArguments, name: name, txDict: txDict);
    if (assetArgs.metadata == null) {
      assetArgs.metadata = OceanAssets.defaultMetadata(name, txDict);
    }

    return createBundled(files, txDict, assetArgs);
  }

  static Map defaultMetadata(String name, Map txDict,
      [String type = 'dataset']) {
    String address = getFromAddress(txDict);

    String dateCreated = DateTime.now().toIso8601String();
    Map metadata = {
      "created": dateCreated,
      "updated": dateCreated,
      "description": name,
      "name": name,
      "type": type,
      "author": address.substring(0, 7),
      "license": "CC0: Public Domain",
    };
    return metadata;
  }


  Tuple createBundled(List<FilesType> files, Map txDict,
      AssetArguments assetArgs) {
    String providerUri = DataServiceProvider.getUrl(_configDict);

    _assertDdoMetadata(assetArgs.metadata!);
    String name = assetArgs.metadata!["name"];
    DataNFTArguments dataNftArgs = DataNFTArguments(name, name);

    DatatokenArguments datatokenArgs;
    if (assetArgs.dtTemplateIndex == 2) {
      datatokenArgs = DatatokenArguments(
          "$name: DT1", files, templateIndex: 2, cap: toWei(100));
    } else {
      datatokenArgs = DatatokenArguments("$name: DT1", files);
    }

    dynamic dataNft;
    dynamic datatoken;
    if (assetArgs.pricingSchemaArgs == null) {
      var creationResult = dataNftFactory.createWithErc20(
          dataNftArgs, datatokenArgs, txDict);
      dataNft = creationResult.item1;
      datatoken = creationResult.item2;
    } else if (assetArgs.pricingSchemaArgs is DispenserArguments) {
      var creationResult = dataNftFactory.createWithErc20AndDispenser(
          dataNftArgs, datatokenArgs, assetArgs.pricingSchemaArgs, txDict);
      dataNft = creationResult.item1;
      datatoken = creationResult.item2;
    } else if (assetArgs.pricingSchemaArgs is ExchangeArguments) {
      var creationResult = dataNftFactory.createWithErc20AndFixedRate(
          dataNftArgs, datatokenArgs, assetArgs.pricingSchemaArgs, txDict);
      dataNft = creationResult.item1;
      datatoken = creationResult.item2;
    }

    DDO ddo = DDO();
    ddo.did = dataNft.calculateDid();

    if (_aquarius.ddoExists(ddo.did)) {
      throw AquariusError(
          "Asset id ${ddo.did} is already registered to another asset.");
    }

    ddo.chainId = _chainId;
    ddo.metadata = assetArgs.metadata;
    ddo.credentials = assetArgs.credentials;
    ddo.nftAddress = dataNft.address;

    AccessService accessService = datatoken.buildAccessService(
      "0",
      serviceEndpoint: providerUri,
      files: files,
    );
    ddo.addService(accessService);

    if (assetArgs.withCompute assetArgs.computeValues != null) {
      ddo.createComputeService(
        "1",
        providerUri,
        datatoken.address,
        files,
        assetArgs.computeValues,
      );
    }

    Tuple validation = validate(ddo);
    var proof = validation.item2;
    proof =
        Tuple4(proof["publicKey"], proof["v"], proof["r"][0], proof["s"][0]);

    var encryptionResult = _encryptDdo(ddo, providerUri, true, true);
    Uint8List document = encryptionResult.item1;
    Uint8List flags = encryptionResult.item2;
    Digest ddoHash = encryptionResult.item3;

    String walletAddress = getFromAddress(txDict);

    dataNft.setMetaData(
      0,
      providerUri,
      utf8.encode(walletAddress),
      flags,
      document,
      ddoHash.bytes,
      [proof],
      txDict,
    );

    if (assetArgs.waitForAqua == true) {
      ddo = _aquarius.waitForDdo(ddo.did);
    }

    return Tuple3(dataNft, datatoken, ddo);
  }

  DDO? create(
      Map metadata,
      Map txDict, {
        Map? credentials,
        String? dataNftAddress,
        DataNFTArguments? dataNftArgs,
        List<DatatokenBase>? deployedDatatokens,
        List? services,
        List<DatatokenArguments>? datatokenArgs,
        bool encryptFlag = true,
        bool compressFlag = true,
        bool waitForAqua = true,
      }) {
    _assertDdoMetadata(metadata);

    String providerUri = DataServiceProvider.getUrl(_configDict);

    DataNFT? dataNft;
    if (dataNftAddress == null) {
      dataNftArgs ??= DataNFTArguments(metadata["name"], metadata["name"]);
      dataNft = dataNftArgs.deployContract(_configDict, txDict);
      if (dataNft == null) {
        logger.w("Creating new NFT failed.");
        return null;
      }
      logger.i("Successfully created NFT with address ${dataNft.address}.");
    } else {
      dataNft = DataNFT(_configDict, dataNftAddress);
    }

    DDO ddo = DDO();

    ddo.did = dataNft.calculateDid();
    if (_aquarius.ddoExists(ddo.did)) {
      throw AquariusError("Asset id ${ddo.did} is already registered to another asset.");
    }
    ddo.chainId = _chainId;
    ddo.metadata = metadata;
    ddo.credentials = credentials ?? {"allow": [], "deny": []};
    ddo.nftAddress = dataNft.address;

    List<DatatokenBase> datatokens = [];
    services ??= [];

    if (deployedDatatokens == null) {
      for (DatatokenArguments dtArgs in datatokenArgs!) {
        DatatokenBase newDt = dtArgs.createDatatoken(dataNft, txDict, withServices: true);
        datatokens.add(newDt);
        services.addAll(dtArgs.services);
      }
      for (var service in services) {
        ddo.addService(service);
      }
    } else {
      datatokens = deployedDatatokens;
      if (services.isEmpty) {
        logger.w("Services required with deployedDatatokens.");
        return null;
      }

      List<String> dtAddresses = [];
      for (var datatoken in datatokens) {
        if (!dataNft.getTokensList().contains(datatoken.address)) {
          logger.w("Some deployedDatatokens don't belong to the given data NFT.");
          return null;
        }
        dtAddresses.add(datatoken.address);
      }

      for (var service in services) {
        if (!dtAddresses.contains(service.datatoken)) {
          logger.w("Datatoken services mismatch.");
          return null;
        }
        ddo.addService(service);
      }
    }

    Tuple validation = validate(ddo);
    dynamic proof = validation.item2;
    proof = Tuple4(proof["publicKey"], proof["v"], proof["r"][0], proof["s"][0]);

    Tuple3 encryptResult = _encryptDdo(ddo, providerUri, encryptFlag, compressFlag);
    Uint8List document = encryptResult.item1;
    Uint8List flags = encryptResult.item2;
    Digest ddoHash = encryptResult.item3;

    String walletAddress = getFromAddress(txDict);

    dataNft.setMetaData(
      0,
      providerUri,
      utf8.encode(walletAddress),
      flags,
      document,
      ddoHash.bytes,
      [proof],
      txDict,
    );

    if (waitForAqua) {
      ddo = _aquarius.waitForDdo(ddo.did);
    }

    return ddo;
  }

  DDO? update(
      DDO ddo,
      Map txDict, {
        String? providerUri,
        bool encryptFlag = true,
        bool compressFlag = true,
      }) {
    _assertDdoMetadata(ddo.metadata);

    providerUri ??= DataServiceProvider.getUrl(_configDict);

    if (ddo.nftAddress == null) {
      throw Exception("Need NFT address to update a DDO.");
    }

    if (ddo.chainId != _chainId) {
      throw Exception("DDO's chain ID does not match.");
    }

    for (var service in ddo.services) {
      service.encryptFiles(ddo.nftAddress, ddo.chainId);
    }

    var validation = validate(ddo);
    if (!validation.item1) {
      var msg = "DDO has validation errors: ${validation.item2}";
      logger.e(msg);
      throw ValueError(msg);
    }

    var encryptResult = _encryptDdo(ddo, providerUri, encryptFlag, compressFlag);
    var document = encryptResult.item1;
    var flags = encryptResult.item2;
    var ddoHash = encryptResult.item3;

    var proof = validation.item2; // assuming validation returns a proof-like structure.
    proof = Tuple4(proof["publicKey"], proof["v"], proof["r"][0], proof["s"][0]);

    var walletAddress = getFromAddress(txDict);

    var txResult = dataNft.setMetaData(
      0,
      providerUri,
      utf8.encode(walletAddress),
      flags,
      document,
      ddoHash.bytes,
      [proof],
      txDict,
    );

    var updatedDdo = _aquarius.waitForDdoUpdate(ddo, txResult.transactionHash.hex());
    return updatedDdo;
  }

  DDO resolve(String did) {
    return _aquarius.getDdo(did);
  }

  List<DDO> search(String text) {
    logger.i("Search for DDOs containing text: $text");
    var processedText = text.replaceAll(':', r'\:').replaceAll(r'\\:', r'\:');
    var response = _aquarius.querySearch({
      "query": {
        "query_string": {"query": processedText}
      }
    });

    return [
      DDO.fromDict(ddoDict["_source"])
      for (var ddoDict in response)
        if (ddoDict.containsKey("_source"))
    ];
  }

  List<DDO> query(Map query) {
    logger.i("Search for DDOs matching query: $query");
    var response = _aquarius.querySearch(query);

    return [
      DDO.fromDict(ddoDict["_source"])
      for (var ddoDict in response)
        if (ddoDict.containsKey("_source"))
    ];
  }

  String downloadAsset(
      DDO ddo,
      Wallet consumerWallet,
      String destination,
      dynamic orderTxId, {
        Service? service,
        int? index,
        Map? userdata,
      }) {
    service ??= ddo.services[0]; // Use the first service as a default.

    if (index != null) {
      if (index is! int) {
        throw Exception("Index has to be an integer.");
      }
      if (index < 0) {
        throw Exception("Index has to be 0 or a positive integer.");
      }
    }

    if (service == null service.type != ServiceTypes.assetAccess) {
      throw Exception("Service with type assetAccess not found.");
    }

    String path = downloadAssetFiles(
      ddo,
      service,
      consumerWallet,
      destination,
      orderTxId,
      index: index,
      userdata: userdata,
    );
    return path;
  }

  TransactionReceipt payForAccessService(
      DDO ddo,
      Map txDict, {
        Service? service,
        TokenFeeInfo? consumeMarketFees,
        String? consumerAddress,
        Map? userdata,
        int consumeMarketSwapFeeAmount = 0,
        String consumeMarketSwapFeeAddress = ZERO_ADDRESS,
      }) {
    // Use the first service as a default if no service is specified.
    service ??= ddo.services[0];
    var walletAddress = getFromAddress(txDict);
    consumerAddress ??= walletAddress;

    var consumableResult = isConsumable(
      ddo,
      service,
      {"type": "address", "value": walletAddress},
      userdata: userdata,
    );

    if (consumableResult != ConsumableCodes.OK) {
      throw AssetNotConsumable(consumableResult);
    }

    var dataProvider = DataServiceProvider();

    var initializeArgs = {
      "did": ddo.did,
      "service": service,
      "consumer_address": consumerAddress,
    };

    var initializeResponse = dataProvider.initialize(initializeArgs);
    var providerFees = initializeResponse.json()['providerFee'];

    var params = {
      "consumer": consumerAddress,
      "service_index": ddo.getIndexofService(service),
      "provider_fees": providerFees,
      "consume_market_fees": consumeMarketFees,
      "tx_dict": txDict,
    };

    // Main work...
    DatatokenBase dt = DatatokenBase.getTyped(_configDict, service.datatoken);
    var balance = dt.balanceOf(walletAddress);

    if (balance < toWei(1)) {
      try {
        params['consume_market_swap_fee_amount'] = consumeMarketSwapFeeAmount;
        params['consume_market_swap_fee_address'] = consumeMarketSwapFeeAddress;
        var receipt = dt.getFromPricingSchemaAndOrder(params);
      } catch (e) {
        TransactionReceipt? receipt;
        if (receipt != null) {
          return receipt;
        }

        throw InsufficientBalance(
            "Your token balance $balance ${dt.symbol()} is not sufficient "
                "to execute the requested service. This service requires 1 wei."
        );
      }
    }

    var receipt = dt.startOrder(params);
    return receipt.transactionHash;
  }

  Tuple2<List<ComputeInput>, ComputeInput?> payForComputeService(
      List<ComputeInput> datasets,
      dynamic algorithmData,
      String computeEnvironment,
      int validUntil,
      String consumeMarketOrderFeeAddress,
      Map txDict, {
        String? consumerAddress,
      }) {
    DataServiceProvider dataProvider = DataServiceProvider();
    String walletAddress = getFromAddress(txDict);
    consumerAddress ??= walletAddress;

    List<Map> datasetDicts = datasets.map((dataset) => dataset.asDictionary()).toList();
    Map algorithmDict;
    if (algorithmData is ComputeInput) {
      algorithmDict = algorithmData.asDictionary();
    } else if (algorithmData is AlgorithmMetadata) {
      algorithmDict = algorithmData.asDictionary();
    } else {
      throw TypeError("The algorithm_data must be of type ComputeInput or AlgorithmMetadata");
    }

    var initializeResponse = dataProvider.initializeCompute(
      datasetDicts,
      algorithmDict,
      datasets[0].service.serviceEndpoint,
      consumerAddress,
      computeEnvironment,
      validUntil,
    );

    var result = initializeResponse.json();
    for (int i = 0; i < result["datasets"].length; i++) {
      var item = result["datasets"][i];
      _startOrReuseOrderBasedOnInitializeResponse(
        datasets[i],
        item,
        TokenFeeInfo(
          consumeMarketOrderFeeAddress,
          datasets[i].consumeMarketOrderFeeToken,
          datasets[i].consumeMarketOrderFeeAmount,
        ),
        txDict,
        consumerAddress,
      );
    }

    ComputeInput? algorithmComputeInput;
    if (result.containsKey("algorithm")) {
      algorithmComputeInput = algorithmData is ComputeInput ? algorithmData : null;
      _startOrReuseOrderBasedOnInitializeResponse(
        algorithmData,
        result["algorithm"],
        TokenFeeInfo(
          consumeMarketOrderFeeAddress,
          algorithmData.consumeMarketOrderFeeToken,
          algorithmData.consumeMarketOrderFeeAmount,
        ),
        txDict,
        consumerAddress,
      );
    }

    return Tuple2(datasets, algorithmComputeInput);
  }

  void _startOrReuseOrderBasedOnInitializeResponse(
      ComputeInput assetComputeInput,
      Map item,
      TokenFeeInfo consumeMarketFees,
      Map txDict, {
        String? consumerAddress,
      }) {
    var providerFees = item["providerFee"];
    var validOrder = item["validOrder"];

    if (validOrder != null && providerFees == null) {
      assetComputeInput.transferTxId = validOrder;
      return;
    }

    Service service = assetComputeInput.service;
    DatatokenBase dt = DatatokenBase.getTyped(_configDict, service.datatoken);

    if (validOrder != null && providerFees != null) {
      assetComputeInput.transferTxId = dt.reuseOrder(
        validOrder,
        providerFees: providerFees,
        txDict: txDict,
      ).transactionHash.hex();
      return;
    }

    assetComputeInput.transferTxId = dt.startOrder(
      consumer: consumerAddress,
      serviceIndex: assetComputeInput.ddo.getIndexofService(service),
      providerFees: providerFees,
      consumeMarketFees: consumeMarketFees,
      txDict: txDict,
    ).transactionHash.hex();
  }

  List<int> compress(List<int> bytes) {
    // Use the `archive` package to compress the data.
    var encoder = ZLibEncoder();
    return encoder.encode(bytes);
  }

  Digest createChecksum(String input) {
    // Use the `crypto` package to create a checksum.
    return sha256.convert(utf8.encode(input));
  }

}