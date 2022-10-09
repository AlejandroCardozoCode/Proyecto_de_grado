import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';

class ElectroViewScreen extends StatelessWidget {
  const ElectroViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return PhotoView(
      imageProvider: arguments["imageData"],
    );
  }
}
