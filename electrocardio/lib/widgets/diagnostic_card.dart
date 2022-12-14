import 'package:electrocardio/models/fhir/app_fhir_clases.dart';
import 'package:electrocardio/widgets/card_pop_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/images_service.dart';
import 'widgets.dart';

class DiagnosticCard extends StatelessWidget {
  final String patientId;
  final String reportDate;
  final String textObservation;
  final String textPriority;
  final String imageData;
  final AppDiagnosticReport currentDiagnostic;

  const DiagnosticCard({
    Key? key,
    required this.patientId,
    required this.reportDate,
    required this.textObservation,
    required this.textPriority,
    required this.imageData,
    required this.currentDiagnostic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          getPriority(textPriority),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: 270,
            child: ListTile(
              leading: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image(
                  image: AssetImage("assets/img/electro_placeholder2.png"),
                ),
              ),
              title: Text(
                "Paciente: $patientId",
                style: GoogleFonts.rubik(),
              ),
              subtitle: Text(
                "Fecha: $reportDate",
                style: GoogleFonts.rubik(),
              ),
              onTap: () async {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: Color.fromARGB(99, 0, 0, 0),
                  builder: (context) {
                    return customProgressIndicator(text: "Cargando datos", asset: "assets/img/loading_heart.json");
                  },
                );
                ImageService imageService = ImageService();
                await imageService.findKey();
                String data = await compute(imageService.decryptImage, imageData);
                Uint8List decoded = Uint8List.fromList(data.codeUnits);
                ImageProvider image = Image.memory(decoded).image;
                currentDiagnostic.copy(this.currentDiagnostic);
                Navigator.of(context).pop();
                Navigator.pushNamed(context, "writeDiagnostic", arguments: {
                  'observationText': textObservation,
                  'imgData': image,
                });
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget getPriority(String priority) {
    if (priority == "TOP") {
      return Text(
        "Prioridad: Urgente",
        style: GoogleFonts.rubik(
          color: Colors.red,
          fontWeight: FontWeight.w500,
        ),
      );
    }
    if (priority == "MID") {
      return Text(
        "Prioridad: Media",
        style: GoogleFonts.rubik(
          color: Color.fromARGB(255, 234, 175, 0),
          fontWeight: FontWeight.w500,
        ),
      );
    }
    if (priority == "LOW") {
      return Text(
        "Prioridad: Baja",
        style: GoogleFonts.rubik(
          color: Colors.green,
          fontWeight: FontWeight.w500,
        ),
      );
    }

    return Container();
  }

  void showAlert(BuildContext context, String text, String tittle) => showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )),
        builder: (_) => CardPopUp(
          text: text,
          tittle: tittle,
        ),
      );

  void showAlert2(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: "Aun no se ha generado el reporte para este electrocardiograma"),
      );
}
