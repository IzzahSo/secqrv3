// ignore_for_file: always_declare_return_types, file_names

import 'package:encrypt/encrypt.dart' as encrypt;

class AESEncryption {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  encryptMsg(String text) => encrypter.encrypt(text, iv: iv);

  decryptMsg(encrypt.Encrypted text) => encrypter.decrypt(text, iv: iv);

  getCode(String encoded) => encrypt.Encrypted.fromBase64(encoded);
}
