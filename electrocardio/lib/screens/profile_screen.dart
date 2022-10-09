import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/fhir/practitioner_fhir.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppPractitioner practitioner = context.watch<AppPractitioner>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 40,
            ),
            ClipOval(
              child: Image.memory(
                base64Decode(practitioner.imgUrl),
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            const ProfileInfoCard(),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeApp.appRed,
              ),
              child: SizedBox(
                height: 50,
                width: 150,
                child: Center(
                  child: Text(
                    "Cerrar Sesion",
                    style: GoogleFonts.rubik(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
