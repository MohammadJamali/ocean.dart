import '../ocean/util.dart';
import '../web3_internal/constants.dart';
import 'datatoken_base.dart';

class ExchangeArguments {
  late int rate;
  late String baseTokenAddress;
  String? ownerAddress;
  String? publishMarketFeeCollector;
  late int publishMarketFee;
  late String allowedSwapper;
  late bool fullInfo;
  int? dtDecimals;

  ExchangeArguments({
    required this.rate,
    required this.baseTokenAddress,
    this.ownerAddress,
    this.publishMarketFeeCollector,
    required this.publishMarketFee,
    this.allowedSwapper = 'ZERO_ADDRESS',
    this.fullInfo = false,
    this.dtDecimals,
  });

  List<dynamic> toTuple(Map<String, dynamic> configDict, Map<String, dynamic> txDict, {int? dtDecimals}) {
    final FREAddr = getAddressOfType(configDict, 'FixedPrice');

    ownerAddress ??= getFromAddress(txDict);
    publishMarketFeeCollector ??= getFromAddress(txDict);

    dtDecimals ??= this.dtDecimals;
    if (dtDecimals == null) {
      throw Exception('Must configure dt decimals either on arg creation or usage.');
    }

    final BT = DatatokenBase.getTyped(configDict, baseTokenAddress);

    return [
      FREAddr,
      [
        checksumAddr(BT.address),
        checksumAddr(ownerAddress),
        publishMarketFeeCollector,
        checksumAddr(allowedSwapper),
      ],
      [
        BT.decimals(),
        dtDecimals,
        rate,
        publishMarketFee,
        1, // with mint
      ],
    ];
  }
}

class ExchangeDetails {
  late String owner;
  late String datatoken;
  late int dtDecimals;
  late String baseToken;
  late int btDecimals;
  late int fixedRate;
  late bool active;
  late int dtSupply;
  late int btSupply;
  late int dtBalance;
  late int btBalance;
  late bool withMint;

  ExchangeDetails(List<dynamic> detailsTup) {
    final t = detailsTup;
    owner = t[0];
    datatoken = t[1];
    dtDecimals = t[2];
    baseToken = t[3];
    btDecimals = t[4];
    fixedRate = t[5];
    active = t[6];
    dtSupply = t[7];
    btSupply = t[8];
    dtBalance = t[9];
    btBalance = t[10];
    withMint = t[11];
  }
}

class ExchangeFeeInfo {
  late int publishMarketFee;
  late String publishMarketFeeCollector;
  late int opcFee;
  late int publishMarketFeeAvailable;
  late int oceanFeeAvailable;

  ExchangeFeeInfo(List<dynamic> feesTup) {
    final t = feesTup;
    publishMarketFee = t[0];
    publishMarketFeeCollector = t[1];
    opcFee = t[2];
    publishMarketFeeAvailable = t[3];
    oceanFeeAvailable = t[4];
  }
}

class BtNeeded {
  late int baseTokenAmount;
  late int oceanFeeAmount;
  late int publishMarketFeeAmount;
  late int consumeMarketFeeAmount;

  BtNeeded(List<dynamic> tup) {
    baseTokenAmount = tup[0];
    oceanFeeAmount = tup[1];
    publishMarketFeeAmount = tup[2];
    consumeMarketFeeAmount = tup[3];
  }
}

class BtReceived {
  late int baseTokenAmount;
  late int oceanFeeAmount;
  late int publishMarketFeeAmount;
  late int consumeMarketFeeAmount;

  BtReceived(List<dynamic> tup) {
    baseTokenAmount = tup[0];
    oceanFeeAmount = tup[1];
    publishMarketFeeAmount = tup[2];
    consumeMarketFeeAmount = tup[3];
  }
}

class FixedRateExchange extends ContractBase {
  static const String CONTRACT_NAME = 'FixedRateExchange';

  Future<String> getOpcCollector() async {
    final routerAddr = await router();
    final router = FactoryRouter(configDict, routerAddr);
    return router.getOPCCollector();
  }
}

class OneExchange {
  final FixedRateExchange _FRE;
  final int _id;

  OneExchange(this._FRE, this._id);

  FixedRateExchange get FRE => _FRE;
  int get exchangeId => _id;
  String get address => _FRE.address;

  Future<int> btNeeded(int dtAmt, int consumeMarketFee, bool fullInfo) async {
    final tup = await _FRE.calcBaseInGivenOutDT(_id, dtAmt, consumeMarketFee);
    final btNeededObj = BtNeeded(tup);
    if (fullInfo) {
      return btNeededObj;
    }
    return btNeededObj.baseTokenAmount;
  }

  Future<int> btReceived(int dtAmt, int consumeMarketFee, bool fullInfo) async {
    final tup = await _FRE.calcBaseOutGivenInDT(_id, dtAmt, consumeMarketFee);
    final btRecdObj = BtReceived(tup);
    if (fullInfo) {
      return btRecdObj;
    }
    return btRecdObj.baseTokenAmount;
  }

  Future<String> buyDT(int dtAmt, Map<String, dynamic> txDict,
      {int maxBaseTokenAmt = MAX_UINT256,
      String consumeMarketFeeAddr = ZERO_ADDRESS,
      int consumeMarketFee = 0}) async {
    final BT = DatatokenBase.getTyped(_FRE.configDict, (await details).baseToken);
    final buyerAddr = getFromAddress(txDict);

    final BTNeeded = await btNeeded(dtAmt, consumeMarketFee);
    if (BT.balanceOf(buyerAddr) < BTNeeded.baseTokenAmount) {
      throw ArgumentError('Not enough funds');
    }

    return _FRE.buyDT(
      _id,
      dtAmt,
      maxBaseTokenAmt,
      consumeMarketFeeAddr,
      consumeMarketFee,
      txDict,
    );
  }

  Future<String> sellDT(int dtAmt, Map<String, dynamic> txDict,
      {int minBaseTokenAmt = 0,
      String consumeMarketFeeAddr = ZERO_ADDRESS,
      int consumeMarketFee = 0}) async {
    return _FRE.sellDT(
      _id,
      dtAmt,
      minBaseTokenAmt,
      consumeMarketFeeAddr,
      consumeMarketFee,
      txDict,
    );
  }

  Future<String> collectBT(int amount, Map<String, dynamic> txDict) async {
    return _FRE.collectBT(_id, amount, txDict);
  }

  Future<String> collectDT(int amount, Map<String, dynamic> txDict) async {
    return _FRE.collectDT(_id, amount, txDict);
  }

  Future<String> collectPublishMarketFee(Map<String, dynamic> txDict) async {
    return _FRE.collectMarketFee(_id, txDict);
  }

  Future<String> collectOPCFee(Map<String, dynamic> txDict) async {
    return _FRE.collectOceanFee(_id, txDict);
  }

  Future<String> updatePublishMarketFeeCollector(String newAddr, Map<String, dynamic> txDict) async {
    return _FRE.updateMarketFeeCollector(_id, newAddr, txDict);
  }

  Future<String> updatePublishMarketFee(int newAmt, Map<String, dynamic> txDict) async {
    return _FRE.updateMarketFee(_id, newAmt, txDict);
  }

  Future<int> getPublishMarketFee() async {
    return _FRE.getMarketFee(_id);
  }

  Future<String> setRate(int newRate, Map<String, dynamic> txDict) async {
    return _FRE.setRate(_id, newRate, txDict);
  }

  Future<String> toggleActive(Map<String, dynamic> txDict) async {
    return _FRE.toggleExchangeState(_id, txDict);
  }

  Future<String> setAllowedSwapper(String newAddr, Map<String, dynamic> txDict) async {
    return _FRE.setAllowedSwapper(_id, newAddr, txDict);
  }

  Future<int> getRate() async {
    return _FRE.getRate(_id);
  }

  Future<int> getDtSupply() async {
    return _FRE.getDTSupply(_id);
  }

  Future<int> getBtSupply() async {
    return _FRE.getBTSupply(_id);
  }

  Future<String> getAllowedSwapper() async {
    return _FRE.getAllowedSwapper(_id);
  }

  ExchangeDetails get details => ExchangeDetails(await _FRE.getExchange(_id));

  ExchangeFeeInfo get exchangeFeesInfo => ExchangeFeeInfo(await _FRE.getFeesInfo(_id));

  Future<bool> isActive() async {
    return _FRE.isActive(_id);
  }
}
