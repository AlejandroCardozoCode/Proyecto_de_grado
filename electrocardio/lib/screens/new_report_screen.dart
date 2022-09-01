import 'package:electrocardio/theme/theme.dart';
import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NewReportScreen extends StatelessWidget {
  const NewReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileData(),
              ElectroCard(),
              SizedBox(
                height: w * 0.05,
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
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
