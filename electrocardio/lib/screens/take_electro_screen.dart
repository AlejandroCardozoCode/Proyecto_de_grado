import 'package:electrocardio/models/fhir/diagnostic_report_fhir.dart';
import 'package:electrocardio/models/fhir/patient_fhir.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TakeElectroPictureScreen extends StatelessWidget {
  const TakeElectroPictureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPatient currentPatient = context.watch<AppPatient>();
    AppDiagnosticReport currentDiagnostic = context.watch<AppDiagnosticReport>();
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: ApplicationAppBar(
            darkIcons: true,
          ),
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
                TakeElectroPictureCard(),
                SizedBox(
                  height: w * 0.05,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (currentDiagnostic.imageReference == "") {
                      showAlert(context);
                    } else {
                      Navigator.pushNamed(context, "clinicalHistory");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeApp.appRed,
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

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: "No se ha tomado la foto del electrocardiograma"),
      );
}
