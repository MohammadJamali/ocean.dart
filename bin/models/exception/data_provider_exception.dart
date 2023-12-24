// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0

class DataProviderException implements Exception {
  final String message;

  DataProviderException(this.message);

  @override
  String toString() => 'DataProviderException: $message';
}
