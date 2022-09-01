import 'package:electrocardio/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileData extends StatefulWidget {
  ProfileData({Key? key}) : super(key: key);

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: w * 0.4,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              maxRadius: 50,
              backgroundImage: AssetImage("assets/img/profile_placeholder.png"),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nombre Doctor",
                  style: GoogleFonts.rubik(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ThemeApp.appRed,
                  ),
                ),
                Text(
                  "Especialidad",
                  style: GoogleFonts.rubik(
                    fontSize: 15,
                  ),
                ),
                Text(
                  "Identificacion",
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
