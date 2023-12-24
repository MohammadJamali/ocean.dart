// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0

class AssetNotConsumable implements Exception {
  final int consumableCode;

  AssetNotConsumable(this.consumableCode);
}
