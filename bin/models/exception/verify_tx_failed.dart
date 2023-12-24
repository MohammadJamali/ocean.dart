// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0

class VerifyTxFailed implements Exception {
  final String message;

  VerifyTxFailed(this.message);

  @override
  String toString() => 'VerifyTxFailed: $message';
}
