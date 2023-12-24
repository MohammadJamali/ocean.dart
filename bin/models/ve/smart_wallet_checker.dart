// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0
import 'package:web3dart/src/credentials/address.dart';

import '../../web3_internal/contract_base.dart';

class SmartWalletChecker extends ContractBase {
  SmartWalletChecker(
    Map<String, dynamic> configDict,
    EthereumAddress address,
  ) : super(
          contractName: "SmartWalletChecker",
          configDict: configDict,
          address: address,
        );
}
