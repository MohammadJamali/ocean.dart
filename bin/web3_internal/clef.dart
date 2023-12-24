import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

Future<List<ClefAccount>> getClefAccounts({
  required String uri,
  int timeout = 120,
}) async {
  final provider = Web3Client(uri, http.Client());

  final response = await provider.makeRPCCall('account_list', []);
  if (response['error'] != null) {
    throw ArgumentError(response['error']['message']);
  }

  final List<String> addresses = List<String>.from(response['result']);
  return addresses.map((address) => ClefAccount(address, provider)).toList();
}

class ClefAccount {
  final String address;
  final String? privateKey;
  final Web3Client provider;

  ClefAccount(this.address, this.provider, {this.privateKey});
}
