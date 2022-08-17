import 'package:electrocardio/theme/theme.dart';
import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewReportScreen extends StatelessWidget {
  const NewReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/app_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              ProfileData(),
              ElectroCard(),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "clinicalHistory");
                },
                style: ElevatedButton.styleFrom(
                  primary: ThemeApp.appRed,
                ),
                child: SizedBox(
                  height: 50,
                  width: 150,
                  child: Center(
                    child: Text(
                      "Continuar",
                      style: GoogleFonts.rubik(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
