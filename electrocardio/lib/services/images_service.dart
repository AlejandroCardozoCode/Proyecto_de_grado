import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:encrypt/encrypt.dart';

import 'services.dart';

class ImageService {
  late String _key;
  ImageService() {}

  findKey() async {
    this._key = await obtainKey();
  }

  String convertToBase64(XFile image) {
    File imagePath = File(image.path);
    Uint8List bitImage = imagePath.readAsBytesSync();
    String base64Image = base64Encode(bitImage);
    return base64Image;
  }

  Future<String> encryptImage(XFile image) async {
    String base64 = convertToBase64(image);
    final key = Key.fromUtf8(this._key);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(base64, iv: iv);
    return encrypted.base64;
  }

  Future<String> decryptImage(String image) async {
    final key = Key.fromUtf8(this._key);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(image, iv: iv);
    return decrypted;
  }
}
