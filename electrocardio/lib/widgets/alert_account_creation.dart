import 'package:flutter/material.dart';

class AlertAccountCreation extends StatelessWidget {
  final String alertText;
  const AlertAccountCreation({Key? key, required this.alertText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Alerta"),
      content: Text(
        alertText,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        TextButton(
          child: const Text("Aceptar"),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
          },
        ),
      ],
    );
  }
}
