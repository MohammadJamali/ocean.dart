import 'dart:io';

import '../agreements/consumable_codes.dart';
import '../ocean/ocean_compute.dart';
import '../services/service.dart';
import 'ddo/ddo.dart';

class DataServiceProvider {
  static bool checkAssetFileInfo(
      String did, String serviceId, String serviceEndpoint) {
    // Implement your logic to check asset file info.
    return true;
  }

  static void download({
    required String did,
    required Service service,
    required String txId,
    required Wallet consumerWallet,
    required String destinationFolder,
    int? index,
    Map<String, dynamic>? userdata,
  }) {
    // Implement your download logic.
  }
}

String downloadAssetFiles(
  DDO ddo,
  Service service,
  Wallet consumerWallet,
  String destination,
  String orderTxId, {
  int? index,
  Map<String, dynamic>? userdata,
}) {
  if (service.service_endpoint == null) {
    logger.severe(
        'Consume asset failed, service definition is missing the "serviceEndpoint".');
    throw AssertionError(
        'Consume asset failed, service definition is missing the "serviceEndpoint".');
  }

  if (index != null) {
    assert(index >= 0, 'index has to be 0 or a positive integer.');
  }

  final consumableResult = isConsumable(
    ddo,
    service,
    {'type': 'address', 'value': consumerWallet.address},
    userdata: userdata,
  );

  if (consumableResult != ConsumableCodes.OK) {
    throw AssetNotConsumable(consumableResult);
  }

  final serviceIndexInAsset = ddo.getIndexOfService(service);
  final assetFolder =
      Directory('${destination}/datafile.${ddo.did},${serviceIndexInAsset}');
  if (!assetFolder.existsSync()) {
    assetFolder.createSync(recursive: true);
  }

  DataServiceProvider.download(
    did: ddo.did,
    service: service,
    txId: orderTxId,
    consumerWallet: consumerWallet,
    destinationFolder: assetFolder.path,
    index: index,
    userdata: userdata,
  );

  return assetFolder.path;
}

int isConsumable(
  DDO ddo,
  Service service,
  Map<String, dynamic>? credential, {
  bool withConnectivityCheck = true,
  Map<String, dynamic>? userdata,
}) {
  if (ddo.is_disabled) {
    return ConsumableCodes.ASSET_DISABLED;
  }

  if (withConnectivityCheck &&
      !DataServiceProvider.checkAssetFileInfo(
          ddo.did, service.id, service.service_endpoint)) {
    return ConsumableCodes.CONNECTIVITY_FAIL;
  }

  if (ddo.requires_address_credential) {
    // Validate access with the credential.
    // Return appropriate ConsumableCodes based on validation.
  }

  return ConsumableCodes.OK;
}
