import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/practitioner_fhir.dart';
import '../widgets/widgets.dart';

class SelectPatient extends StatelessWidget {
  const SelectPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPractitioner practitioner = context.watch<AppPractitioner>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProfileData(
          practitionerName: "${practitioner.firstName} ${practitioner.lastName}",
          id: practitioner.id,
          role: practitioner.role,
          imgUrl: practitioner.imgUrl,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(
            left: 25,
            bottom: 10,
          ),
          child: Text(
            "Nuevo reporte",
            style: GoogleFonts.rubik(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
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
            style: GoogleFonts.rubik(
              fontSize: 16,
            ),
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
          route: "patientList",
        )
      ],
    );
  }
}
