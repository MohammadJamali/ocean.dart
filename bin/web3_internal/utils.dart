import 'dart:convert';
import 'dart:typed_data';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import 'clef.dart';

class Signature {
  final int v;
  final String r;
  final String s;

  Signature(this.v, this.r, this.s);
}

String to32ByteHex(int val) {
  return '0x${val.toRadixString(16).padLeft(64, '0')}';
}

Future<String> signWithClef(String messageHash, ClefAccount wallet) async {
  final messageHashBytes = keccakUtf8(messageHash);
  final hexMessageHash = bytesToHex(messageHashBytes, include0x: true);

  final response = await wallet.provider.makeRPCCall(
    'account_signData',
    ['data/plain', wallet.address, hexMessageHash],
  );

  if (response.statusCode == 200) {
    return json.decode(response.body)['result'];
  } else {
    throw Exception('Failed to sign with clef.');
  }
}

String signWithKey(String messageHash, EthPrivateKey privateKey) {
  final messageHashBytes = hexToBytes(messageHash);
  final signableMessage = Uint8List.fromList(
    Utf8Encoder().convert('\x19Ethereum Signed Message:\n32') +
        messageHashBytes,
  );
  final signature = privateKey.signToUint8List(keccak256(signableMessage));

  return bytesToHex(signature, include0x: true);
}

Signature splitSignature(Uint8List signature) {
  assert(
      signature.length == 65, 'Invalid signature length. Expected length 65.');

  final v = signature.last;
  final r = BigInt.from(signature.buffer.asByteData().getUint64(0));
  final s = BigInt.from(signature.buffer.asByteData().getUint64(32));

  int vCorrected;
  // In Ethereum, 'v' is expected to be 27 or 28 traditionally.
  if (v != 27 && v != 28) {
    vCorrected = 27 + (v % 2);
  } else {
    vCorrected = v;
  }

  // Create our Signature object, passing the BigInt 'r' and 's' as hex strings
  return Signature(vCorrected, '0x${r.toRadixString(16).padLeft(64, '0')}',
      '0x${s.toRadixString(16).padLeft(64, '0')}');
}

Future<(double, double)> getGasFees() async {
  final response =
      await http.get(Uri.parse('https://gasstation.polygon.technology/v2'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['fast'];
    return (
      EtherAmount.inWei(BigInt.parse(data['maxPriorityFee']))
          .getValueInUnit(EtherUnit.gwei),
      EtherAmount.inWei(BigInt.parse(data['maxFee']))
          .getValueInUnit(EtherUnit.gwei),
    );
  } else {
    throw Exception('Failed to get gas fees.');
  }
}
