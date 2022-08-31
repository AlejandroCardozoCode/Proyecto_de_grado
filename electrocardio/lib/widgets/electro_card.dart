import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElectroCard extends StatefulWidget {
  ElectroCard({Key? key}) : super(key: key);

  @override
  State<ElectroCard> createState() => _ElectroCardState();
}

class _ElectroCardState extends State<ElectroCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(30),
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 325,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Image(
              image: AssetImage("assets/img/electro_placeholder.png"),
              fit: BoxFit.cover,
              height: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Tomar foto de electrocardiograma (EGC)",
              style: GoogleFonts.rubik(
                color: ThemeApp.appRed,
                fontSize: 15,
              ),
            ),
            Text(
              "Por favor, intente hacer la toma lo mejor posible",
              style: GoogleFonts.rubik(
                color: Colors.grey,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}