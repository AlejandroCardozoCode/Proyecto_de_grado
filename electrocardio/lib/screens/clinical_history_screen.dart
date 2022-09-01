import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class ClinicalHistoryScreen extends StatelessWidget {
  const ClinicalHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Text(
              "Resumen de la historia clinica del paciente",
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextField(
              hintText: "Resumen historia clinica",
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "reportList");
              },
              style: ElevatedButton.styleFrom(
                primary: ThemeApp.appRed,
              ),
              child: SizedBox(
                height: 50,
                width: 150,
                child: Center(
                  child: Text(
                    "Enviar",
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
