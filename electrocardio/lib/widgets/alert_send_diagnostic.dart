import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/fhir/app_fhir_clases.dart';

class AlertSendDiagnostic extends StatelessWidget {
  const AlertSendDiagnostic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDiagosticReport currentDiagnostic = context.watch<AppDiagosticReport>();
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();
    return AlertDialog(
      title: const Text("Enviar diagnostico"),
      content: const Text("Su Diagnostico sera enviado al doctor correspondiente que hizo la solicitud"),
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
            currentDiagnostic.create();
            log(currentDiagnostic.id);
            log(currentDiagnostic.diagnostic);
            currentDiagnostic.uploadToFirebase(currentDiagnostic.id);
            await currentPractitioner.generateDiagnosticCardio();
            Navigator.pushNamedAndRemoveUntil(context, "homeCar", (route) => false);
          },
        ),
      ],
    );
  }
}
