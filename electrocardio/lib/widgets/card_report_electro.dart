import 'package:electrocardio/widgets/card_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets.dart';

class CardReportElectro extends StatelessWidget {
  final String patientName;
  final String reportDate;
  final String textDiagnostic;
  final String textObservation;

  const CardReportElectro(
      {Key? key,
      required this.patientName,
      required this.reportDate,
      required this.textDiagnostic,
      required this.textObservation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Card(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
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
                  onPressed: () {
                    Navigator.pushNamed(context, "electroView");
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
                    showAlert(context, textObservation, "Observacion");
                  },
                  child: FittedBox(
                    child: Text(
                      "Ver\nObservacion",
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
                      showAlert(context, textDiagnostic, "Reporte");
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

  void showAlert(BuildContext context, String text, String tittle) =>
      showDialog(
        context: context,
        builder: (_) => CardPopUp(
          text: text,
          tittle: tittle,
        ),
      );
  void showAlert2(BuildContext context) => showDialog(
        context: context,
        builder: (_) => const AlertGlobal(
            alertText:
                "Aun no se ha generado el reporte para este electrocardiograma"),
      );
}
