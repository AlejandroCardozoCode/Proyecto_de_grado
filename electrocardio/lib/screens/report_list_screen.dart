import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              "Listado de reportes",
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
            const ElectroCardList(
              reportDate: '20 Agosto',
              patientName: 'Diego',
            )
          ],
        ),
      ),
    );
  }
}
