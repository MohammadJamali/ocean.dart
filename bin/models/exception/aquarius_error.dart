// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0

class AquariusError implements Exception {
  final String message;

  AquariusError(this.message);

  @override
  String toString() => 'AquariusError: $message';
}
