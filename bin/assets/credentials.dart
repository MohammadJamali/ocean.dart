import '../agreements/consumable_codes.dart';

mixin AddressCredentialMixin {
  List<String> getAddressesOfClass(
    Map<String, List<Map<String, dynamic>>> credentials, {
    String accessClass = "allow",
  }) {
    Map<String, dynamic>? addressEntry =
        getAddressEntryOfClass(credentials, accessClass: accessClass);
    if (addressEntry == null || !addressEntry.containsKey("values")) {
      throw MalformedCredential("No values key in the address credential.");
    }
    return (addressEntry["values"] as List<dynamic>)
        .cast<String>()
        .map((addr) => addr.toLowerCase())
        .toList();
  }

  bool requiresCredential(Map<String, List<Map<String, dynamic>>> credentials) {
    List<String> allowedAddresses =
        getAddressesOfClass(credentials, accessClass: "allow");
    List<String> deniedAddresses =
        getAddressesOfClass(credentials, accessClass: "deny");

    return allowedAddresses.isNotEmpty || deniedAddresses.isNotEmpty;
  }

  int validateAccess(
    Map<String, List<Map<String, dynamic>>> credentials, {
    Map<String, dynamic>? credential,
  }) {
    String? address = simplifyCredentialToAddress(credential);

    List<String> allowedAddresses =
        getAddressesOfClass(credentials, accessClass: "allow");
    List<String> deniedAddresses =
        getAddressesOfClass(credentials, accessClass: "deny");

    if (address == null && !requiresCredential(credentials)) {
      return ConsumableCodes.OK;
    }

    if (allowedAddresses.isNotEmpty &&
        !allowedAddresses.contains(address!.toLowerCase())) {
      return ConsumableCodes.CREDENTIAL_NOT_IN_ALLOW_LIST;
    }

    if (allowedAddresses.isEmpty &&
        deniedAddresses.contains(address!.toLowerCase())) {
      return ConsumableCodes.CREDENTIAL_IN_DENY_LIST;
    }

    return ConsumableCodes.OK;
  }

  void addAddressToAccessClass(
    Map<String, List<Map<String, dynamic>>> credentials,
    String address, {
    String accessClass = "allow",
  }) {
    address = address.toLowerCase();

    if (credentials.isEmpty || !credentials.containsKey(accessClass)) {
      credentials[accessClass] = [
        {
          "type": "address",
          "values": [address]
        }
      ];
      return;
    }

    Map<String, dynamic>? addressEntry =
        getAddressEntryOfClass(credentials, accessClass: accessClass);

    if (addressEntry == null) {
      credentials[accessClass]!.add({
        "type": "address",
        "values": [address]
      });
      return;
    }

    List<String> lcAddresses =
        getAddressesOfClass(credentials, accessClass: accessClass);

    if (!lcAddresses.contains(address)) {
      lcAddresses.add(address);
    }

    addressEntry["values"] = lcAddresses;
  }

  void removeAddressFromAccessClass(
    Map<String, List<Map<String, dynamic>>> credentials,
    String address, {
    String accessClass = "allow",
  }) {
    address = address.toLowerCase();

    if (credentials.isEmpty || !credentials.containsKey(accessClass)) {
      return;
    }

    Map<String, dynamic>? addressEntry =
        getAddressEntryOfClass(credentials, accessClass: accessClass);

    if (addressEntry == null) {
      return;
    }

    List<String> lcAddresses =
        getAddressesOfClass(credentials, accessClass: accessClass);

    if (!lcAddresses.contains(address)) {
      return;
    }

    lcAddresses.remove(address);
    addressEntry["values"] = lcAddresses;
  }

  Map<String, dynamic>? getAddressEntryOfClass(
    Map<String, List<Map<String, dynamic>>> credentials, {
    String accessClass = "allow",
  }) {
    List<Map<String, dynamic>?> entries = credentials[accessClass] ?? [];
    return entries.firstWhere((entry) => entry?["type"] == "address",
        orElse: () => null);
  }
}

class MalformedCredential implements Exception {
  final String message;

  MalformedCredential(this.message);
}

String? simplifyCredentialToAddress(Map<String, dynamic>? credential) {
  if (credential == null || !credential.containsKey("value")) {
    throw MalformedCredential("Received empty address.");
  }
  return credential["value"] as String?;
}
