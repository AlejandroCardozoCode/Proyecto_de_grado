import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPatientBanner extends StatelessWidget {
  final IconData icon;
  final String text;
  final String route;
  const CustomPatientBanner(
      {Key? key, required this.icon, required this.text, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(20),
        child: SizedBox(
          height: w * 0.3,
          child: Row(
            children: [
              SizedBox(
                width: w * 0.1,
              ),
              Icon(
                icon,
                color: ThemeApp.primary,
                size: 30,
              ),
              SizedBox(
                width: w * 0.1,
              ),
              Text(
                text,
                style: GoogleFonts.rubik(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
