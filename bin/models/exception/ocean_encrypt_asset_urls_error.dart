// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0

class OceanEncryptAssetUrlsError implements Exception {
  final String message;

  OceanEncryptAssetUrlsError(this.message);

  @override
  String toString() => 'OceanEncryptAssetUrlsError: $message';
}
