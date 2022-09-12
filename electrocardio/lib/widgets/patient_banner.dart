import 'package:electrocardio/models/fhir/patient_fhir.dart';
import 'package:electrocardio/models/fhir/practitioner_fhir.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    AppPractitioner currentPractitioner = context.watch<AppPractitioner>();
    AppPatient currentPatient = context.watch<AppPatient>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          subtitle: Text(
            "Cedula: ${bannerPatient.id}",
            style: GoogleFonts.rubik(),
          ),
          title: Text(
            bannerPatient.firstName,
            style: GoogleFonts.rubik(),
          ),
          leading: Icon(
            Icons.person,
            color: ThemeApp.primary,
            size: 50,
          ),
          onTap: () {
            if (enableOnTap) {
              currentPatient.setPatient(bannerPatient);
              Navigator.pushNamed(context, "newReport");
            }
          },
        ),
      ),
    );
  }
}
