import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/fhir/app_fhir_clases.dart';
import 'custom_progress_indicator.dart';

class AlertSendObservation extends StatelessWidget {
  const AlertSendObservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDiagosticReport currentDiagnostic = context.watch<AppDiagosticReport>();
    AppObservation currentObservation = context.watch<AppObservation>();
    AppPatient currentPatient = context.watch<AppPatient>();
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();

    return AlertDialog(
      title: const Text("Enviar reorte"),
      content: const Text("Su reporte sera recivido por un cardiologo y sera respondido lo mas pronto posible"),
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
            var uuidObservation = Uuid().v1();

            showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor: Color.fromARGB(99, 0, 0, 0),
              builder: (context) {
                return customProgressIndicator(text: "Enviando datos");
              },
            );

            currentObservation.observationId = uuidObservation.toString();
            currentObservation.patientIdReference = currentPatient.id;
            currentObservation.practitionerIdReference = currentPractitioner.id;
            currentObservation.dateTime = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
            // subir observacion a la lista de observaciones
            currentObservation.create();
            await currentObservation.uploadToFirebase(currentObservation.observationId);
            currentPractitioner.addObservationToList(currentObservation);

            var uuidDiagnostic = Uuid().v1();
            currentDiagnostic.id = uuidDiagnostic.toString();
            currentDiagnostic.patientIdReference = currentPatient.id;
            currentDiagnostic.dateTime = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
            currentDiagnostic.practitionerIdReferenceOnco = currentPractitioner.id;
            currentDiagnostic.practitionerIdReferenceCardio = "";
            currentDiagnostic.observationId = uuidObservation;
            currentDiagnostic.diagnostic = "";
            currentDiagnostic.priority = currentDiagnostic.priority + uuidDiagnostic;
            currentDiagnostic.create();
            await currentDiagnostic.uploadToFirebase(currentDiagnostic.id);
            currentPractitioner.addDiagnosticToList(currentDiagnostic);

            Navigator.of(context).pop();
            Navigator.pushNamedAndRemoveUntil(context, "homeOnc", (route) => false);
          },
        ),
      ],
    );
  }
}