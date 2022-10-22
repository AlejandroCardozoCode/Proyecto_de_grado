import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/app_fhir_clases.dart';

class PatientBanner extends StatelessWidget {
  final bool enableOnTap;
  final AppPatient bannerPatient;
  const PatientBanner({
    Key? key,
    required this.enableOnTap,
    required this.bannerPatient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPatient currentPatient = context.watch<AppPatient>();
    AppDiagnosticReport currentDiagnostic = context.watch<AppDiagnosticReport>();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          subtitle: Text(
            "Genero: ${bannerPatient.gender}",
            style: GoogleFonts.rubik(),
          ),
          title: Text(
            "Cedula: ${bannerPatient.id}",
            style: GoogleFonts.rubik(),
          ),
          leading: Icon(
            Icons.person,
            color: ThemeApp.primary,
            size: 50,
          ),
          onTap: () {
            if (enableOnTap) {
              currentPatient.copyPatient(bannerPatient);
              currentDiagnostic.resetValues();
              Navigator.pushNamed(context, "newReport");
            }
          },
        ),
      ),
    );
  }
}
