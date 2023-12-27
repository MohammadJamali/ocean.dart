import 'package:web3dart/web3dart.dart';

import '../web3_internal/contract_base.dart';

class FactoryRouter extends ContractBase {
  FactoryRouter(
    Map<String, dynamic> configDict,
    EthereumAddress address,
  ) : super(
          contractName: "FactoryRouter",
          configDict: configDict,
          address: address,
        );
}
