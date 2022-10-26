import 'dart:developer';

import 'package:flutter/material.dart';

class AlertGlobal extends StatelessWidget {
  final String alertText;
  String? title;
  bool? isScrollable;

  AlertGlobal({Key? key, required this.alertText, String? this.title, bool? this.isScrollable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this.isScrollable == null) {
      return AlertDialog(
        title: (this.title == null) ? Text("Alerta") : Text(this.title!),
        content: Text(
          alertText,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          TextButton(
            child: const Text("Aceptar"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    }
    return AlertDialog(
      title: (this.title == null) ? Text("Alerta") : Text(this.title!),
      content: SingleChildScrollView(
        child: Text(
          alertText,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        TextButton(
          child: const Text("Aceptar"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
