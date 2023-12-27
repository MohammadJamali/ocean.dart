// Copyright 2023 Ocean Protocol Foundation
// SPDX-License-Identifier: Apache-2.0

class InvalidUrlException implements Exception {
  final String message;

  InvalidUrlException(this.message);

  @override
  String toString() => 'InvalidUrlException: $message';
}
