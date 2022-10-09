import 'package:electrocardio/models/fhir/observation_fhir.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/fhir/app_fhir_clases.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class WriteDiagnostic extends StatefulWidget {
  const WriteDiagnostic({Key? key}) : super(key: key);

  @override
  State<WriteDiagnostic> createState() => _WriteDiagnostic();
}

class _WriteDiagnostic extends State<WriteDiagnostic> {
  String diagnosticValue = "";
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppDiagosticReport currentDiagnostic = context.watch<AppDiagosticReport>();
    final w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Image(
              image: const AssetImage("assets/img/banner.png"),
              width: w * 0.8,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Diagnostico",
              textAlign: TextAlign.center,
              style: GoogleFonts.rubik(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: "Por favor escriba la informacion respectiva a el diagnostico del electrocardiograma",
                  controller: controller,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                diagnosticValue = controller.text;
                if (diagnosticValue.length < 40) {
                  showAlert(context);
                } else {
                  currentDiagnostic.diagnostic = diagnosticValue;
                  showSendDiagnostic(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeApp.appRed,
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

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (_) => AlertGlobal(alertText: "Se necesitan al menos 40 caracteres, usted a escrito ${controller.text.length}"),
      );

  void showSendDiagnostic(BuildContext context) => showDialog(
        context: context,
        builder: (_) => const AlertSendDiagnostic(),
      );
}
