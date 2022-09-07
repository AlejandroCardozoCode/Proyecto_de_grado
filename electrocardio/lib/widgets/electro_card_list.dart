import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElectroCardList extends StatelessWidget {
  final String patientName;
  final String reportDate;

  const ElectroCardList(
      {Key? key, required this.patientName, required this.reportDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            child: ListTile(
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: w * 0.4,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "electroView");
                  },
                  child: Text(
                    "Ver electrocardiograma",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: w * 0.2,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Ver resumen",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: w * 0.2,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Ver reporte",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rubik(
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
