import 'package:freezed_annotation/freezed_annotation.dart';

import '../../services/service.dart';
import '../credentials.dart';

part 'ddo.freezed.dart';
part 'ddo.g.dart';

@freezed
class DDO with _$DDO, AddressCredentialMixin {
  DDO._();
  factory DDO({
    String? did,
    @Default(['https://w3id.org/did/v1']) List<String> context,
    int? chainId,
    String? nftAddress,
    Map<String, dynamic>? metadata,
    @Default([]) List<Service> services,
    Map<String, List<Map<String, dynamic>>>? credentials,
    Map<String, dynamic>? nft,
    List<String>? datatokens,
    Map<String, dynamic>? event,
    Map<String, dynamic>? stats,
  }) = _DDO;

  bool get requiresAddressCredential {
    return requiresCredential(credentials!);
  }

  List<String> get allowedAddresses {
    return getAddressesOfClass(credentials!, accessClass: "allow");
  }

  List<String> get deniedAddresses {
    return getAddressesOfClass(credentials!, accessClass: "deny");
  }

  void addAddressToAllowList(String address) {
    addAddressToAccessClass(credentials!, address, accessClass: "allow");
  }

  void addAddressToDenyList(String address) {
    addAddressToAccessClass(credentials!, address, accessClass: "deny");
  }

  void removeAddressFromAllowList(String address) {
    removeAddressFromAccessClass(credentials!, address, accessClass: "allow");
  }

  void removeAddressFromDenyList(String address) {
    removeAddressFromAccessClass(credentials!, address, accessClass: "deny");
  }

  factory DDO.fromJson(Map<String, dynamic> json) => _$DDOFromJson(json);

  bool get isDisabled =>
      metadata == null || nft != null && ![0, 5].contains(nft!['state']);
}
