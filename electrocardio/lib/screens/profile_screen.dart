import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const CircleAvatar(
              maxRadius: 70,
              backgroundImage: AssetImage("assets/img/profile_placeholder.png"),
            ),
            const SizedBox(
              height: 30,
            ),
            const ProfileInfoCard(
              address: 'calle 100',
              birthDate: '13-12-1998',
              email: 'dfjslfdjslf@gmial.com',
              lastName: 'Cardozo',
              name: 'Diego',
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: ThemeApp.appRed,
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
