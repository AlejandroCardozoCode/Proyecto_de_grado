import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

import '../widgets/widgets.dart';

class ReportListScreen extends StatelessWidget {
  const ReportListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          children: [
            Text(
              "Listado de reportes",
              textAlign: TextAlign.left,
              style: GoogleFonts.rubik(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: w * 0.05,
            ),
            Text(
              "Aqui encontrara un listado de todos los reportes enviados junto con su respectivo analisis",
              textAlign: TextAlign.left,
              style: GoogleFonts.rubik(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const ElectroCardList(
              reportDate: '20 Agosto',
              patientName: 'Diego',
            ),
          ],
        ),
      ),
    );
  }
}
