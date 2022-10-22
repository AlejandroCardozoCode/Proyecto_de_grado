import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';
import '../widgets/widgets.dart';

class DiagnosticListScreen extends StatelessWidget {
  const DiagnosticListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Listado de reportes",
                textAlign: TextAlign.left,
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Aquí encontrara un listado de todos los reportes pendientes que tiene que fueron asignado a usted, por favor responda en orden",
                textAlign: TextAlign.left,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: getChild(currentPractitioner),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getChild(AppPractitioner currentPractitioner) {
    if (currentPractitioner.diagnosticList.length > 0) {
      print(currentPractitioner.diagnosticList);
      return RefreshIndicator(
        onRefresh: () async {
          await currentPractitioner.generateDiagnosticCardio();
        },
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: currentPractitioner.diagnosticList.length,
          itemBuilder: (BuildContext context, int index) {
            return DiagnosticCard(
              patientId: currentPractitioner.diagnosticList[index].patientIdReference,
              reportDate: currentPractitioner.diagnosticList[index].dateTime,
              textObservation: currentPractitioner.findObservationById(currentPractitioner.diagnosticList[index].observationId)!.actualObservation,
              textPriority: currentPractitioner.diagnosticList[index].priority.substring(0, 3),
              imageData: currentPractitioner.diagnosticList[index].imageReference,
              currentDiagnostic: currentPractitioner.diagnosticList[index],
            );
          },
        ),
      );
    } else {
      return Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Text(
              "No cuenta con reportes en este momento",
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                fontSize: 20,
              ),
            ),
          ),
        ),
      );
    }
  }
}
