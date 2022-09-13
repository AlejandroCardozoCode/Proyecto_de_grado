import 'package:electrocardio/widgets/card_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardReportElectro extends StatelessWidget {
  final String patientName;
  final String reportDate;
  final String textReport;
  final String textResume;

  const CardReportElectro(
      {Key? key,
      required this.patientName,
      required this.reportDate,
      required this.textReport,
      required this.textResume})
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
                    showAlert(context, textResume, "Resumen");
                  },
                  child: Text(
                    "Ver Resumen",
                    maxLines: 2,
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
                    showAlert(context, textReport, "Reporte");
                  },
                  child: Text(
                    "Ver Reporte",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.rubik(
                      fontSize: 14,
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
}
