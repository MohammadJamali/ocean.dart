// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0

class InsufficientBalance implements Exception {
  final String message;

  InsufficientBalance(this.message);

  @override
  String toString() => 'InsufficientBalance: $message';
}
