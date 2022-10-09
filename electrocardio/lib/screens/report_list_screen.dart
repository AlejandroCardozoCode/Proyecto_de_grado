import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';
import '../widgets/widgets.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({Key? key}) : super(key: key);

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
                "Aqui encontrara un listado de todos los reportes enviados junto con su respectivo analisis",
                textAlign: TextAlign.left,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: getChild(currentPractitioner),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getChild(AppPractitioner currentPractitioner) {
    if (currentPractitioner.diagnosticList.length > 0) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: currentPractitioner.diagnosticList.length,
        itemBuilder: (BuildContext context, int index) {
          return CardReportElectro(
            patientName: currentPractitioner.findPatientById(currentPractitioner.diagnosticList[index].patientIdReference)!.firstName,
            reportDate: currentPractitioner.diagnosticList[index].dateTime,
            textDiagnostic: currentPractitioner.diagnosticList[index].diagnostic,
            textObservation: currentPractitioner.findObservationById(currentPractitioner.diagnosticList[index].observationId)!.actualObservation,
            textpriority: currentPractitioner.diagnosticList[index].priority.substring(0, 3),
            imageData: currentPractitioner.diagnosticList[index].imageReference,
          );
        },
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
