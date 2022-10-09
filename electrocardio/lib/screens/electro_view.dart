import 'dart:convert';

import 'package:electrocardio/services/images_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';

class ElectroViewScreen extends StatelessWidget {
  const ElectroViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    ImageService imageService = ImageService();
    return PhotoView(
      imageProvider: Image.memory(base64Decode(imageService.decryptImage(arguments["imageData"]))).image,
    );
  }
}
