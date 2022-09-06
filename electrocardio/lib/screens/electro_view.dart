import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:photo_view/photo_view.dart';

class ElectroViewScreen extends StatelessWidget {
  const ElectroViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoView(
        imageProvider: NetworkImage(
            "https://i1.wp.com/electrocardiografia.wordpress.com/files/2008/11/ecg-2.png"));
  }
}
