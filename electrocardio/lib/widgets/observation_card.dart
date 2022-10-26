import 'dart:convert';

import 'package:electrocardio/widgets/card_pop_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/services.dart';
import 'widgets.dart';

class ObservationCard extends StatelessWidget {
  final String patientName;
  final String reportDate;
  final String textDiagnostic;
  final String textObservation;
  final String textpriority;
  final String imageData;

  const ObservationCard({
    Key? key,
    required this.patientName,
    required this.reportDate,
    required this.textDiagnostic,
    required this.textObservation,
    required this.textpriority,
    required this.imageData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Card(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          getPriority(textpriority),
          ListTile(
            leading: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image(
                image: AssetImage("assets/img/electro_placeholder2.png"),
              ),
            ),
            title: Text(
              "Paciente: $patientName",
              style: GoogleFonts.rubik(),
            ),
            subtitle: Text(
              "Fecha: $reportDate",
              style: GoogleFonts.rubik(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: w * 0.25,
                child: TextButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Color.fromARGB(99, 0, 0, 0),
                      builder: (context) {
                        return customProgressIndicator(text: "Generando imagen");
                      },
                    );
                    ImageService imageService = ImageService();
                    await imageService.findKey();
                    String data = await compute(imageService.decryptImage, imageData);
                    Uint8List decoded = Uint8List.fromList(data.codeUnits);
                    ImageProvider image = Image.memory(decoded).image;
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, "electroView", arguments: {'imageData': image});
                  },
                  child: Text(
                    "Ver\nImagen",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: w * 0.25,
                child: TextButton(
                  onPressed: () {
                    showAlert(context, textObservation, "Observación");
                  },
                  child: FittedBox(
                    child: Text(
                      "Ver\nObservación",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.rubik(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: w * 0.25,
                child: TextButton(
                  onPressed: () {
                    if (textDiagnostic.isEmpty) {
                      showAlert2(context);
                    } else {
                      showAlert(context, textDiagnostic, "Diagnostico");
                    }
                  },
                  child: FittedBox(
                    child: Text(
                      "Ver\nDiagnostico",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.rubik(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              )
            ],
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
