import 'package:electrocardio/models/fhir/diagnostic_report_fhir.dart';
import 'package:electrocardio/models/fhir/observation_fhir.dart';
import 'package:electrocardio/models/fhir/patient_fhir.dart';
import 'package:electrocardio/models/fhir/practitioner_fhir.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class NewReportScreen extends StatelessWidget {
  const NewReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPatient currentPatient = context.watch<AppPatient>();
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Image(
                  image: const AssetImage("assets/img/banner.png"),
                  width: w * 0.6,
                ),
                PatientBanner(
                  enableOnTap: false,
                  bannerPatient: currentPatient,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Paso 1 de de 2",
                  style: GoogleFonts.rubik(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElectroCard(),
                SizedBox(
                  height: w * 0.05,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "clinicalHistory");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: ThemeApp.appRed,
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 150,
                    child: Center(
                      child: Text(
                        "Continuar",
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
