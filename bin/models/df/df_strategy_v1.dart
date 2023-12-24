// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0
import 'package:web3dart/web3dart.dart';

import '../../web3_internal/contract_base.dart';

class DFStrategyV1 extends ContractBase {
  DFStrategyV1(
    Map<String, dynamic> configDict,
    EthereumAddress address,
  ) : super(
          contractName: "DFStrategyV1",
          configDict: configDict,
          address: address,
        );
}
