import 'package:flutter/material.dart';

class AlertSendElectro extends StatelessWidget {
  const AlertSendElectro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enviar reorte"),
      content: const Text(
          "su reporte sera recivido por un cardiologo y sera respondido lo mas pronto posible"),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      actions: [
        TextButton(
          child: const Text("Volver"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text("Enviar"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
