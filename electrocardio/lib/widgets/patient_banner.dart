import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PatientBanner extends StatelessWidget {
  final bool enableOnTap;
  final String name;
  final String id;
  const PatientBanner(
      {Key? key,
      required this.enableOnTap,
      required this.name,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          subtitle: Text(
            "Cedula: ${id}",
            style: GoogleFonts.rubik(),
          ),
          title: Text(
            name,
            style: GoogleFonts.rubik(),
          ),
          leading: Icon(
            Icons.person,
            color: ThemeApp.primary,
            size: 50,
          ),
          onTap: () {
            if (enableOnTap) Navigator.pushNamed(context, "newReport");
          },
        ),
      ),
    );
  }
}
