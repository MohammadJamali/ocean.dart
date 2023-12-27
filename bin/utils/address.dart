import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/pointycastle.dart';

Uint8List keccak({Uint8List? primitive, String? hexstr, String? text}) {
  Digest digest = Digest('SHA-3/256');
  Uint8List data = toBytes(
    value: primitive,
    hexstr: hexstr,
    text: text,
  );
  return digest.process(data);
}

Uint8List toBytes({dynamic value, String? hexstr, String? text}) {
  if (value is Uint8List) {
    return value;
  } else if (hexstr != null) {
    return hexToBytes(hexstr);
  } else if (text != null) {
    return Uint8List.fromList(utf8.encode(text));
  } else {
    throw ArgumentError('One of primitive, hexstr, or text must be provided.');
  }
}

Uint8List hexToBytes(String hex) {
  String cleanedHex = hex.replaceAll('0x', '');
  List<int> bytes = [];

  for (int i = 0; i < cleanedHex.length; i += 2) {
    String hexByte = cleanedHex.substring(i, i + 2);
    bytes.add(int.parse(hexByte, radix: 16));
  }

  return Uint8List.fromList(bytes);
}

bool isText(dynamic value) {
  return value is String;
}

bool isBytes(dynamic value) {
  return value is Uint8List;
}

bool isHexAddress(dynamic value) {
  RegExp hexAddressRegExp = RegExp(r"(0x)?[0-9a-fA-F]{40}");
  if (!isText(value)) {
    return false;
  }
  return hexAddressRegExp.hasMatch(value);
}

bool isBinaryAddress(dynamic value) {
  if (!isBytes(value)) {
    return false;
  } else if (value.length != 20) {
    return false;
  } else {
    return true;
  }
}

bool isAddress(dynamic value) {
  if (isHexAddress(value)) {
    if (_isChecksumFormatted(value)) {
      return isChecksumAddress(value);
    }
    return true;
  }

  if (isBinaryAddress(value)) {
    return true;
  }

  return false;
}

String toHex(dynamic value) {
  if (isText(value)) {
    return value;
  } else if (isBytes(value)) {
    return bytesToHex(value);
  } else {
    throw ArgumentError.value(
      value,
      'value' 'Value must be a string or bytes.',
    );
  }
}

String bytesToHex(Uint8List bytes) {
  return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
}

String add0xPrefix(String hexString) {
  return hexString.startsWith('0x') ? hexString : '0x$hexString';
}

String remove0xPrefix(String hexString) {
  return hexString.startsWith('0x') ? hexString.substring(2) : hexString;
}

bool isSameAddress(dynamic left, dynamic right) {
  if (!isAddress(left) || !isAddress(right)) {
    throw ArgumentError('Both values must be valid addresses');
  } else {
    return toNormalizedAddress(left) == toNormalizedAddress(right);
  }
}

String toNormalizedAddress(dynamic value) {
  String hexAddress = toHex(value).toLowerCase();
  if (isAddress(hexAddress)) {
    return hexAddress;
  } else {
    throw ArgumentError.value(
      value,
      'value',
      'Unknown format $value, attempted to normalize to $hexAddress',
    );
  }
}

String toCanonicalAddress(dynamic address) {
  return toNormalizedAddress(address);
}

bool isCanonicalAddress(dynamic address) {
  if (!isBytes(address) || address.length != 20) {
    return false;
  }
  return address == toCanonicalAddress(address);
}

String toChecksumAddress(dynamic value) {
  String normAddress = toNormalizedAddress(value);
  String addressHash = toHex(keccak(text: remove0xPrefix(normAddress)));
  String checksumAddress = add0xPrefix(
      normAddress.substring(2, 42).split('').asMap().entries.map((entry) {
    int i = entry.key;
    String char = entry.value;
    return int.parse(addressHash[i], radix: 16) > 7 ? char.toUpperCase() : char;
  }).join(''));
  return checksumAddress;
}

bool isChecksumAddress(dynamic value) {
  if (!isText(value)) {
    return false;
  }
  return value == toChecksumAddress(value);
}

bool isNumeric(String value) {
  final numericRegex = RegExp(r'^[0-9]+$');
  return numericRegex.hasMatch(value);
}

bool _isChecksumFormatted(String value) {
  String unprefixedValue = remove0xPrefix(value);
  return unprefixedValue.toLowerCase() != unprefixedValue &&
      unprefixedValue.toUpperCase() != unprefixedValue &&
      !isNumeric(value);
}

bool isChecksumFormattedAddress(dynamic value) {
  return isHexAddress(value) && _isChecksumFormatted(value);
}
