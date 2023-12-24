// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0
import 'package:web3dart/web3dart.dart';

import '../../web3_internal/contract_base.dart';

class VeFeeEstimate extends ContractBase {
  VeFeeEstimate(
    Map<String, dynamic> configDict,
    EthereumAddress address,
  ) : super(
          contractName: "veFeeEstimate",
          configDict: configDict,
          address: address,
        );
}
