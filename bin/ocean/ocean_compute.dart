import 'package:web3dart/web3dart.dart';

import '../agreements/consumable_codes.dart';
import '../aquarius/aquarius.dart';
import '../assets/ddo/ddo.dart';
import '../models/compute_input.dart';
import '../models/exception/asset_not_consumable.dart';
import '../services/service.dart';
import '../structures/algorithm_metadata.dart';

class OceanCompute {
  late Map<String, dynamic> _configDict;
  late DataServiceProvider _dataProvider;

  OceanCompute(this._configDict, DataServiceProvider dataProvider) {
    _dataProvider = dataProvider;
  }

  Future<String> start(
    Wallet consumerWallet,
    ComputeInput dataset,
    String computeEnvironment, [
    ComputeInput? algorithm,
    AlgorithmMetadata? algorithmMeta,
    Map? algoCustomData,
    List<ComputeInput> additionalDatasets = const [],
  ]) async {
    String metadataCacheUri = _configDict["METADATA_CACHE_URI"];
    DDO ddo = await Aquarius.getInstance(metadataCacheUri).getDDO(dataset.did);
    Service service = ddo.getServiceById(dataset.serviceId);
    assert(service.type == ServiceTypes.CLOUD_COMPUTE,
        "service at serviceId is not of type compute service.");

    int consumableResult = await ocean_computable.isConsumable(
      ddo,
      service,
      {"type": "address", "value": consumerWallet.address.hex},
      withConnectivityCheck: true,
    );
    if (consumableResult != ConsumableCodes.OK) {
      throw AssetNotConsumable(consumableResult);
    }

    // Start compute job
    var jobInfo = await _dataProvider.startComputeJob(
      dataset.service,
      consumerWallet,
      dataset,
      computeEnvironment,
      algorithm: algorithm,
      algorithmMeta: algorithmMeta,
      algorithmCustomData: algoCustomData,
      inputDatasets: additionalDatasets,
    );
    return jobInfo["jobId"];
  }

  Future<Map<String, dynamic>> status(
    DDO ddo,
    Service service,
    String jobId,
    Wallet wallet,
  ) async {
    Map<String, dynamic> jobInfo =
        await _dataProvider.computeJobStatus(ddo.did, jobId, service, wallet);
    jobInfo.update({
      "ok": jobInfo.containsKey("status") &&
          ![31, 32, null].contains(jobInfo["status"])
    });
    return jobInfo;
  }

  Future<Map<String, dynamic>> result(
    DDO ddo,
    Service service,
    String jobId,
    int index,
    Wallet wallet,
  ) async {
    Map<String, dynamic> result = await _dataProvider.computeJobResult(
        ddo.did, jobId, service, index, wallet);
    return result;
  }

  Future<Map<String, dynamic>> computeJobResultLogs(
    DDO ddo,
    Service service,
    String jobId,
    Wallet wallet, [
    String logType = "output",
  ]) async {
    Map<String, dynamic> result = await _dataProvider.computeJobResultLogs(
        ddo.did, jobId, service, wallet, logType);
    return result;
  }

  Future<Map<String, dynamic>> stop(
    DDO ddo,
    Service service,
    String jobId,
    Wallet wallet,
  ) async {
    Map<String, dynamic> jobInfo =
        await _dataProvider.stopComputeJob(ddo.did, jobId, service, wallet);
    jobInfo.update({
      "ok": jobInfo.containsKey("status") &&
          ![31, 32, null].contains(jobInfo["status"])
    });
    return jobInfo;
  }

  Future<List<dynamic>> getC2DEnvironments(
    String serviceEndpoint,
    int chainId,
  ) async {
    return _dataProvider.getC2DEnvironments(serviceEndpoint, chainId);
  }

  Future<dynamic> getFreeC2DEnvironment(
    String serviceEndpoint,
    int chainId,
  ) async {
    List environments = await getC2DEnvironments(serviceEndpoint, chainId);
    return environments.firstWhere((env) => env["priceMin"] == 0);
  }
}
