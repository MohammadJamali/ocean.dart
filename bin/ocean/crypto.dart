import 'dart:convert';
import 'dart:typed_data';
import 'package:cryptography/cryptography.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';
import 'package:web3dart/web3dart.dart';

String calcSymKey(String baseStr) {
  var baseB = utf8.encode(baseStr); // bytes
  Digest sha256Digest = sha256;
  Uint8List hashB = sha256Digest.hashSync(baseB).bytes;
  var symKeyB = '${base64Url.encode(hashB).substring(0, 43)}='; // bytes
  return symKeyB;
}

Future<String> symEncrypt(String value, String symKey) async {
  var valueB = utf8.encode(value); // bytes
  var keyB = base64Url.decode(symKey); // bytes
  final key = SecretKey(keyB);
  final fernet = Fernet(key);
  final encrypter = Encrypter(fernet);

  final encrypted = await encrypter.encrypt(valueB);
  return encrypted.base64;
}

Future<String> symDecrypt(String valueEnc, String symKey) async {
  var valueEncB = base64Url.decode(valueEnc);
  var keyB = base64Url.decode(symKey); // bytes
  final key = SecretKey(keyB);
  final fernet = Fernet(key);
  final encrypter = Encrypter(fernet);

  final decrypted = await encrypter.decrypt(Encrypted(valueEncB), secretKey: key);
  return utf8.decode(decrypted);
}

String calcPubKey(String privKeyHex) {
  var privKeyBytes = hexToBytes(privKeyHex);
  var privKey = EthPrivateKey.fromHex(privKeyHex);
  return privKey.publicKey.toHex();
}

Future<String> asymEncrypt(String value, String pubKeyHex) async {
  var pubKeyBytes = hexToBytes(pubKeyHex);
  var valueB = utf8.encode(value);

  final algorithm = X25519();
  final publicKey = PublicKey(pubKeyBytes);
  final secretKey = await algorithm.newKeyFromSeed(valueB);
  final sharedSecret = await algorithm.sharedSecretKey(keyPair: secretKey, remotePublicKey: publicKey);

  final nonce = Nonce.randomBytes(12);
  final aesGcm = AesGcm.with256bits();
  final encrypted = await aesGcm.encrypt(
    valueB,
    secretKey: sharedSecret,
    nonce: nonce,
  );

  return '${nonce.hex}:${encrypted.mac.hex}:${hex.encode(encrypted.cipherText)}';
}

Future<String> asymDecrypt(String valueEnc, String privKeyHex) async {
  var parts = valueEnc.split(':');
  final nonce = Nonce(hexToBytes(parts[0]));
  final mac = Mac(hexToBytes(parts[1]));
  final encryptedBytes = hexToBytes(parts[2]);

  final privKeyBytes = hexToBytes(privKeyHex);
  final algorithm = X25519();
  final secretKey = await algorithm.newKeyFromSeed(privKeyBytes);
  final publicKey = PublicKey(secretKey.extractPublicKeyBytes());

  final sharedSecret = await algorithm.sharedSecretKey(keyPair: secretKey, remotePublicKey: publicKey);

  final aesGcm = AesGcm.with256bits();
  final decrypted = await aesGcm.decrypt(
    Encrypted(encryptedBytes, mac: mac),
    secretKey: sharedSecret,
    nonce: nonce,
  );

  return utf8.decode(decrypted);
}

// import 'dart:convert';
// import 'package:ecdsa/ecdsa.dart';
// import 'package:elliptic/elliptic.dart';
// import 'package:pointycastle/export.dart';
//
// String calcSymKey(String baseStr) {
//   var sha256 = SHA256Digest();
//   var hash = sha256.process(utf8.encode(baseStr));
//   var symKey = base64Encode(hash).substring(0, 43) + "=";
//   return symKey;
// }
//
// String symEncrypt(String value, String symKey) {
//   final key = base64Decode(symKey);
//   final encrypter = AESFastEngine();
//   final cipher = CBCBlockCipher(encrypter);
//   final params = ParametersWithIV(KeyParameter(key), [1, 2, 3, 4, 5, 6, 7, 8]);
//   cipher.init(true, params);
//
//   var paddedValue = PKCS7Padding().pad(utf8.encode(value));
//   var encrypted = cipher.process(paddedValue);
//   return base64Encode(encrypted);
// }
//
// String symDecrypt(String valueEnc, String symKey) {
//   final key = base64Decode(symKey);
//   final encrypter = AESFastEngine();
//   final cipher = CBCBlockCipher(encrypter);
//   final params = ParametersWithIV(KeyParameter(key), [1, 2, 3, 4, 5, 6, 7, 8]);
//   cipher.init(false, params);
//
//   var encrypted = base64Decode(valueEnc);
//   var decrypted = cipher.process(encrypted);
//
//   // Remove PKCS7 padding
//   var paddingLength = decrypted.last;
//   decrypted = decrypted.sublist(0, decrypted.length - paddingLength);
//
//   return utf8.decode(decrypted);
// }
//
// String calcPubKey(String privKey) {
//   final secp256k1 = ECCurve_secp256k1();
//   final domain = ECCurve_secp256k1();
//   final privateKey = ECPrivateKey(domain, BigInt.parse(privKey, radix: 16));
//   final publicKey = privateKey.publicKey;
//   return publicKey.Q.getEncoded(true).toString();
// }
//
// String asymEncrypt(String value, String pubKey) {
//   final domain = ECCurve_secp256k1();
//   final publicKey = ECPublicKey(domain, domain.curve.decodePoint(hex.decode(pubKey)));
//   final encrypter = publicKey.encrypt(utf8.encode(value), SecureRandom('Fortuna'));
//   return hex.encode(encrypter);
// }
//
// String asymDecrypt(String valueEncH, String privKeyHex) {
//   final domain = ECCurve_secp256k1();
//   final privateKey = ECPrivateKey(domain, BigInt.parse(privKeyHex, radix: 16));
//
//   // Extract the X, Y coordinates from the public key (it's part of the private key object)
//   final publicKey = privateKey.publicKey;
//
//   // Create a new ECDH (Elliptic Curve Diffie-Hellman) object
//   final ecdh = ECDH();
//
//   // Initialize with the private key for the local party and the public key from the remote party
//   ecdh.init(PrivateKeyParameter(privateKey), PublicKeyParameter(publicKey));
//
//   // Derive a shared secret
//   final sharedSecret = ecdh.calculateSecret();
//
//   // Convert the shared secret and use it to decrypt the ciphertext
//   final encrypter = CipherParametersWithIV(
//       KeyParameter(sharedSecret.bytes), null); // Assuming no IV is used for simplicity
//
//   // Now, use the encrypter to decrypt the ciphertext (valueEncH)
//   // This is where you would use the shared secret to decrypt the value.
//   // The actual decryption process might involve more steps depending on your setup.
//
//   // For this example, we'll just return the hex as a placeholder.
//   return valueEncH;
// }
//
