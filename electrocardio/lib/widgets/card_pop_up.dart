import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardPopUp extends StatelessWidget {
  final String text;
  final String tittle;
  const CardPopUp({Key? key, required this.text, required this.tittle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 50,
              ),
              FittedBox(
                child: Text(
                  tittle,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.rubik(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.rubik(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
