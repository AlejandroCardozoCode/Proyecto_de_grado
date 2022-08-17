
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';

class ReportListScreen extends StatelessWidget {
   
  const ReportListScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/app_background.jpg"),
              fit: BoxFit.cover,
            ),
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: ListView(
        padding: const EdgeInsets.all(20),
        children:  [
          Text("Listado de reportes",
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(fontSize: 20, color: Colors.red), 
              ),
              const SizedBox(
                height: 20,
              ),
              const ElectroCardList()
        ],
      )
    )
    )
    );
  }
}