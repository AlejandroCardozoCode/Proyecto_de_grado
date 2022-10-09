import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:encrypt/encrypt.dart';

class ImageService {
  String _key = "D17F3622C00136307E4A75801F85B67F";
  ImageService();

  String convertToBase64(XFile image) {
    File imagePath = File(image.path);
    Uint8List bitImage = imagePath.readAsBytesSync();
    String base64Image = base64Encode(bitImage);
    return base64Image;
  }

  String encryptImage(XFile image) {
    String base64 = convertToBase64(image);
    final key = Key.fromUtf8(_key);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(base64, iv: iv);
    return encrypted.base64;
  }

  static String decryptImage(String image) {
    final key = Key.fromUtf8("D17F3622C00136307E4A75801F85B67F");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(image, iv: iv);
    return decrypted;
  }
}
