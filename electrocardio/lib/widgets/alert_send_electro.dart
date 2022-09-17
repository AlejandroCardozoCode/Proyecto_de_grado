import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/fhir/app_fhir_clases.dart';

class AlertSendElectro extends StatelessWidget {
  const AlertSendElectro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppDiagosticReport currentDiagnostic = context.watch<AppDiagosticReport>();
    AppObservation currentObservation = context.watch<AppObservation>();
    AppPatient currentPatient = context.watch<AppPatient>();
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();

    return AlertDialog(
      title: const Text("Enviar reorte"),
      content: const Text(
          "Su reporte sera recivido por un cardiologo y sera respondido lo mas pronto posible"),
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
            var uuidObservation = Uuid().v1();
            var uuidDiagnostic = Uuid().v1();

            currentObservation.observationId = uuidObservation.toString();
            currentObservation.patientIdReference = currentPatient.id;
            currentObservation.practitionerIdReference = currentPractitioner.id;
            currentObservation.dateTime =
                "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
            // subir observacion a la lista de observaciones
            currentPractitioner.addObservation(currentObservation);

            currentDiagnostic.id = uuidDiagnostic.toString();
            currentDiagnostic.patientIdReference = currentPatient.id;
            currentDiagnostic.dateTime =
                "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
            currentDiagnostic.practitionerIdReferenceOnco =
                currentPractitioner.id;
            currentDiagnostic.practitionerIdReferenceCardio = "";
            currentDiagnostic.observationId = uuidObservation;
            currentDiagnostic.diagnostic = "";

            currentPractitioner.addDiagnostic(currentDiagnostic);
            Navigator.pushNamedAndRemoveUntil(
                context, "homeOnc", (route) => false);
          },
        ),
      ],
    );
  }
}
