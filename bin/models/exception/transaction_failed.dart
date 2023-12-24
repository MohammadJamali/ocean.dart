// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0

class TransactionFailed implements Exception {
  final String message;

  TransactionFailed(this.message);

  @override
  String toString() => 'TransactionFailed: $message';
}
