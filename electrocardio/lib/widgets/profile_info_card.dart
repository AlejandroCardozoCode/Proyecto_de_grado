import 'dart:ffi';

import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/fhir/practitioner_fhir.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPractitioner practitioner = context.watch<AppPractitioner>();
    final w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: w,
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 30,
            left: 30,
            right: 30,
          ),
          child: FittedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${practitioner.firstName} ${practitioner.lastName}",
                  style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "Email: ",
                      style: GoogleFonts.rubik(),
                    ),
                    Text(
                      practitioner.email,
                      style: GoogleFonts.rubik(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Direccion: ",
                      style: GoogleFonts.rubik(),
                    ),
                    Text(
                      practitioner.address,
                      style: GoogleFonts.rubik(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Fecha Nacimiento: ",
                      style: GoogleFonts.rubik(),
                    ),
                    Text(
                      practitioner.birthDate,
                      style: GoogleFonts.rubik(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Especilaidad: ",
                      style: GoogleFonts.rubik(),
                    ),
                    Text(
                      practitioner.role,
                      style: GoogleFonts.rubik(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Genero: ",
                      style: GoogleFonts.rubik(),
                    ),
                    Text(
                      practitioner.gender,
                      style: GoogleFonts.rubik(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
