import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';

class SelectPatient extends StatelessWidget {
  const SelectPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ProfileData(),
            SizedBox(
              height: w * 0.1,
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 10,
              ),
              child: Text(
                "Nuevo reporte",
                style: GoogleFonts.rubik(
                  color: ThemeApp.appRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: Text(
                "Para crear un nuevo reporte por favor seleccione un paciente existente o ingrese un nuevo paciente al sistema",
                textAlign: TextAlign.center,
                style: GoogleFonts.rubik(),
              ),
            ),
            const CustomPatientBanner(
              icon: Icons.person_add,
              text: "Agregar un nuevo paciente",
              route: "newPatient",
            ),
            const CustomPatientBanner(
              icon: Icons.format_list_bulleted_sharp,
              text: "Seleccionar paciente",
              route: "login",
            )
          ],
        ),
      ),
    );
  }
}
