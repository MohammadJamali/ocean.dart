import 'package:web3dart/web3dart.dart';

import '../web3_internal/contract_base.dart';

abstract class ERC721TokenFactoryBase extends ContractBase {
  ERC721TokenFactoryBase({
    String? contractName,
    required Map<String, dynamic> configDict,
    required EthereumAddress address,
  }) : super(
          contractName: contractName ?? "ERC721TokenFactoryBase",
          configDict: configDict,
          address: address,
        );
}
