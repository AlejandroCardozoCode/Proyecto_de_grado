import 'dart:ffi';

import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfoCard extends StatelessWidget {
  final String name;
  final String lastName;
  final String email;
  final String address;
  final String birthDate;
  const ProfileInfoCard(
      {Key? key,
      required this.name,
      required this.lastName,
      required this.email,
      required this.address,
      required this.birthDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 30,
            left: 30,
            right: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$name $lastName",
                style: GoogleFonts.rubik(
                  fontSize: 20,
                  color: ThemeApp.appRed,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Email: ",
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    email,
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Direccion: ",
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    address,
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fecha Nacimiento: ",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    birthDate,
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
