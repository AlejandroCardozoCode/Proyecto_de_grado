import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/fhir/app_fhir_clases.dart';
import 'custom_progress_indicator.dart';

class AlertSendDiagnostic extends StatelessWidget {
  const AlertSendDiagnostic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDiagosticReport currentDiagnostic = context.watch<AppDiagosticReport>();
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();
    return AlertDialog(
      title: const Text("Enviar diagnostico"),
      content: const Text(
          "Su Diagnostico sera enviado al doctor correspondiente que hizo la solicitud"),
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
          onPressed: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Color.fromARGB(99, 0, 0, 0),
              builder: (context) {
                return customProgressIndicator(text: "Enviando datos");
              },
            );
            currentDiagnostic.create();
            await currentDiagnostic.uploadToFirebase(currentDiagnostic.id);
            await currentPractitioner
                .removeDiagnosticFromList(currentDiagnostic);
            Navigator.of(context).pop();
            Navigator.pushNamedAndRemoveUntil(
                context, "homeCar", (route) => false);
          },
        ),
      ],
    );
  }
}
