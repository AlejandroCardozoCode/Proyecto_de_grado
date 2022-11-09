import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:encrypt/encrypt.dart';

import 'services.dart';

class ImageService {
  late String _key;
  ImageService() {}

  findKey() async {
    KeyService keyService = KeyService();
    this._key = await keyService.obtainKey();
  }
/*
  String convertToBase64(XFile image) {
    io.File imagePath = io.File(image.path);
    Uint8List bitImage = imagePath.readAsBytesSync();
    String base64Image = base64Encode(bitImage);
    return base64Image;
  }
  */

  String convertToBinary(XFile image) {
    io.File imagePath = io.File(image.path);
    String bitImage = String.fromCharCodes(imagePath.readAsBytesSync());
    return bitImage;
  }

  Future<String> encryptImage(XFile image) async {
    String blob = convertToBinary(image);
    final key = Key.fromUtf8(this._key);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(blob, iv: iv);
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
