import 'dart:io';
import 'dart:math';

import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'bin/assets/ddo/ddo.dart';
import 'bin/example_config.dart';
import 'bin/models/compute_input.dart';
import 'bin/models/datatoken_base.dart';
import 'bin/ocean/ocean.dart';
import 'bin/ocean/util.dart';
import 'bin/structures/file_objects.dart';
import 'bin/utils/logger.dart';

const rpc = 'https://polygon-mumbai.infura.io/v3/b000e8917a9cb914eaf1cb';

final keys = [
  // private key
  // public key '0x5C0E4d2C684D5A4B5cc55Af9Ae51D787c73F0504'
  '0x8529bc4d5fd4a119f14a21d63d0c406921a2936d5bd6e2c3ce9519574626fab4',
  // private key
  // public key '0xFb731033E89c4EA128c2025d3a23B170363BfBE0'
  '0x4832663da7ea20c475a50d0f898e6d22711d670f2a13f7bc0dc31d013fe64178'
];

Directory walletDirectory() {
  var basePath = Directory.current.path;
  basePath = joinAll([basePath, 'test', 'wallet']);

  final baseDirectory = Directory.fromUri(Uri.directory(basePath));
  return baseDirectory;
}

final directory = walletDirectory();

Future<void> createEvm() async {
  final rng = Random.secure();
  if (await directory.exists()) {
    await directory.delete(recursive: true);
  }
  await directory.create(recursive: true);

  for (var i = 0; i < keys.length; i++) {
    final wallet = Wallet.createNew(EthPrivateKey.fromHex(keys[i]), '', rng);
    await File(join(directory.path, 'wallet$i.json'))
        .writeAsString(wallet.toJson());

    logger.d('''
    PRIVATE_KEY $i=${bytesToHex(wallet.privateKey.privateKey)}
    ADDRESS $i=${bytesToHex(wallet.privateKey.encodedPublicKey)}
  ''');
  }
}

Future<Ocean> prepareOcean() async {
  final config = getOceanConfig(rpc);
  final ocean = Ocean(config);
  final oceanToken = ocean.oceanToken;

  var ethClient = getWeb3(rpc);
  for (var i = 0; i < keys.length; i++) {
    final wallet = Wallet.fromJson(
      await File(join(directory.path, 'wallet$i.json')).readAsString(),
      '',
    );
    EtherAmount balance = await ethClient.getBalance(wallet.privateKey.address);

    assert(balance.getInWei > BigInt.zero, '${keys[i]} needs MATIC');
    assert(oceanToken..walletBalance(wallet) > BigInt.zero, '${keys[i]} needs OCEAN');
  }

  return ocean;
}

void publishAlgorithm(Ocean ocean, String name, String url) {
  final data = ocean.assets
      .create_algo_asset(name, url, {"from": alice}, wait_for_aqua: true);
  final dataNft = data[0];
  final datatoken = data[1];
  final ddo = data[2];

  print('''
    Algorithm:
    data nft address = '${dataNft.address}'
    data token address = '${datatoken.address}'
    ddo did = '${ddo.did}'
  ''');
}

void publishUrlData(Ocean ocean, String name, String url) {
  final urlFile = UrlFile(url: url);
  final data = ocean.assets.create_url_asset(
    name,
    urlFile.url,
    {"from": alice},
    with_compute: true,
    wait_for_aqua: true,
  );
  final dataNft = data[0];
  final datatoken = data[1];
  final ddo = data[2];

  print('''
    Dataset:
    data nft address = '${dataNft.address}'
    data token address = '${datatoken.address}'
    ddo did = '${ddo.did}'
  ''');
}

void c2dLinkAlgoDataset(Ocean ocean, DDO DATA_ddo, DDO ALGO_ddo) {
  final computeService = DATA_ddo.services[1];
  computeService.add_publisher_trusted_algorithm(ALGO_ddo);
  DATA_ddo = ocean.assets.update(DATA_ddo, {"from": alice});
}

void grantAccess(Wallet alice, Wallet bob, DatatokenBase dataDatatoken,
    DatatokenBase algoDatatoken,) {
  dataDatatoken.mint(bob, toWei(5), {"from": alice});
  algoDatatoken.mint(bob, toWei(5), {"from": alice});
}

void startsFreeC2D(Ocean ocean, DDO DATA_ddo, DDO ALGO_ddo) {
  final DATA_did = DATA_ddo.did;
  final ALGO_did = ALGO_ddo.did;

  DATA_ddo = ocean.assets.resolve(DATA_did);
  ALGO_ddo = ocean.assets.resolve(ALGO_did);

  final computeService = DATA_ddo.services[1];
  final algoService = ALGO_ddo.services[0];
  final freeC2dEnv = ocean.compute.get_free_c2d_environment(
      computeService.service_endpoint, DATA_ddo.chain_id);

  final dataComputeInput = ComputeInput(DATA_ddo, computeService);
  final algoComputeInput = ComputeInput(ALGO_ddo, algoService);

  final datasetsAlgorithm = ocean.assets.pay_for_compute_service(
    datasets: [dataComputeInput],
    algorithm_data: algoComputeInput,
    consume_market_order_fee_address: bob.address,
    tx_dict: {"from": bob},
    compute_environment: freeC2dEnv["id"],
    valid_until:
        DateTime.now().add(Duration(days: 1)).millisecondsSinceEpoch ~/ 1000,
    consumer_address: freeC2dEnv["consumerAddress"],
  );

  assert(datasetsAlgorithm != null && datasetsAlgorithm[0] != null,
      'pay for dataset unsuccessful');
  assert(datasetsAlgorithm[1] != null, 'pay for algorithm unsuccessful');

  final job_id = ocean.compute.start(
    consumer_wallet: bob,
    dataset: datasetsAlgorithm[0],
    compute_environment: freeC2dEnv["id"],
    algorithm: datasetsAlgorithm[1],
  );

  print('Started compute job with id: $job_id');
}

void monitorAlgorithm(Ocean ocean, DDO DATA_ddo, Service computeService,
    String job_id, Wallet bob) {
  for (var i = 0; i < 200; i++) {
    final status = ocean.compute.status(DATA_ddo, computeService, job_id, bob);
    if (status['dateFinished'] != null && status['dateFinished'] > 0) {
      print('Job succeeded.');
      return;
    }
    sleep(Duration(seconds: 5));
  }
}

Future<void> main() async {
  if (await directory.exists()) {
    await createEvm();
  }

  final oceanInstance = prepareOcean();
  // publishUrlData(
  //   oceanInstance,
  //   "Branin dataset",
  //   "https://api.walltist.com/arts/art/05b4f85d-8cb1-4f55-84a3-eb9230f371e8",
  // );
  // publishAlgorithm(oceanInstance, '');
}
