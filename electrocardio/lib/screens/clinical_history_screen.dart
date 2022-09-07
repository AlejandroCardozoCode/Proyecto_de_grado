import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class ClinicalHistoryScreen extends StatelessWidget {
  const ClinicalHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Image(
              image: AssetImage("assets/img/banner.png"),
              width: w * 0.8,
            ),
            Text(
              "Paso 2 de de 2",
              style: GoogleFonts.rubik(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Detalles del electrocardiograma",
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextField(
              hintText:
                  "Por favor ingrese informacion relevante para el cardiologo",
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showSendElectroDialog(context);
              },
              style: ElevatedButton.styleFrom(
                primary: ThemeApp.appRed,
              ),
              child: SizedBox(
                height: 50,
                width: 150,
                child: Center(
                  child: Text(
                    "Enviar",
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void showSendElectroDialog(BuildContext context) => showDialog(
        context: context,
        builder: (_) => SendElectroDialog(),
      );
}
